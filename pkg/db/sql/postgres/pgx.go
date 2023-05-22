package postgres

import (
	"context"
	"time"

	"github.com/georgysavva/scany/pgxscan"
	"github.com/jackc/pgconn"
	"github.com/jackc/pgx/v4"
	"github.com/jackc/pgx/v4/pgxpool"
	log "github.com/sirupsen/logrus"

	"github.com/vulcanize/filecoin-indexing/pkg/db/metrics"
	"github.com/vulcanize/filecoin-indexing/pkg/db/sql"
)

// PGXDriver driver, implements sql.Driver
type PGXDriver struct {
	ctx    context.Context
	pool   *pgxpool.Pool
	config Config
}

// ConnectPGX initializes and returns a PGX connection pool
func ConnectPGX(ctx context.Context, config *Config) (*pgxpool.Pool, error) {
	pgConf, err := MakeConfig(*config)
	if err != nil {
		return nil, err
	}
	return pgxpool.ConnectConfig(ctx, pgConf)
}

// NewPGXDriver returns a new pgx driver
// it initializes the connection pool and creates the node info table
func NewPGXDriver(ctx context.Context, config *Config) (*PGXDriver, error) {
	dbPool, err := ConnectPGX(ctx, config)
	if err != nil {
		return nil, ErrDBConnectionFailed(err)
	}
	return &PGXDriver{ctx: ctx, pool: dbPool, config: *config}, nil
}

// MakeConfig creates a pgxpool.Config from the provided Config
func MakeConfig(config Config) (*pgxpool.Config, error) {
	conf, err := pgxpool.ParseConfig("")
	if err != nil {
		return nil, err
	}

	//conf.ConnConfig.BuildStatementCache = nil
	conf.ConnConfig.Config.Host = config.Hostname
	conf.ConnConfig.Config.Port = uint16(config.Port)
	conf.ConnConfig.Config.Database = config.DatabaseName
	conf.ConnConfig.Config.User = config.Username
	conf.ConnConfig.Config.Password = config.Password

	if config.ConnTimeout != 0 {
		conf.ConnConfig.Config.ConnectTimeout = config.ConnTimeout
	}
	if config.MaxConns != 0 {
		conf.MaxConns = int32(config.MaxConns)
	}
	if config.MinConns != 0 {
		conf.MinConns = int32(config.MinConns)
	}
	if config.MaxConnLifetime != 0 {
		conf.MaxConnLifetime = config.MaxConnLifetime
	}
	if config.MaxConnIdleTime != 0 {
		conf.MaxConnIdleTime = config.MaxConnIdleTime
	}

	if config.LogStatements {
		conf.ConnConfig.Logger = NewLogAdapter(log.New())
	}

	return conf, nil
}

// QueryRow satisfies sql.Database
func (pgx *PGXDriver) QueryRow(ctx context.Context, sql string, args ...interface{}) sql.ScannableRow {
	return pgx.pool.QueryRow(ctx, sql, args...)
}

// Exec satisfies sql.Database
func (pgx *PGXDriver) Exec(ctx context.Context, sql string, args ...interface{}) (sql.Result, error) {
	res, err := pgx.pool.Exec(ctx, sql, args...)
	return resultWrapper{ct: res}, err
}

// Select satisfies sql.Database
func (pgx *PGXDriver) Select(ctx context.Context, dest interface{}, query string, args ...interface{}) error {
	return pgxscan.Select(ctx, pgx.pool, dest, query, args...)
}

// Get satisfies sql.Database
func (pgx *PGXDriver) Get(ctx context.Context, dest interface{}, query string, args ...interface{}) error {
	return pgxscan.Get(ctx, pgx.pool, dest, query, args...)
}

// Begin satisfies sql.Database
func (pgx *PGXDriver) Begin(ctx context.Context) (sql.Tx, error) {
	tx, err := pgx.pool.Begin(ctx)
	if err != nil {
		return nil, err
	}
	return pgxTxWrapper{tx: tx}, nil
}

func (pgx *PGXDriver) Stats() metrics.DbStats {
	stats := pgx.pool.Stat()
	return pgxStatsWrapper{stats: stats}
}

// Close satisfies sql.Database/io.Closer
func (pgx *PGXDriver) Close() error {
	pgx.pool.Close()
	return nil
}

// Context satisfies sql.Database
func (pgx *PGXDriver) Context() context.Context {
	return pgx.ctx
}

// UseCopyFrom satisfies sql.Database
func (pgx *PGXDriver) UseCopyFrom() bool {
	return pgx.config.CopyFrom
}

type resultWrapper struct {
	ct pgconn.CommandTag
}

// RowsAffected satisfies sql.Result
func (r resultWrapper) RowsAffected() (int64, error) {
	return r.ct.RowsAffected(), nil
}

type pgxStatsWrapper struct {
	stats *pgxpool.Stat
}

// MaxOpen satisfies metrics.DbStats
func (s pgxStatsWrapper) MaxOpen() int64 {
	return int64(s.stats.MaxConns())
}

// Open satisfies metrics.DbStats
func (s pgxStatsWrapper) Open() int64 {
	return int64(s.stats.TotalConns())
}

// InUse satisfies metrics.DbStats
func (s pgxStatsWrapper) InUse() int64 {
	return int64(s.stats.AcquiredConns())
}

// Idle satisfies metrics.DbStats
func (s pgxStatsWrapper) Idle() int64 {
	return int64(s.stats.IdleConns())
}

// WaitCount satisfies metrics.DbStats
func (s pgxStatsWrapper) WaitCount() int64 {
	return s.stats.EmptyAcquireCount()
}

// WaitDuration satisfies metrics.DbStats
func (s pgxStatsWrapper) WaitDuration() time.Duration {
	return s.stats.AcquireDuration()
}

// MaxIdleClosed satisfies metrics.DbStats
func (s pgxStatsWrapper) MaxIdleClosed() int64 {
	// this stat isn't supported by pgxpool, but we don't want to panic
	return 0
}

// MaxLifetimeClosed satisfies metrics.DbStats
func (s pgxStatsWrapper) MaxLifetimeClosed() int64 {
	return s.stats.CanceledAcquireCount()
}

type pgxTxWrapper struct {
	tx pgx.Tx
}

// QueryRow satisfies sql.Tx
func (t pgxTxWrapper) QueryRow(ctx context.Context, sql string, args ...interface{}) sql.ScannableRow {
	return t.tx.QueryRow(ctx, sql, args...)
}

// Exec satisfies sql.Tx
func (t pgxTxWrapper) Exec(ctx context.Context, sql string, args ...interface{}) (sql.Result, error) {
	res, err := t.tx.Exec(ctx, sql, args...)
	return resultWrapper{ct: res}, err
}

// Commit satisfies sql.Tx
func (t pgxTxWrapper) Commit(ctx context.Context) error {
	return t.tx.Commit(ctx)
}

// Rollback satisfies sql.Tx
func (t pgxTxWrapper) Rollback(ctx context.Context) error {
	return t.tx.Rollback(ctx)
}

func (t pgxTxWrapper) CopyFrom(ctx context.Context, tableName []string, columnNames []string, rows [][]interface{}) (int64, error) {
	return t.tx.CopyFrom(ctx, tableName, columnNames, pgx.CopyFromRows(rows))
}
