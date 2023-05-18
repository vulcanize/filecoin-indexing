package sql

import (
	"context"
	"io"

	"github.com/vulcanize/filecoin-indexing/pkg/db/metrics"
)

// Database interfaces required by the sql indexer
type Database interface {
	Driver
	Statements
}

// Driver interface has all the methods required by a driver implementation to support the sql indexer
type Driver interface {
	UseCopyFrom() bool
	QueryRow(ctx context.Context, sql string, args ...interface{}) ScannableRow
	Exec(ctx context.Context, sql string, args ...interface{}) (Result, error)
	Select(ctx context.Context, dest interface{}, query string, args ...interface{}) error
	Get(ctx context.Context, dest interface{}, query string, args ...interface{}) error
	Begin(ctx context.Context) (Tx, error)
	Stats() metrics.DbStats
	Context() context.Context
	io.Closer
}

// Statements interface to accommodate different SQL query syntax
type Statements interface {
	// SQL statements used when writing directly to the database
	InsertCIDsStm() string
	InsertIPLDsStm() string
	InsertTipSetStm() string
	InsertBlockHeaderStm() string
	InsertBlockParentsStm() string
	InsertMessagesStm() string
	InsertReceiptsStm() string
	InsertDRandStm() string
	InsertIDAddressesStm() string
	InsertMarketDealsStm() string
	InsertActorsStm() string
	InsertMinerInfos() string

	// Table/column descriptions for use with CopyFrom and similar commands.
	CIDsTableName() []string
	CIDsColumnNames() []string
	IPLDsTableName() []string
	IPLDsColumnNames() []string
	TipSetsTableName() []string
	TipSetsColumnNames() []string
	BlockHeadersTableName() []string
	BlockHeadersColumnNames() []string
	BlockParentsTableName() []string
	BlockParentsColumnNames() []string
	MessagesTableName() []string
	MessagesColumnNames() []string
	ReceiptsTableName() []string
	ReceiptsColumnNames() []string
	DRandsTableName() []string
	DRandsColumnNames() []string
	IDAddressesTableName() []string
	IDAddressesColumnNames() []string
	MarketDealsTableName() []string
	MarketDealsColumnNames() []string
	ActorsTableName() []string
	ActorsColumnNames() []string
	MinerInfosTableName() []string
	MinerInfosColumnNames() []string
	// TODO: remaining tables
}

// Tx interface to accommodate different concrete SQL transaction types
type Tx interface {
	QueryRow(ctx context.Context, sql string, args ...interface{}) ScannableRow
	Exec(ctx context.Context, sql string, args ...interface{}) (Result, error)
	CopyFrom(ctx context.Context, tableName []string, columnNames []string, rows [][]interface{}) (int64, error)
	Commit(ctx context.Context) error
	Rollback(ctx context.Context) error
}

// ScannableRow interface to accommodate different concrete row types
type ScannableRow interface {
	Scan(dest ...interface{}) error
}

// Result interface to accommodate different concrete result types
type Result interface {
	RowsAffected() (int64, error)
}
