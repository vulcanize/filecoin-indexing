package shared

import (
	"fmt"
	"strings"
)

// DBType to explicitly type the kind of DB
type DBType string

const (
	POSTGRES DBType = "Postgres"
	DUMP     DBType = "Dump"
	FILE     DBType = "File"
	UNKNOWN  DBType = "Unknown"
)

// ResolveDBType resolves a DBType from a provided string
func ResolveDBType(str string) (DBType, error) {
	switch strings.ToLower(str) {
	case "postgres", "pg":
		return POSTGRES, nil
	case "dump", "d":
		return DUMP, nil
	case "file", "f", "fs":
		return FILE, nil
	default:
		return UNKNOWN, fmt.Errorf("unrecognized db type string: %s", str)
	}
}
