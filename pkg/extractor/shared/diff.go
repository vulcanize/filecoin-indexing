package shared

import (
	"bytes"
	"context"
	"crypto/sha256"
	"fmt"
	"math/big"

	"github.com/filecoin-project/go-address"
	"github.com/filecoin-project/go-hamt-ipld/v3"
	"github.com/filecoin-project/go-state-types/builtin"
	"github.com/filecoin-project/lily/chain/actors/adt/diff"
	"github.com/filecoin-project/lily/chain/datasource"
	"github.com/filecoin-project/lily/metrics"
	"github.com/filecoin-project/lotus/chain/actors/adt"
	"github.com/filecoin-project/lotus/chain/state"
	"github.com/filecoin-project/lotus/chain/types"
	"github.com/ipfs/go-cid"
	"github.com/ipld/go-ipld-prime"
	"github.com/ipld/go-ipld-prime/codec/dagcbor"
	basicnode "github.com/ipld/go-ipld-prime/node/basic"
	types2 "github.com/vulcanize/filecoin-indexing/pkg/extractor/types"
)

// modified from Lily
func GetActorStateChanges(ctx context.Context, store adt.Store, current, executed *types.TipSet, filter types2.Filter) (*types2.Payload, error) {
	stop := metrics.Timer(ctx, metrics.DataSourceActorStateChangesDuration)
	defer stop()

	if executed.Height() == 0 {
		return GetGenesisActors(ctx, store, executed, filter)
	}

	oldTree, err := datasource.LoadStateTreeMeta(ctx, store, executed)
	if err != nil {
		return nil, err
	}

	newTree, err := datasource.LoadStateTreeMeta(ctx, store, current)
	if err != nil {
		return nil, err
	}

	if newTree.Tree.Version() > 1 && oldTree.Tree.Version() > 1 {
		changes, err := fastDiff(ctx, executed, store, oldTree, newTree, filter)
		if err == nil {
			return changes, nil
		}
	}

	actors, err := state.Diff(ctx, oldTree.Tree, newTree.Tree)
	if err != nil {
		return nil, err
	}

	iplds := make([]ipld.Node, 0, len(actors))
	associations := make([]map[string]interface{}, 0, len(actors))

	for addrStr, act := range actors {
		na := basicnode.Prototype.Any.NewBuilder()
		w := new(bytes.Buffer)
		if err := act.MarshalCBOR(w); err != nil {
			return nil, err
		}
		if err := dagcbor.Decode(na, bytes.NewReader(w.Bytes())); err != nil {
			return nil, err
		}
		node := na.Build()
		if filter != nil && !filter(node) {
			continue
		}
		iplds = append(iplds, node)
		associations = append(associations, map[string]interface{}{"id": addrStr})
	}
	tskCID, err := executed.Key().Cid()
	if err != nil {
		return nil, err
	}
	return &types2.Payload{
		IPLDs: iplds,
		For: types2.HeightOrCID{
			Height: big.NewInt(int64(executed.Height())),
			CID:    &tskCID,
		},
		ParentCIDs:   map[string][]cid.Cid{"parent_tip_set_key": {tskCID}, "parent_state_root_cid": {executed.ParentState()}},
		Associations: associations,
	}, nil
}

func GetGenesisActors(ctx context.Context, store adt.Store, genesis *types.TipSet, filter types2.Filter) (*types2.Payload, error) {
	tree, err := state.LoadStateTree(store, genesis.ParentState())
	if err != nil {
		return nil, err
	}
	iplds := make([]ipld.Node, 0)
	associations := make([]map[string]interface{}, 0)
	if err := tree.ForEach(func(addr address.Address, act *types.Actor) error {
		na := basicnode.Prototype.Any.NewBuilder()
		w := new(bytes.Buffer)
		if err := act.MarshalCBOR(w); err != nil {
			return err
		}
		if err := dagcbor.Decode(na, bytes.NewReader(w.Bytes())); err != nil {
			return err
		}
		node := na.Build()
		if filter != nil && !filter(node) {
			return nil
		}
		iplds = append(iplds, node)
		associations = append(associations, map[string]interface{}{"id": addr.String()})
		return nil
	}); err != nil {
		return nil, err
	}
	tskCID, err := genesis.Key().Cid()
	if err != nil {
		return nil, err
	}
	return &types2.Payload{
		IPLDs: iplds,
		For: types2.HeightOrCID{
			Height: big.NewInt(int64(genesis.Height())),
			CID:    &tskCID,
		},
		ParentCIDs:   map[string][]cid.Cid{"parent_tip_set_key": {tskCID}, "parent_state_root_cid": {genesis.ParentState()}},
		Associations: associations,
	}, nil
}

// modified from Lily
func fastDiff(ctx context.Context, ts *types.TipSet, store adt.Store, oldTree, newTree *datasource.StateTreeMeta, filter types2.Filter) (*types2.Payload, error) {
	oldMap, err := oldTree.LoadMap(store)
	if err != nil {
		return nil, err
	}
	newMap, err := newTree.LoadMap(store)
	if err != nil {
		return nil, err
	}
	changes, err := diff.Hamt(ctx, oldMap, newMap, store, store, hamt.UseTreeBitWidth(builtin.DefaultHamtBitwidth), hamt.UseHashFunction(func(input []byte) []byte {
		res := sha256.Sum256(input)
		return res[:]
	}))
	if err != nil {
		return nil, err
	}

	buf := bytes.NewReader(nil)
	iplds := make([]ipld.Node, 0)
	associations := make([]map[string]interface{}, 0)

	for _, change := range changes {
		addr, err := address.NewFromBytes([]byte(change.Key))
		if err != nil {
			return nil, fmt.Errorf("address in state tree was not valid: %w", err)
		}

		na := basicnode.Prototype.Any.NewBuilder()
		buf.Reset(change.After.Raw)
		if err := dagcbor.Decode(na, buf); err != nil {
			return nil, err
		}
		buf.Reset(nil)
		node := na.Build()
		if filter != nil && !filter(node) {
			return nil, err
		}
		iplds = append(iplds, node)
		associations = append(associations, map[string]interface{}{"id": addr.String()})
		associations = append(associations, map[string]interface{}{"type": change.Type})
	}
	tskCID, err := ts.Key().Cid()
	if err != nil {
		return nil, err
	}
	return &types2.Payload{
		IPLDs: iplds,
		For: types2.HeightOrCID{
			Height: big.NewInt(int64(ts.Height())),
			CID:    &tskCID,
		},
		ParentCIDs:   map[string][]cid.Cid{"parent_tip_set_key": {tskCID}, "parent_state_root_cid": {ts.ParentState()}},
		Associations: associations,
	}, nil
}
