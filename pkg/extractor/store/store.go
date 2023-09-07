package store

import (
	"context"
	"github.com/filecoin-project/lotus/chain/actors/adt"
	lru "github.com/hashicorp/golang-lru"
	"github.com/ipfs/go-cid"

	"github.com/filecoin-project/go-state-types/abi"
	"github.com/filecoin-project/lotus/blockstore"
	"github.com/filecoin-project/lotus/chain/store"
	"github.com/filecoin-project/lotus/chain/types"
	types2 "github.com/vulcanize/filecoin-indexing/pkg/extractor/types"
)

type ChainStore struct {
	mmCache *lru.ARCCache[cid.Cid, mmCids]
	localBlockstore blockstore.Blockstore
	store *store.ChainStore
	index *store.ChainStore
}

func (cs *ChainStore) ChainBlockstore() blockstore.Blockstore {
	return cs.localBlockstore
}

func (cs *ChainStore) LoadTipSet(ctx context.Context, key types.TipSetKey) (*types.TipSet, error) {
	return cs.store.LoadTipSet(ctx, key)
}

func (cs *ChainStore) GetTipsetByHeight(ctx context.Context, epoch abi.ChainEpoch, ts *types.TipSet, prev bool) (*types.TipSet, error) {
	return cs.GetTipsetByHeight(ctx, epoch, ts, prev)
}

func (cs *ChainStore) MessagesForBlock(ctx context.Context, block *types.BlockHeader) ([]types2.TrackedNode, []types2.TrackedNode, error) {
	panic("implement me")
}

func (cs *ChainStore) ReceiptsForBlock(ctx context.Context, block *types.BlockHeader) ([]types2.TrackedNode, error) {
	panic("implement me")
}

func (cs *ChainStore) ActorStore(ctx context.Context) adt.Store {
	return store.ActorStore(ctx, cs.store.StateBlockstore())
}

var _ types2.ChainAccess = &ChainStore{}
