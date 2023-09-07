package offline

import (
	"context"

	"github.com/filecoin-project/lily/lens"

	types2 "github.com/vulcanize/filecoin-indexing/pkg/extractor/types"
)

var _ types2.HistoricalExtractor = &StateExtractor{}

type StateExtractor struct {
	stateAPI lens.StateAPI
}

func NewStateExtractor(stateAPI lens.StateAPI) *StateExtractor {
	return &StateExtractor{stateAPI: stateAPI}
}

func (s StateExtractor) StreamSegment(ctx context.Context, rng types2.Range, filter types2.Filter, args ...interface{}) (types2.Subscription, error) {
	panic("implement me")
}

func (s StateExtractor) Pull(ctx context.Context, at types2.HeightOrCID, filter types2.Filter, args ...interface{}) ([]types2.Payload, error) {
	panic("implement me")
}

func (s StateExtractor) PullSegment(ctx context.Context, rng types2.Range, filter types2.Filter, args ...interface{}) ([]types2.Payload, error) {
	panic("implement me")
}
