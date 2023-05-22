package postgres

import (
	"context"

	"github.com/jackc/pgx/v4"
	log "github.com/sirupsen/logrus"
)

type LogAdapter struct {
	l *log.Logger
}

func NewLogAdapter(l *log.Logger) *LogAdapter {
	return &LogAdapter{l: l}
}

func (l *LogAdapter) Log(ctx context.Context, level pgx.LogLevel, msg string, data map[string]interface{}) {
	switch level {
	case pgx.LogLevelTrace:
		l.l.Trace(msg)
	case pgx.LogLevelDebug:
		l.l.Debug(msg)
	case pgx.LogLevelInfo:
		l.l.Info(msg)
	case pgx.LogLevelWarn:
		l.l.Warn(msg)
	case pgx.LogLevelError:
		l.l.Error(msg)
	default:
		l.l.Error("INVALID_PGX_LOG_LEVEL: %s\r\nmsg: %s", level.String(), msg)
	}
}
