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

var _ types2.HistoricalExtractor = &ReceiptExtractor{}

type ReceiptExtractor struct {
	chainStore types2.ChainAccess
	stateStore types2.StateAccess
}

func NewReceiptExtractor(chainStore types2.ChainAccess, stateStore types2.StateAccess) *ReceiptExtractor {
	return &ReceiptExtractor{chainStore: chainStore, stateStore: stateStore}
}

func (r *ReceiptExtractor) StreamSegment(ctx context.Context, rng types2.Range, filter types2.Filter, args ...interface{}) (types2.Subscription, error) {
	var payloadChan <-chan types2.Payload
	var doneChan <-chan struct{}
	var errChan <-chan error
	var err error
	quitChan := make(chan struct{})
	if rng.Start.Height != nil && rng.Stop.Height != nil {
		payloadChan, doneChan, errChan = r.getReceiptsByHeightsAsync(ctx, rng.Start.Height.Int64(), rng.Stop.Height.Int64(), quitChan, filter)
	} else if rng.Start.CID != nil && rng.Stop.CID != nil {
		payloadChan, doneChan, errChan, err = r.getReceiptsByCIDsAsync(ctx, *rng.Start.CID, *rng.Stop.CID, quitChan, filter)
		if err != nil {
			return nil, err
		}
	} else {
		return nil, fmt.Errorf("expected either a height or a CID in the provided IDs")
	}
	return types2.NewSubscription(payloadChan, errChan, doneChan, quitChan), nil
}

func (r *ReceiptExtractor) Pull(ctx context.Context, at types2.HeightOrCID, filter types2.Filter, args ...interface{}) ([]types2.Payload, error) {
	if at.Height != nil {
		return r.getReceiptsByHeight(ctx, at.Height.Int64(), filter)
	} else if at.CID != nil {
		return r.getReceiptsByCID(ctx, *at.CID, filter)
	} else {
		return nil, fmt.Errorf("expected either a height or a CID in the provided ID")
	}
}

func (r *ReceiptExtractor) PullSegment(ctx context.Context, rng types2.Range, filter types2.Filter, args ...interface{}) ([]types2.Payload, error) {
	var payloads []types2.Payload
	var err error
	if rng.Start.Height != nil && rng.Stop.Height != nil {
		payloads, err = r.getReceiptsByHeights(ctx, rng.Start.Height.Int64(), rng.Stop.Height.Int64(), filter)
		if err != nil {
			return nil, err
		}
	} else if rng.Start.CID != nil && rng.Stop.CID != nil {
		payloads, err = r.getReceiptsByCIDs(ctx, *rng.Start.CID, *rng.Stop.CID, filter)
		if err != nil {
			return nil, err
		}
	} else {
		return nil, fmt.Errorf("expected either a height or a CID in the provided IDs")
	}

	return payloads, nil
}

func (r *ReceiptExtractor) getReceiptsByCIDs(ctx context.Context, startCID, stopCID cid.Cid, filter types2.Filter) ([]types2.Payload, error) {
	startBlk, err := r.chainStore.ChainBlockstore().Get(ctx, startCID)
	if err != nil {
		return nil, err
	}
	startTSK := new(types.TipSetKey)
	if err := startTSK.UnmarshalCBOR(bytes.NewReader(startBlk.RawData())); err != nil {
		return nil, err
	}

	stopBlk, err := r.chainStore.ChainBlockstore().Get(ctx, stopCID)
	if err != nil {
		return nil, err
	}
	stopTSK := new(types.TipSetKey)
	if err := stopTSK.UnmarshalCBOR(bytes.NewReader(stopBlk.RawData())); err != nil {
		return nil, err
	}

	startTS, err := r.chainStore.LoadTipSet(ctx, *startTSK)
	if err != nil {
		return nil, err
	}
	stopTS, err := r.chainStore.LoadTipSet(ctx, *stopTSK)
	if err != nil {
		return nil, err
	}
	start, stop := int64(startTS.Height()), int64(stopTS.Height())
	return r.getReceiptsByHeights(ctx, start, stop, filter)
}

func (r *ReceiptExtractor) getReceiptsByCIDsAsync(ctx context.Context, startCID, stopCID cid.Cid, quit <-chan struct{}, filter types2.Filter) (<-chan types2.Payload, <-chan struct{}, <-chan error, error) {
	startBlk, err := r.chainStore.ChainBlockstore().Get(ctx, startCID)
	if err != nil {
		return nil, nil, nil, err
	}
	startTSK := new(types.TipSetKey)
	if err := startTSK.UnmarshalCBOR(bytes.NewReader(startBlk.RawData())); err != nil {
		return nil, nil, nil, err
	}

	stopBlk, err := r.chainStore.ChainBlockstore().Get(ctx, stopCID)
	if err != nil {
		return nil, nil, nil, err
	}
	stopTSK := new(types.TipSetKey)
	if err := stopTSK.UnmarshalCBOR(bytes.NewReader(stopBlk.RawData())); err != nil {
		return nil, nil, nil, err
	}

	startTS, err := r.chainStore.LoadTipSet(ctx, *startTSK)
	if err != nil {
		return nil, nil, nil, err
	}
	stopTS, err := r.chainStore.LoadTipSet(ctx, *stopTSK)
	if err != nil {
		return nil, nil, nil, err
	}
	start, stop := int64(startTS.Height()), int64(stopTS.Height())
	if start > stop {
		return nil, nil, nil, fmt.Errorf("start epoch (%d) is above stop epoch (%d)", start, stop)
	}
	payloadChan, doneChan, errChan := r.getReceiptsByHeightsAsync(ctx, start, stop, quit, filter)
	return payloadChan, doneChan, errChan, nil
}

func (r *ReceiptExtractor) getReceiptsByHeights(ctx context.Context, start, stop int64, filter types2.Filter) ([]types2.Payload, error) {
	if start > stop {
		return nil, fmt.Errorf("start epoch (%d) is above stop epoch (%d)", start, stop)
	}
	payloads := make([]types2.Payload, 0, start-stop+1) // TODO:
	for i := start; i <= stop; i++ {
		ts, err := r.chainStore.GetTipsetByHeight(ctx, abi.ChainEpoch(i), nil, false)
		if err != nil {
			return nil, err
		}
		tskCID, err := ts.Key().Cid()
		if err != nil {
			return nil, err
		}
		ps, err := r.getReceiptsForTipSet(ctx, tskCID, ts, filter)
		if err != nil {
			return nil, err
		}
		payloads = append(payloads, ps...)
	}
	return payloads, nil
}

func (r *ReceiptExtractor) getReceiptsByHeightsAsync(ctx context.Context, start, stop int64, quit <-chan struct{}, filter types2.Filter) (<-chan types2.Payload, <-chan struct{}, <-chan error) {
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
			ts, err := r.chainStore.GetTipsetByHeight(ctx, abi.ChainEpoch(i), nil, false)
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
			ps, err := r.getReceiptsForTipSet(ctx, tskCID, ts, filter)
			for _, payload := range ps {
				payloadChan <- payload
			}
		}
	}()

	return payloadChan, doneChan, errChan
}

func (r *ReceiptExtractor) getReceiptsByCID(ctx context.Context, tskCID cid.Cid, filter types2.Filter) ([]types2.Payload, error) {
	// CID is the CID of the TipSetKey
	blk, err := r.chainStore.ChainBlockstore().Get(ctx, tskCID)
	if err != nil {
		return nil, err
	}
	tsk := new(types.TipSetKey)
	if err := tsk.UnmarshalCBOR(bytes.NewReader(blk.RawData())); err != nil {
		return nil, err
	}
	ts, err := r.chainStore.LoadTipSet(ctx, *tsk)
	if err != nil {
		return nil, err
	}
	return r.getReceiptsForTipSet(ctx, tskCID, ts, filter)
}

func (r *ReceiptExtractor) getReceiptsByHeight(ctx context.Context, height int64, filter types2.Filter) ([]types2.Payload, error) {
	ts, err := r.chainStore.GetTipsetByHeight(ctx, abi.ChainEpoch(height), nil, false)
	if err != nil {
		return nil, err
	}
	tskCID, err := ts.Key().Cid()
	if err != nil {
		return nil, err
	}
	return r.getReceiptsForTipSet(ctx, tskCID, ts, filter)
}

func (r *ReceiptExtractor) getReceiptsForTipSet(ctx context.Context, tskCID cid.Cid, ts *types.TipSet, filter types2.Filter) ([]types2.Payload, error) {
	// we want to associated each message with the specific block it was contained within
	payloads := make([]types2.Payload, 0, len(ts.Blocks()))
	b := bytes.NewBuffer(nil)
	for _, header := range ts.Blocks() {
		msgs, sigmsgs, err := r.chainStore.MessagesForBlock(ctx, header)
		if err != nil {
			return nil, err
		}
		iplds := make([]ipld.Node, 0, len(msgs)+len(sigmsgs))
		messageCIDs := make([]cid.Cid, 0, len(msgs)+len(sigmsgs))
		for _, msg := range msgs {
			msgLookup, err := r.stateStore.StateSearchMsg(ctx, ts.Key(), msg.Cid(), abi.ChainEpoch(-1), true)
			if err != nil {
				return nil, err
			}
			receipt := msgLookup.Receipt
			na := basicnode.Prototype.Any.NewBuilder()
			if err := receipt.MarshalCBOR(b); err != nil {
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
			messageCIDs = append(messageCIDs, msg.Cid())
		}
		for _, msg := range sigmsgs {
			msgLookup, err := r.stateStore.StateSearchMsg(ctx, ts.Key(), msg.Cid(), abi.ChainEpoch(-1), true)
			if err != nil {
				return nil, err
			}
			receipt := msgLookup.Receipt
			na := basicnode.Prototype.Any.NewBuilder()
			if err := receipt.MarshalCBOR(b); err != nil {
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
			messageCIDs = append(messageCIDs, msg.Cid())
		}
		payloads = append(payloads, types2.Payload{
			IPLDs: iplds,
			For: types2.HeightOrCID{
				Height: big.NewInt(int64(ts.Height())),
				CID:    &tskCID,
			},
			ParentCIDs: []types2.CIDs{{ID: "parent_tip_set_key_cid", CIDs: []cid.Cid{tskCID}}, {ID: "message_cid", CIDs: messageCIDs}},
		})
	}

	return payloads, nil
}
