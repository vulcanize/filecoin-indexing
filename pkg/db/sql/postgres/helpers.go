package postgres

import (
	"context"

	"github.com/vulcanize/filecoin-indexing/pkg/db/sql"
)

// SetupSQLXDB is used to setup a sqlx db
func SetupSQLXDB(config *Config) (sql.Database, error) {
	if config == nil {
		config = &DefaultConfig
	}
	config.MaxIdle = 0
	driver, err := NewSQLXDriver(context.Background(), config)
	if err != nil {
		return nil, err
	}
	return NewPostgresDB(driver, false), nil
}

// SetupPGXDB is used to setup a pgx db
func SetupPGXDB(config *Config) (sql.Database, error) {
	if config == nil {
		config = &DefaultConfig
	}
	driver, err := NewPGXDriver(context.Background(), config)
	if err != nil {
		return nil, err
	}
	return NewPostgresDB(driver, false), nil
}
