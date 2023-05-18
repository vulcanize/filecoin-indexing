package shared

// Config used to configure different underlying implementations
type Config interface {
	Type() DBType
}
