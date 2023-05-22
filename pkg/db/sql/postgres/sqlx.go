package postgres

import (
	"context"
	coresql "database/sql"
	"errors"
	"time"

	"github.com/jmoiron/sqlx"

	"github.com/vulcanize/filecoin-indexing/pkg/db/metrics"
	"github.com/vulcanize/filecoin-indexing/pkg/db/sql"
)

// SQLXDriver driver, implements sql.Driver
type SQLXDriver struct {
	ctx context.Context
	db  *sqlx.DB
}

// ConnectSQLX initializes and returns a SQLX connection pool for postgres
func ConnectSQLX(ctx context.Context, config *Config) (*sqlx.DB, error) {
	db, err := sqlx.ConnectContext(ctx, "postgres", config.DbConnectionString())
	if err != nil {
		return nil, ErrDBConnectionFailed(err)
	}
	if config.MaxConns > 0 {
		db.SetMaxOpenConns(config.MaxConns)
	}
	if config.MaxConnLifetime > 0 {
		db.SetConnMaxLifetime(config.MaxConnLifetime)
	}
	db.SetMaxIdleConns(config.MaxIdle)
	return db, nil
}

// NewSQLXDriver returns a new sqlx driver for Postgres
// it initializes the connection pool and creates the node info table
func NewSQLXDriver(ctx context.Context, config *Config) (*SQLXDriver, error) {
	db, err := ConnectSQLX(ctx, config)
	if err != nil {
		return nil, err
	}
	driver := &SQLXDriver{ctx: ctx, db: db}
	return driver, nil
}

// QueryRow satisfies sql.Database
func (driver *SQLXDriver) QueryRow(_ context.Context, sql string, args ...interface{}) sql.ScannableRow {
	return driver.db.QueryRowx(sql, args...)
}

// Exec satisfies sql.Database
func (driver *SQLXDriver) Exec(_ context.Context, sql string, args ...interface{}) (sql.Result, error) {
	return driver.db.Exec(sql, args...)
}

// Select satisfies sql.Database
func (driver *SQLXDriver) Select(_ context.Context, dest interface{}, query string, args ...interface{}) error {
	return driver.db.Select(dest, query, args...)
}

// Get satisfies sql.Database
func (driver *SQLXDriver) Get(_ context.Context, dest interface{}, query string, args ...interface{}) error {
	return driver.db.Get(dest, query, args...)
}

// Begin satisfies sql.Database
func (driver *SQLXDriver) Begin(_ context.Context) (sql.Tx, error) {
	tx, err := driver.db.Beginx()
	if err != nil {
		return nil, err
	}
	return sqlxTxWrapper{tx: tx}, nil
}

func (driver *SQLXDriver) Stats() metrics.DbStats {
	stats := driver.db.Stats()
	return sqlxStatsWrapper{stats: stats}
}

// Close satisfies sql.Database/io.Closer
func (driver *SQLXDriver) Close() error {
	return driver.db.Close()
}

// Context satisfies sql.Database
func (driver *SQLXDriver) Context() context.Context {
	return driver.ctx
}

// UseCopyFrom satisfies sql.Database
func (driver *SQLXDriver) UseCopyFrom() bool {
	// sqlx does not currently support COPY.
	return false
}

type sqlxStatsWrapper struct {
	stats coresql.DBStats
}

// MaxOpen satisfies metrics.DbStats
func (s sqlxStatsWrapper) MaxOpen() int64 {
	return int64(s.stats.MaxOpenConnections)
}

// Open satisfies metrics.DbStats
func (s sqlxStatsWrapper) Open() int64 {
	return int64(s.stats.OpenConnections)
}

// InUse satisfies metrics.DbStats
func (s sqlxStatsWrapper) InUse() int64 {
	return int64(s.stats.InUse)
}

// Idle satisfies metrics.DbStats
func (s sqlxStatsWrapper) Idle() int64 {
	return int64(s.stats.Idle)
}

// WaitCount satisfies metrics.DbStats
func (s sqlxStatsWrapper) WaitCount() int64 {
	return s.stats.WaitCount
}

// WaitDuration satisfies metrics.DbStats
func (s sqlxStatsWrapper) WaitDuration() time.Duration {
	return s.stats.WaitDuration
}

// MaxIdleClosed satisfies metrics.DbStats
func (s sqlxStatsWrapper) MaxIdleClosed() int64 {
	return s.stats.MaxIdleClosed
}

// MaxLifetimeClosed satisfies metrics.DbStats
func (s sqlxStatsWrapper) MaxLifetimeClosed() int64 {
	return s.stats.MaxLifetimeClosed
}

type sqlxTxWrapper struct {
	tx *sqlx.Tx
}

// QueryRow satisfies sql.Tx
func (t sqlxTxWrapper) QueryRow(ctx context.Context, sql string, args ...interface{}) sql.ScannableRow {
	return t.tx.QueryRowx(sql, args...)
}

// Exec satisfies sql.Tx
func (t sqlxTxWrapper) Exec(ctx context.Context, sql string, args ...interface{}) (sql.Result, error) {
	return t.tx.Exec(sql, args...)
}

// Commit satisfies sql.Tx
func (t sqlxTxWrapper) Commit(ctx context.Context) error {
	return t.tx.Commit()
}

// Rollback satisfies sql.Tx
func (t sqlxTxWrapper) Rollback(ctx context.Context) error {
	return t.tx.Rollback()
}

func (t sqlxTxWrapper) CopyFrom(ctx context.Context, tableName []string, columnNames []string, rows [][]interface{}) (int64, error) {
	return 0, errors.New("Unsupported Operation")
}
