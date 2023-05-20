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

var _ types2.HistoricalExtractor = &HeaderExtractor{}

type HeaderExtractor struct {
	chainStore types2.ChainAccess
}

func NewHeaderExtractor(cs types2.ChainAccess) *HeaderExtractor {
	return &HeaderExtractor{chainStore: cs}
}

func (h *HeaderExtractor) StreamSegment(ctx context.Context, rng types2.Range, filter types2.Filter, args ...interface{}) (types2.Subscription, error) {
	var payloadChan <-chan types2.Payload
	var doneChan <-chan struct{}
	var errChan <-chan error
	var err error
	quitChan := make(chan struct{})
	if rng.Start.Height != nil && rng.Stop.Height != nil {
		payloadChan, doneChan, errChan = h.getHeadersByHeightsAsync(ctx, rng.Start.Height.Int64(), rng.Stop.Height.Int64(), quitChan, filter)
	} else if rng.Start.CID != nil && rng.Stop.CID != nil {
		payloadChan, doneChan, errChan, err = h.getHeadersByTipSetCIDsAsync(ctx, *rng.Start.CID, *rng.Stop.CID, quitChan, filter)
		if err != nil {
			return nil, err
		}
	} else {
		return nil, fmt.Errorf("expected either a height or a CID in the provided IDs")
	}
	return types2.NewSubscription(payloadChan, errChan, doneChan, quitChan), nil
}

func (h *HeaderExtractor) Pull(ctx context.Context, at types2.HeightOrCID, filter types2.Filter, args ...interface{}) ([]types2.Payload, error) {
	if at.Height != nil {
		return h.getHeadersByHeight(ctx, at.Height.Int64(), filter)
	} else if at.CID != nil {
		return h.getHeadersByTipSetCID(ctx, *at.CID, filter)
	} else {
		return nil, fmt.Errorf("expected either a height or a CID in the provided ID")
	}
}

func (h *HeaderExtractor) PullSegment(ctx context.Context, rng types2.Range, filter types2.Filter, args ...interface{}) ([]types2.Payload, error) {
	var payloads []types2.Payload
	var err error
	if rng.Start.Height != nil && rng.Stop.Height != nil {
		payloads, err = h.getHeadersByHeights(ctx, rng.Start.Height.Int64(), rng.Stop.Height.Int64(), filter)
		if err != nil {
			return nil, err
		}
	} else if rng.Start.CID != nil && rng.Stop.CID != nil {
		payloads, err = h.getHeadersByTipSetCIDs(ctx, *rng.Start.CID, *rng.Stop.CID, filter)
		if err != nil {
			return nil, err
		}
	} else {
		return nil, fmt.Errorf("expected either a height or a CID in the provided IDs")
	}

	return payloads, nil
}

func (h *HeaderExtractor) getHeadersByTipSetCIDs(ctx context.Context, startCID, stopCID cid.Cid, filter types2.Filter) ([]types2.Payload, error) {
	startBlk, err := h.chainStore.ChainBlockstore().Get(ctx, startCID)
	if err != nil {
		return nil, err
	}
	startTSK := new(types.TipSetKey)
	if err := startTSK.UnmarshalCBOR(bytes.NewReader(startBlk.RawData())); err != nil {
		return nil, err
	}

	stopBlk, err := h.chainStore.ChainBlockstore().Get(ctx, stopCID)
	if err != nil {
		return nil, err
	}
	stopTSK := new(types.TipSetKey)
	if err := stopTSK.UnmarshalCBOR(bytes.NewReader(stopBlk.RawData())); err != nil {
		return nil, err
	}

	startTS, err := h.chainStore.LoadTipSet(ctx, *startTSK)
	if err != nil {
		return nil, err
	}
	stopTS, err := h.chainStore.LoadTipSet(ctx, *stopTSK)
	if err != nil {
		return nil, err
	}
	start, stop := int64(startTS.Height()), int64(stopTS.Height())
	return h.getHeadersByHeights(ctx, start, stop, filter)
}

func (h *HeaderExtractor) getHeadersByTipSetCIDsAsync(ctx context.Context, startCID, stopCID cid.Cid, quit <-chan struct{}, filter types2.Filter) (<-chan types2.Payload, <-chan struct{}, <-chan error, error)  {
	startBlk, err := h.chainStore.ChainBlockstore().Get(ctx, startCID)
	if err != nil {
		return nil, nil, nil, err
	}
	startTSK := new(types.TipSetKey)
	if err := startTSK.UnmarshalCBOR(bytes.NewReader(startBlk.RawData())); err != nil {
		return nil, nil, nil, err
	}

	stopBlk, err := h.chainStore.ChainBlockstore().Get(ctx, stopCID)
	if err != nil {
		return nil, nil, nil, err
	}
	stopTSK := new(types.TipSetKey)
	if err := stopTSK.UnmarshalCBOR(bytes.NewReader(stopBlk.RawData())); err != nil {
		return nil, nil, nil, err
	}

	startTS, err := h.chainStore.LoadTipSet(ctx, *startTSK)
	if err != nil {
		return nil, nil, nil, err
	}
	stopTS, err := h.chainStore.LoadTipSet(ctx, *stopTSK)
	if err != nil {
		return nil, nil, nil, err
	}
	start, stop := int64(startTS.Height()), int64(stopTS.Height())
	if start > stop {
		return nil, nil, nil, fmt.Errorf("start epoch (%d) is above stop epoch (%d)", start, stop)
	}
	payloadChan, doneChan, errChan := h.getHeadersByHeightsAsync(ctx, start, stop, quit, filter)
	return payloadChan, doneChan, errChan, nil
}

func (h *HeaderExtractor) getHeadersByHeights(ctx context.Context, start, stop int64, filter types2.Filter) ([]types2.Payload, error) {
	if start > stop {
		return nil, fmt.Errorf("start epoch (%d) is above stop epoch (%d)", start, stop)
	}
	payloads := make([]types2.Payload, 0, start - stop + 1)
	for i := start; i <= stop; i++ {
		ts, err := h.chainStore.GetTipsetByHeight(ctx, abi.ChainEpoch(i), nil, false)
		if err != nil {
			return nil, err
		}
		tskCID, err := ts.Key().Cid()
		if err != nil {
			return nil, err
		}
		ps, err := h.getHeadersForTipSet(ctx, tskCID, ts, filter)
		if err != nil {
			return nil, err
		}
		payloads = append(payloads, ps...)
	}
	return payloads, nil
}

func (h *HeaderExtractor) getHeadersByHeightsAsync(ctx context.Context, start, stop int64, quit <-chan struct{}, filter types2.Filter) (<-chan types2.Payload, <-chan struct{}, <-chan error) {
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
			ts, err := h.chainStore.GetTipsetByHeight(ctx, abi.ChainEpoch(i), nil, false)
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
			ps, err := h.getHeadersForTipSet(ctx, tskCID, ts, filter)
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

func (h *HeaderExtractor) getHeadersByTipSetCID(ctx context.Context, tskCID cid.Cid, filter types2.Filter) ([]types2.Payload, error) {
	// CID is the CID of the TipSetKey
	blk, err := h.chainStore.ChainBlockstore().Get(ctx, tskCID)
	if err != nil {
		return nil, err
	}
	tsk := new(types.TipSetKey)
	if err := tsk.UnmarshalCBOR(bytes.NewReader(blk.RawData())); err != nil {
		return nil, err
	}
	ts, err := h.chainStore.LoadTipSet(ctx, *tsk)
	if err != nil {
		return nil, err
	}
	return h.getHeadersForTipSet(ctx, tskCID, ts, filter)
}

func (h *HeaderExtractor) getHeadersByHeight(ctx context.Context, height int64, filter types2.Filter) ([]types2.Payload, error) {
	ts, err := h.chainStore.GetTipsetByHeight(ctx, abi.ChainEpoch(height), nil, false)
	if err != nil {
		return nil, err
	}
	tskCID, err := ts.Key().Cid()
	if err != nil {
		return nil, err
	}
	return h.getHeadersForTipSet(ctx, tskCID, ts, filter)
}

func (h *HeaderExtractor) getHeadersForTipSet(ctx context.Context, tskCID cid.Cid, ts *types.TipSet, filter types2.Filter) ([]types2.Payload, error) {
	iplds := make([]ipld.Node, 0, len(ts.Blocks()))
	b := bytes.NewBuffer(nil)
	for _, header := range ts.Blocks() {
		na := basicnode.Prototype.Any.NewBuilder()
		if err := header.MarshalCBOR(b); err != nil {
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
	return []types2.Payload{{
		IPLDs: iplds,
		For: types2.HeightOrCID{
			CID:    &tskCID,
			Height: big.NewInt(int64(ts.Height())),
		},
		ParentCIDs: map[string][]cid.Cid{"parent_tip_set_key_cid" : {tskCID}},
	}}, nil
}
