package types

import (
	"context"
	"github.com/filecoin-project/go-amt-ipld/v4"
	"github.com/filecoin-project/go-hamt-ipld/v3"
	"math/big"

	"github.com/filecoin-project/lily/lens"

	"github.com/filecoin-project/go-state-types/abi"
	"github.com/filecoin-project/lotus/api"
	"github.com/filecoin-project/lotus/blockstore"
	"github.com/filecoin-project/lotus/chain/actors/adt"
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
	IPLDs        []TrackedNode
	For          HeightOrCID
	ParentCIDs   []CIDs
	Associations [][]Association
}

type TrackedNode struct {
	Node ipld.Node
	Position []int
}

type TrackedHAMTChange struct {
	Diff *hamt.Change
	Position []int
}

type TrackedAMTChange struct {
	Diff *amt.Change
	Position []int
}

type CIDs struct {
	ID string
	CIDs []cid.Cid
}

type Association struct {
	ID   string
	Val  string
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

type ChainAccess interface {
	ChainBlockstore() blockstore.Blockstore
	LoadTipSet(ctx context.Context, key types.TipSetKey) (*types.TipSet, error)
	GetTipsetByHeight(ctx context.Context, epoch abi.ChainEpoch, ts *types.TipSet, prev bool) (*types.TipSet, error)
	MessagesForBlock(ctx context.Context, block *types.BlockHeader) ([]TrackedNode, []TrackedNode, error)
	ReceiptsForBlock(ctx context.Context, block *types.BlockHeader) ([]TrackedNode, error)
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
	HAMTStream(context.Context) (<-chan []TrackedHAMTChange, error)
	AMTStream(context.Context) (<-chan []TrackedAMTChange, error)
	lens.StateAPI
}
