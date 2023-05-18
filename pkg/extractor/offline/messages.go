package offline

import (
	"bytes"
	"context"
	"fmt"
	"math/big"

	"github.com/filecoin-project/go-state-types/abi"
	"github.com/filecoin-project/lotus/chain/types"
	"github.com/ipfs/go-cid"
	"github.com/ipld/go-ipld-prime"
	"github.com/ipld/go-ipld-prime/codec/dagcbor"
	basicnode "github.com/ipld/go-ipld-prime/node/basic"
	"github.com/sirupsen/logrus"

	types2 "github.com/vulcanize/filecoin-indexing/pkg/extractor/types"
)

var _ types2.HistoricalExtractor = &MessageExtractor{}

type MessageExtractor struct {
	chainStore types2.ChainAccess
}

func NewMessageExtractor(chainStore types2.ChainAccess) *MessageExtractor {
	return &MessageExtractor{chainStore: chainStore}
}

func (m *MessageExtractor) StreamSegment(ctx context.Context, rng types2.Range, filter types2.Filter, args ...interface{}) (types2.Subscription, error) {
	var payloadChan <-chan types2.Payload
	var doneChan <-chan struct{}
	var errChan <-chan error
	var err error
	quitChan := make(chan struct{})
	if rng.Start.Height != nil && rng.Stop.Height != nil {
		payloadChan, doneChan, errChan = m.getMessagesByHeightsAsync(ctx, rng.Start.Height.Int64(), rng.Stop.Height.Int64(), quitChan, filter)
	} else if rng.Start.CID != nil && rng.Stop.CID != nil {
		payloadChan, doneChan, errChan, err = m.getMessagesByCIDsAsync(ctx, *rng.Start.CID, *rng.Stop.CID, quitChan, filter)
		if err != nil {
			return nil, err
		}
	} else {
		return nil, fmt.Errorf("expected either a height or a CID in the provided IDs")
	}
	return types2.NewSubscription(payloadChan, errChan, doneChan, quitChan), nil
}

func (m *MessageExtractor) Pull(ctx context.Context, at types2.HeightOrCID, filter types2.Filter, args ...interface{}) ([]types2.Payload, error) {
	if at.Height != nil {
		return m.getMessagesByHeight(ctx, at.Height.Int64(), filter)
	} else if at.CID != nil {
		return m.getMessagesByCID(ctx, *at.CID, filter)
	} else {
		return nil, fmt.Errorf("expected either a height or a CID in the provided ID")
	}
}

func (m *MessageExtractor) PullSegment(ctx context.Context, rng types2.Range, filter types2.Filter, args ...interface{}) ([]types2.Payload, error) {
	var payloads []types2.Payload
	var err error
	if rng.Start.Height != nil && rng.Stop.Height != nil {
		payloads, err = m.getMessagesByHeights(ctx, rng.Start.Height.Int64(), rng.Stop.Height.Int64(), filter)
		if err != nil {
			return nil, err
		}
	} else if rng.Start.CID != nil && rng.Stop.CID != nil {
		payloads, err = m.getMessagesByCIDs(ctx, *rng.Start.CID, *rng.Stop.CID, filter)
		if err != nil {
			return nil, err
		}
	} else {
		return nil, fmt.Errorf("expected either a height or a CID in the provided IDs")
	}

	return payloads, nil
}

func (m *MessageExtractor) getMessagesByCIDs(ctx context.Context, startCID, stopCID cid.Cid, filter types2.Filter) ([]types2.Payload, error) {
	startBlk, err := m.chainStore.ChainBlockstore().Get(ctx, startCID)
	if err != nil {
		return nil, err
	}
	startTSK := new(types.TipSetKey)
	if err := startTSK.UnmarshalCBOR(bytes.NewReader(startBlk.RawData())); err != nil {
		return nil, err
	}

	stopBlk, err := m.chainStore.ChainBlockstore().Get(ctx, stopCID)
	if err != nil {
		return nil, err
	}
	stopTSK := new(types.TipSetKey)
	if err := stopTSK.UnmarshalCBOR(bytes.NewReader(stopBlk.RawData())); err != nil {
		return nil, err
	}

	startTS, err := m.chainStore.LoadTipSet(ctx, *startTSK)
	if err != nil {
		return nil, err
	}
	stopTS, err := m.chainStore.LoadTipSet(ctx, *stopTSK)
	if err != nil {
		return nil, err
	}
	start, stop := int64(startTS.Height()), int64(stopTS.Height())
	return m.getMessagesByHeights(ctx, start, stop, filter)
}

func (m *MessageExtractor) getMessagesByCIDsAsync(ctx context.Context, startCID, stopCID cid.Cid, quit <-chan struct{}, filter types2.Filter) (<-chan types2.Payload, <-chan struct{}, <-chan error, error)  {
	startBlk, err := m.chainStore.ChainBlockstore().Get(ctx, startCID)
	if err != nil {
		return nil, nil, nil, err
	}
	startTSK := new(types.TipSetKey)
	if err := startTSK.UnmarshalCBOR(bytes.NewReader(startBlk.RawData())); err != nil {
		return nil, nil, nil, err
	}

	stopBlk, err := m.chainStore.ChainBlockstore().Get(ctx, stopCID)
	if err != nil {
		return nil, nil, nil, err
	}
	stopTSK := new(types.TipSetKey)
	if err := stopTSK.UnmarshalCBOR(bytes.NewReader(stopBlk.RawData())); err != nil {
		return nil, nil, nil, err
	}

	startTS, err := m.chainStore.LoadTipSet(ctx, *startTSK)
	if err != nil {
		return nil, nil, nil, err
	}
	stopTS, err := m.chainStore.LoadTipSet(ctx, *stopTSK)
	if err != nil {
		return nil, nil, nil, err
	}
	start, stop := int64(startTS.Height()), int64(stopTS.Height())
	if start > stop {
		return nil, nil, nil, fmt.Errorf("start epoch (%d) is above stop epoch (%d)", start, stop)
	}
	payloadChan, doneChan, errChan := m.getMessagesByHeightsAsync(ctx, start, stop, quit, filter)
	return payloadChan, doneChan, errChan, nil
}

func (m *MessageExtractor) getMessagesByHeights(ctx context.Context, start, stop int64, filter types2.Filter) ([]types2.Payload, error) {
	if start > stop {
		return nil, fmt.Errorf("start epoch (%d) is above stop epoch (%d)", start, stop)
	}
	payloads := make([]types2.Payload, 0, start - stop + 1) // TODO:
	for i := start; i <= stop; i++ {
		ts, err := m.chainStore.GetTipsetByHeight(ctx, abi.ChainEpoch(i), nil, false)
		if err != nil {
			return nil, err
		}
		tskCID, err := ts.Key().Cid()
		if err != nil {
			return nil, err
		}
		ps, err := m.getMessagesForTipSet(ctx, tskCID, ts, filter)
		if err != nil {
			return nil, err
		}
		payloads = append(payloads, ps...)
	}
	return payloads, nil
}

func (m *MessageExtractor) getMessagesByHeightsAsync(ctx context.Context, start, stop int64, quit <-chan struct{}, filter types2.Filter) (<-chan types2.Payload, <-chan struct{}, <-chan error) {
	errChan := make(chan error)
	payloadChan := make(chan types2.Payload)
	doneChan := make(chan struct{})
	go func() {
		defer close(doneChan)
		defer close(errChan)
		for i := start; i <= stop; i++ {
			select {
			case <-quit:
				return
			default:
			}
			ts, err := m.chainStore.GetTipsetByHeight(ctx, abi.ChainEpoch(i), nil, false)
			if err != nil {
				logrus.Error(err)
				errChan <- err
				continue
			}
			tskCID, err := ts.Key().Cid()
			if err != nil {
				logrus.Error(err)
				errChan <- err
				continue
			}
			ps, err := m.getMessagesForTipSet(ctx, tskCID, ts, filter)
			if err != nil {
				logrus.Error(err)
				errChan <- err
				continue
			}
			for _, payload := range ps {
				payloadChan <- payload
			}
		}
	}()

	return payloadChan, doneChan, errChan
}

func (m *MessageExtractor) getMessagesByCID(ctx context.Context, tskCID cid.Cid, filter types2.Filter) ([]types2.Payload, error) {
	// CID is the CID of the TipSetKey
	blk, err := m.chainStore.ChainBlockstore().Get(ctx, tskCID)
	if err != nil {
		return nil, err
	}
	tsk := new(types.TipSetKey)
	if err := tsk.UnmarshalCBOR(bytes.NewReader(blk.RawData())); err != nil {
		return nil, err
	}
	ts, err := m.chainStore.LoadTipSet(ctx, *tsk)
	if err != nil {
		return nil, err
	}
	return m.getMessagesForTipSet(ctx, tskCID, ts, filter)
}

func (m *MessageExtractor) getMessagesByHeight(ctx context.Context, height int64, filter types2.Filter) ([]types2.Payload, error) {
	ts, err := m.chainStore.GetTipsetByHeight(ctx, abi.ChainEpoch(height), nil, false)
	if err != nil {
		return nil, err
	}
	tskCID, err := ts.Key().Cid()
	if err != nil {
		return nil, err
	}
	return m.getMessagesForTipSet(ctx, tskCID, ts, filter)
}

func (m *MessageExtractor) getMessagesForTipSet(ctx context.Context, tskCID cid.Cid, ts *types.TipSet, filter types2.Filter) ([]types2.Payload, error) {
	// we want to associated each message with the specific block it was contained within
	payloads := make([]types2.Payload, 0, len(ts.Blocks()))
	b := bytes.NewBuffer(nil)
	for _, header := range ts.Blocks() {
		msgs, sigmsgs, err := m.chainStore.MessagesForBlock(ctx, header)
		if err != nil {
			return nil, err
		}
		iplds := make([]ipld.Node, 0, len(msgs) + len(sigmsgs))
		for _, msg := range msgs {
			na := basicnode.Prototype.Any.NewBuilder()
			if err := msg.MarshalCBOR(b); err != nil {
				return nil, err
			}
			if err := dagcbor.Decode(na, b); err != nil {
				return nil, err
			}
			b.Reset()
			node := na.Build()
			if filter != nil && !filter(node) {
				continue
			}
			iplds = append(iplds, node)
		}
		for _, msg := range sigmsgs {
			na := basicnode.Prototype.Any.NewBuilder()
			if err := msg.MarshalCBOR(b); err != nil {
				return nil, err
			}
			if err := dagcbor.Decode(na, b); err != nil {
				return nil, err
			}
			b.Reset()
			node := na.Build()
			if filter != nil && !filter(node) {
				continue
			}
			iplds = append(iplds, node)
		}
		payloads = append(payloads, types2.Payload{
			IPLDs:      iplds,
			For:        types2.HeightOrCID{
				Height: big.NewInt(int64(ts.Height())),
				CID: &tskCID,
			},
			ParentCIDs: map[string][]cid.Cid{"parent_tip_set_key_cid" : {tskCID}, "block_cid" : {header.Cid()}},
		})
	}

	return payloads, nil
}
