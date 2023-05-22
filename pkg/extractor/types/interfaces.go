package types

import (
	"context"
	"math/big"

	"github.com/filecoin-project/lily/lens"

	"github.com/filecoin-project/go-state-types/abi"
	"github.com/filecoin-project/lotus/api"
	"github.com/filecoin-project/lotus/blockstore"
	"github.com/filecoin-project/lotus/chain/actors/adt"
	"github.com/filecoin-project/lotus/chain/store"
	"github.com/filecoin-project/lotus/chain/types"
	"github.com/ipfs/go-cid"
	"github.com/ipld/go-ipld-prime"
)

type Filter func(node ipld.Node) bool

type Extractor interface {
	HeadExtractor
	HistoricalExtractor
}

type HeadExtractor interface {
	Stream(ctx context.Context, filter Filter, args ...interface{}) (Subscription, error)
	StreamOffset(ctx context.Context, offset Offset, filter Filter, args ...interface{}) (Subscription, error)
}

type HistoricalExtractor interface {
	StreamSegment(ctx context.Context, rng Range, filter Filter, args ...interface{}) (Subscription, error)
	Pull(ctx context.Context, at HeightOrCID, filter Filter, args ...interface{}) ([]Payload, error)
	PullSegment(ctx context.Context, rng Range, filter Filter, args ...interface{}) ([]Payload, error)
}

type Payload struct {
	IPLDs        []ipld.Node
	For          HeightOrCID
	ParentCIDs   map[string][]cid.Cid
	Associations []map[string]interface{}
}

type Offset struct {
	Reference HeightOrCID
	Offset    uint64
	Mod       uint64
}

type Range struct {
	Start HeightOrCID
	Stop  HeightOrCID
}

type Subscription interface {
	ID() string
	Error() <-chan error
	Done() <-chan struct{}
	Close() error
	Payload() <-chan Payload
}

type HeightOrCID struct {
	Height *big.Int
	CID    *cid.Cid
}

var _ ChainAccess = &store.ChainStore{}

type ChainAccess interface {
	ChainBlockstore() blockstore.Blockstore
	LoadTipSet(context.Context, types.TipSetKey) (*types.TipSet, error)
	GetTipsetByHeight(context.Context, abi.ChainEpoch, *types.TipSet, bool) (*types.TipSet, error)
	MessagesForBlock(context.Context, *types.BlockHeader) ([]*types.Message, []*types.SignedMessage, error)
}

type StreamableChainAccess interface {
	ChainAccess
	lens.ChainAPI
}

type StateAccess interface {
	StateSearchMsg(ctx context.Context, tsk types.TipSetKey, msg cid.Cid, lookbackLimit abi.ChainEpoch, allowReplaced bool) (*api.MsgLookup, error)
	Store() adt.Store
}

type StreamableStateAccess interface {
	StateAccess
	HAMTStream(context.Context) (<-chan adt.AdtMapDiff, error)
	AMTStream(context.Context) (<-chan adt.AdtArrayDiff, error)
	lens.StateAPI
}
