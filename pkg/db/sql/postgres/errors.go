package postgres

import (
	"fmt"
)

const (
	DbConnectionFailedMsg = "db connection failed"
)

func ErrDBConnectionFailed(connectErr error) error {
	return formatError(DbConnectionFailedMsg, connectErr)
}

func formatError(msg string, err error) error {
	return fmt.Errorf("%s: %w", msg, err)
}
