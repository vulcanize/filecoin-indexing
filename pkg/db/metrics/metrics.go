package metrics

import (
	"time"
)

// DbStats interface to accommodate different concrete sql stats types
type DbStats interface {
	MaxOpen() int64
	Open() int64
	InUse() int64
	Idle() int64
	WaitCount() int64
	WaitDuration() time.Duration
	MaxIdleClosed() int64
	MaxLifetimeClosed() int64
}
