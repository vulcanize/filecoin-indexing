package offline

import (
	"bytes"
	"context"
	"fmt"

	"github.com/filecoin-project/go-state-types/abi"
	"github.com/filecoin-project/lotus/chain/types"
	"github.com/ipfs/go-cid"
	"github.com/sirupsen/logrus"

	"github.com/vulcanize/filecoin-indexing/pkg/extractor/shared"
	types2 "github.com/vulcanize/filecoin-indexing/pkg/extractor/types"
)

var _ types2.HistoricalExtractor = &ActorExtractor{}

type ActorExtractor struct {
	chainStore types2.ChainAccess
	stateStore types2.StateAccess
}

func NewActorExtractor(chainStore types2.ChainAccess, stateStore types2.StateAccess) *ActorExtractor {
	return &ActorExtractor{chainStore: chainStore, stateStore: stateStore}
}

func (a *ActorExtractor) StreamSegment(ctx context.Context, rng types2.Range, filter types2.Filter, args ...interface{}) (types2.Subscription, error) {
	var payloadChan <-chan types2.Payload
	var doneChan <-chan struct{}
	var errChan <-chan error
	var err error
	quitChan := make(chan struct{})
	if rng.Start.Height != nil && rng.Stop.Height != nil {
		payloadChan, doneChan, errChan = a.getActorsByHeightsAsync(ctx, rng.Start.Height.Int64(), rng.Stop.Height.Int64(), quitChan, filter)
	} else if rng.Start.CID != nil && rng.Stop.CID != nil {
		payloadChan, doneChan, errChan, err = a.getActorsByCIDsAsync(ctx, *rng.Start.CID, *rng.Stop.CID, quitChan, filter)
		if err != nil {
			return nil, err
		}
	} else {
		return nil, fmt.Errorf("expected either a height or a CID in the provided IDs")
	}
	return types2.NewSubscription(payloadChan, errChan, doneChan, quitChan), nil
}

func (a *ActorExtractor) Pull(ctx context.Context, at types2.HeightOrCID, filter types2.Filter, args ...interface{}) ([]types2.Payload, error) {
	if at.Height != nil {
		return a.getActorsByHeight(ctx, at.Height.Int64(), filter)
	} else if at.CID != nil {
		return a.getActorsByCID(ctx, *at.CID, filter)
	} else {
		return nil, fmt.Errorf("expected either a height or a CID in the provided ID")
	}
}

func (a *ActorExtractor) PullSegment(ctx context.Context, rng types2.Range, filter types2.Filter, args ...interface{}) ([]types2.Payload, error) {
	var payloads []types2.Payload
	var err error
	if rng.Start.Height != nil && rng.Stop.Height != nil {
		payloads, err = a.getActorsByHeights(ctx, rng.Start.Height.Int64(), rng.Stop.Height.Int64(), filter)
		if err != nil {
			return nil, err
		}
	} else if rng.Start.CID != nil && rng.Stop.CID != nil {
		payloads, err = a.getActorsByCIDs(ctx, *rng.Start.CID, *rng.Stop.CID, filter)
		if err != nil {
			return nil, err
		}
	} else {
		return nil, fmt.Errorf("expected either a height or a CID in the provided IDs")
	}

	return payloads, nil
}

func (a *ActorExtractor) getActorsByCIDs(ctx context.Context, startCID, stopCID cid.Cid, filter types2.Filter) ([]types2.Payload, error) {
	startBlk, err := a.chainStore.ChainBlockstore().Get(ctx, startCID)
	if err != nil {
		return nil, err
	}
	startTSK := new(types.TipSetKey)
	if err := startTSK.UnmarshalCBOR(bytes.NewReader(startBlk.RawData())); err != nil {
		return nil, err
	}

	stopBlk, err := a.chainStore.ChainBlockstore().Get(ctx, stopCID)
	if err != nil {
		return nil, err
	}
	stopTSK := new(types.TipSetKey)
	if err := stopTSK.UnmarshalCBOR(bytes.NewReader(stopBlk.RawData())); err != nil {
		return nil, err
	}

	startTS, err := a.chainStore.LoadTipSet(ctx, *startTSK)
	if err != nil {
		return nil, err
	}
	stopTS, err := a.chainStore.LoadTipSet(ctx, *stopTSK)
	if err != nil {
		return nil, err
	}
	start, stop := int64(startTS.Height()), int64(stopTS.Height())
	return a.getActorsByHeights(ctx, start, stop, filter)
}

func (a *ActorExtractor) getActorsByCIDsAsync(ctx context.Context, startCID, stopCID cid.Cid, quit <-chan struct{}, filter types2.Filter) (<-chan types2.Payload, <-chan struct{}, <-chan error, error) {
	startBlk, err := a.chainStore.ChainBlockstore().Get(ctx, startCID)
	if err != nil {
		return nil, nil, nil, err
	}
	startTSK := new(types.TipSetKey)
	if err := startTSK.UnmarshalCBOR(bytes.NewReader(startBlk.RawData())); err != nil {
		return nil, nil, nil, err
	}

	stopBlk, err := a.chainStore.ChainBlockstore().Get(ctx, stopCID)
	if err != nil {
		return nil, nil, nil, err
	}
	stopTSK := new(types.TipSetKey)
	if err := stopTSK.UnmarshalCBOR(bytes.NewReader(stopBlk.RawData())); err != nil {
		return nil, nil, nil, err
	}

	startTS, err := a.chainStore.LoadTipSet(ctx, *startTSK)
	if err != nil {
		return nil, nil, nil, err
	}
	stopTS, err := a.chainStore.LoadTipSet(ctx, *stopTSK)
	if err != nil {
		return nil, nil, nil, err
	}
	start, stop := int64(startTS.Height()), int64(stopTS.Height())
	if start > stop {
		return nil, nil, nil, fmt.Errorf("start epoch (%d) is above stop epoch (%d)", start, stop)
	}
	payloadChan, doneChan, errChan := a.getActorsByHeightsAsync(ctx, start, stop, quit, filter)
	return payloadChan, doneChan, errChan, nil
}

func (a *ActorExtractor) getActorsByHeights(ctx context.Context, start, stop int64, filter types2.Filter) ([]types2.Payload, error) {
	if start > stop {
		return nil, fmt.Errorf("start epoch (%d) is above stop epoch (%d)", start, stop)
	}
	payloads := make([]types2.Payload, 0, start-stop+1) // TODO:
	for i := start; i <= stop; i++ {
		ts, err := a.chainStore.GetTipsetByHeight(ctx, abi.ChainEpoch(i), nil, false)
		if err != nil {
			return nil, err
		}
		tskCID, err := ts.Key().Cid()
		if err != nil {
			return nil, err
		}
		pts, err := a.chainStore.LoadTipSet(ctx, ts.Parents())
		if err != nil {
			return nil, err
		}
		ps, err := a.getActorsForTipSet(ctx, tskCID, pts, ts, filter)
		if err != nil {
			return nil, err
		}
		payloads = append(payloads, ps...)
	}
	return payloads, nil
}

func (a *ActorExtractor) getActorsByHeightsAsync(ctx context.Context, start, stop int64, quit <-chan struct{}, filter types2.Filter) (<-chan types2.Payload, <-chan struct{}, <-chan error) {
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
			ts, err := a.chainStore.GetTipsetByHeight(ctx, abi.ChainEpoch(i), nil, false)
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
			pts, err := a.chainStore.LoadTipSet(ctx, ts.Parents())
			if err != nil {
				logrus.Error(err)
				errChan <- err
				continue
			}
			ps, err := a.getActorsForTipSet(ctx, tskCID, pts, ts, filter)
			for _, payload := range ps {
				payloadChan <- payload
			}
		}
	}()

	return payloadChan, doneChan, errChan
}

func (a *ActorExtractor) getActorsByCID(ctx context.Context, tskCID cid.Cid, filter types2.Filter) ([]types2.Payload, error) {
	// CID is the CID of the TipSetKey
	blk, err := a.chainStore.ChainBlockstore().Get(ctx, tskCID)
	if err != nil {
		return nil, err
	}
	tsk := new(types.TipSetKey)
	if err := tsk.UnmarshalCBOR(bytes.NewReader(blk.RawData())); err != nil {
		return nil, err
	}
	ts, err := a.chainStore.LoadTipSet(ctx, *tsk)
	if err != nil {
		return nil, err
	}
	pts, err := a.chainStore.LoadTipSet(ctx, ts.Parents())
	if err != nil {
		return nil, err
	}
	return a.getActorsForTipSet(ctx, tskCID, pts, ts, filter)
}

func (a *ActorExtractor) getActorsByHeight(ctx context.Context, height int64, filter types2.Filter) ([]types2.Payload, error) {
	ts, err := a.chainStore.GetTipsetByHeight(ctx, abi.ChainEpoch(height), nil, false)
	if err != nil {
		return nil, err
	}
	tskCID, err := ts.Key().Cid()
	if err != nil {
		return nil, err
	}
	pts, err := a.chainStore.LoadTipSet(ctx, ts.Parents())
	if err != nil {
		return nil, err
	}
	return a.getActorsForTipSet(ctx, tskCID, pts, ts, filter)
}

func (a *ActorExtractor) getActorsForTipSet(ctx context.Context, tskCID cid.Cid, parentTS, ts *types.TipSet, filter types2.Filter) ([]types2.Payload, error) {
	diffPayload, err := shared.GetActorStateChanges(ctx, a.stateStore.Store(), parentTS, ts, filter)
	if err != nil {
		return nil, err
	}
	return []types2.Payload{*diffPayload}, nil
}
