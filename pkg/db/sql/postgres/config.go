package postgres

import (
	"fmt"
	"github.com/vulcanize/filecoin-indexing/pkg/db/shared"
	"os"
	"strconv"
	"strings"
	"time"
)

// DriverType to explicitly type the kind of sql driver we are using
type DriverType string

const (
	PGX     DriverType = "PGX"
	SQLX    DriverType = "SQLX"
	Unknown DriverType = "Unknown"
)

// Env variables
const (
	DATABASE_NAME     = "DATABASE_NAME"
	DATABASE_HOSTNAME = "DATABASE_HOSTNAME"
	DATABASE_PORT     = "DATABASE_PORT"
	DATABASE_USER     = "DATABASE_USER"
	DATABASE_PASSWORD = "DATABASE_PASSWORD"
)

// ResolveDriverType resolves a DriverType from a provided string
func ResolveDriverType(str string) (DriverType, error) {
	switch strings.ToLower(str) {
	case "pgx", "pgxpool":
		return PGX, nil
	case "sqlx":
		return SQLX, nil
	default:
		return Unknown, fmt.Errorf("unrecognized driver type string: %s", str)
	}
}

// DefaultConfig are default parameters for connecting to a Postgres sql
var DefaultConfig = Config{
	Hostname:     "localhost",
	Port:         8077,
	DatabaseName: "filecoin_testing",
	Username:     "fil",
	Password:     "password",
}

// Config holds params for a Postgres db
type Config struct {
	// conn string params
	Hostname     string
	Port         int
	DatabaseName string
	Username     string
	Password     string

	// conn settings
	MaxConns        int
	MaxIdle         int
	MinConns        int
	MaxConnIdleTime time.Duration
	MaxConnLifetime time.Duration
	ConnTimeout     time.Duration
	LogStatements   bool

	// driver type
	Driver DriverType

	// toggle on/off upserts
	Upsert bool

	// toggle on/off CopyFrom
	CopyFrom bool
}

// Type satisfies interfaces.Config
func (c Config) Type() shared.DBType {
	return shared.POSTGRES
}

// DbConnectionString constructs and returns the connection string from the config
func (c Config) DbConnectionString() string {
	if len(c.Username) > 0 && len(c.Password) > 0 {
		return fmt.Sprintf("postgresql://%s:%s@%s:%d/%s?sslmode=disable",
			c.Username, c.Password, c.Hostname, c.Port, c.DatabaseName)
	}
	if len(c.Username) > 0 && len(c.Password) == 0 {
		return fmt.Sprintf("postgresql://%s@%s:%d/%s?sslmode=disable",
			c.Username, c.Hostname, c.Port, c.DatabaseName)
	}
	return fmt.Sprintf("postgresql://%s:%d/%s?sslmode=disable", c.Hostname, c.Port, c.DatabaseName)
}

func (c Config) WithEnv() (Config, error) {
	if val := os.Getenv(DATABASE_NAME); val != "" {
		c.DatabaseName = val
	}
	if val := os.Getenv(DATABASE_HOSTNAME); val != "" {
		c.Hostname = val
	}
	if val := os.Getenv(DATABASE_PORT); val != "" {
		port, err := strconv.Atoi(val)
		if err != nil {
			return c, err
		}
		c.Port = port
	}
	if val := os.Getenv(DATABASE_USER); val != "" {
		c.Username = val
	}
	if val := os.Getenv(DATABASE_PASSWORD); val != "" {
		c.Password = val
	}
	return c, nil
}
