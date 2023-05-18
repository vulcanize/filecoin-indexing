package postgres

import (
	"github.com/vulcanize/filecoin-indexing/pkg/db/schema"
	"github.com/vulcanize/filecoin-indexing/pkg/db/sql"
)

var _ sql.Database = &DB{}

// NewPostgresDB returns a postgres.DB using the provided driver
func NewPostgresDB(driver sql.Driver, upsert bool) *DB {
	return &DB{upsert, driver}
}

// DB implements sql.Database using a configured driver and Postgres statement syntax
type DB struct {
	upsert bool
	sql.Driver
}

func (db *DB) InsertIPLDsStm() string {
	return schema.TableIPLDs.ToInsertStatement(db.upsert)
}

func (db *DB) InsertCIDsStm() string {
	panic("implement me")
}

func (db *DB) InsertTipSetStm() string {
	panic("implement me")
}

func (db *DB) InsertBlockHeaderStm() string {
	panic("implement me")
}

func (db *DB) InsertBlockParentsStm() string {
	panic("implement me")
}

func (db *DB) InsertMessagesStm() string {
	panic("implement me")
}

func (db *DB) InsertReceiptsStm() string {
	panic("implement me")
}

func (db *DB) InsertDRandStm() string {
	panic("implement me")
}

func (db *DB) InsertIDAddressesStm() string {
	panic("implement me")
}

func (db *DB) InsertMarketDealsStm() string {
	panic("implement me")
}

func (db *DB) InsertActorsStm() string {
	panic("implement me")
}

func (db *DB) InsertMinerInfos() string {
	panic("implement me")
}

func (db *DB) CIDsTableName() []string {
	panic("implement me")
}

func (db *DB) CIDsColumnNames() []string {
	panic("implement me")
}

func (db *DB) IPLDsTableName() []string {
	panic("implement me")
}

func (db *DB) IPLDsColumnNames() []string {
	panic("implement me")
}

func (db *DB) TipSetsTableName() []string {
	panic("implement me")
}

func (db *DB) TipSetsColumnNames() []string {
	panic("implement me")
}

func (db *DB) BlockHeadersTableName() []string {
	panic("implement me")
}

func (db *DB) BlockHeadersColumnNames() []string {
	panic("implement me")
}

func (db *DB) BlockParentsTableName() []string {
	panic("implement me")
}

func (db *DB) BlockParentsColumnNames() []string {
	panic("implement me")
}

func (db *DB) MessagesTableName() []string {
	panic("implement me")
}

func (db *DB) MessagesColumnNames() []string {
	panic("implement me")
}

func (db *DB) ReceiptsTableName() []string {
	panic("implement me")
}

func (db *DB) ReceiptsColumnNames() []string {
	panic("implement me")
}

func (db *DB) DRandsTableName() []string {
	panic("implement me")
}

func (db *DB) DRandsColumnNames() []string {
	panic("implement me")
}

func (db *DB) IDAddressesTableName() []string {
	panic("implement me")
}

func (db *DB) IDAddressesColumnNames() []string {
	panic("implement me")
}

func (db *DB) MarketDealsTableName() []string {
	panic("implement me")
}

func (db *DB) MarketDealsColumnNames() []string {
	panic("implement me")
}

func (db *DB) ActorsTableName() []string {
	panic("implement me")
}

func (db *DB) ActorsColumnNames() []string {
	panic("implement me")
}

func (db *DB) MinerInfosTableName() []string {
	panic("implement me")
}

func (db *DB) MinerInfosColumnNames() []string {
	panic("implement me")
}
