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
	InsertTipSetsStm() string
	InsertTipSetMembersStm() string
	InsertBlockHeadersStm() string
	InsertBlockParentsStm() string
	InsertBlockMessagesStm() string
	InsertMessagesStm() string
	InsertParsedMessagesStm() string
	InsertInternalMessagesStm() string
	InsertInternalParsedMessagesStm() string
	InsertVMMessagesStm() string
	InsertReceiptsStm() string
	InsertDRandsStm() string
	InsertActorsStm() string
	InsertActorStateStm() string
	InsertActorEventsStm() string
	InsertInitActorIdAddressesStm() string
	InsertCronActorMethodReceiversStm() string
	InsertRewardActorStateStm() string
	InsertAccountActorAddressesStm() string
	InsertStorageActorStateStm() string
	InsertStorageActorDealProposalsStm() string
	InsertStorageActorDealStateStm() string
	InsertStorageActorPendingProposalsStm() string
	InsertStorageActorEscrowsStm() string
	InsertStorageActorLockedFundsStm() string
	InsertStorageActorDealOpsBucketsStm() string
	InsertStorageActorDealOpsAtEpochStm() string
	InsertMinerActorStateStm() string
	InsertMinerInfosStm() string
	InsertMinerVestingFundsStm() string
	InsertMinerDeadlinesStm() string
	InsertMinerPreCommittedSectorInfosStm() string
	InsertMinerSectorInfosStm() string
	InsertMinerPartitionsStm() string
	InsertMinerPartitionExpirationsStm() string
	InsertMultisigActorStateStm() string
	InsertMultisigActorPendingTxsStm() string
	InsertPaymentChannelActorStateStm() string
	InsertPaymentChannelLaneStateStm() string
	InsertStoragePowerActorStateStm() string
	InsertStoragePowerCronBucketsStm() string
	InsertStoragePowerCronEventsStm() string
	InsertStoragePowerClaimsStm() string
	InsertStoragePowerProofValidationBucketsStm() string
	InsertStoragePowerProofSealVerifyInfosStm() string
	InsertVerifiedRegistryActorStateStm() string
	InsertVerifiedRegistryVerifiersStm() string
	InsertVerifiedRegistryClientsStm() string
	InsertFEVMActorStateStm() string
	InsertFEVMActorStorageStm() string

	// Table/column descriptions for use with CopyFrom and similar commands.
	CIDsTableName() []string
	CIDsColumnNames() []string
	IPLDsTableName() []string
	IPLDsColumnNames() []string
	TipSetsTableName() []string
	TipSetsColumnNames() []string
	TipSetMembersTableName() []string
	TipSetMembersColumnNames() []string
	BlockHeadersTableName() []string
	BlockHeadersColumnNames() []string
	BlockParentsTableName() []string
	BlockParentsColumnNames() []string
	BlockMessagesTableName() []string
	BlockMessagesColumnNames() []string
	MessagesTableName() []string
	MessagesColumnNames() []string
	ParsedMessagesTableName() []string
	ParsedMessagesColumnNames() []string
	InternalMessagesTableName() []string
	InternalMessagesColumnNames() []string
	InternalParsedMessagesTableName() []string
	InternalParsedMessagesColumnNames() []string
	VMMessagesTableName() []string
	VMMessagesColumnNames() []string
	ReceiptsTableName() []string
	ReceiptsColumnNames() []string
	DRandsTableName() []string
	DRandsColumnNames() []string
	ActorsTableName() []string
	ActorsColumnNames() []string
	ActorStateTableName() []string
	ActorStateColumnNames() []string
	ActorEventsTableName() []string
	ActorEventsColumnNames() []string
	InitActorIdAddressesTableName() []string
	InitActorIdAddressesColumnNames() []string
	CronActorMethodReceiversTableName() []string
	CronActorMethodReceiversColumnNames() []string
	RewardActorStateTableName() []string
	RewardActorStateColumnNames() []string
	AccountActorAddressesTableName() []string
	AccountActorAddressColumnNames() []string
	StorageActorStateTableName() []string
	StorageActorStateColumnNames() []string
	StorageActorDealProposalsTableName() []string
	StorageActorDealProposalsColumnNames() []string
	StorageActorDealStateTableName() []string
	StorageActorDealStateColumnNames() []string
	StorageActorPendingProposalsTableName() []string
	StorageActorPendingProposalsColumnNames() []string
	StorageActorEscrowsTableName() []string
	StorageActorEscrowsColumnNames() []string
	StorageActorLockedTokensTableName() []string
	StorageActorLockedTokensColumnNames() []string
	StorageActorDealOpsBucketsTableName() []string
	StorageActorDealOpsBucketsColumnNames() []string
	StorageActorDealOpsAtEpochTableName() []string
	StorageActorDealOpsAtEpochColumnNames() []string
	MinerActorStateTableName() []string
	MinerActorStateColumnNames() []string
	MinerInfosTableName() []string
	MinerInfosColumnNames() []string
	MinerVestingFundsTableName() []string
	MinerVestingFundsColumnNames() []string
	MinerDeadlinesTableName() []string
	MinerDeadlinesColumnNames() []string
	MinerPreCommittedSectorInfosTableName() []string
	MinerPreCommittedSectorInfosColumnNames() []string
	MinerSectorInfosTableName() []string
	MinerSectorInfosColumnNames() []string
	MinerPartitionsTableName() []string
	MinerPartitionsColumnNames() []string
	MinerPartitionExpirationsTableName() []string
	MinerPartitionExpirationsColumnNames() []string
	MultisigActorStateTableName() []string
	MultisigActorStateColumnNames() []string
	MultisigPendingTxsTableName() []string
	MultisigPendingTxsColumnNames() []string
	PaymentChannelActorStateTableName() []string
	PaymentChannelActorStateColumnNames() []string
	PaymentChannelLaneStateTableName() []string
	PaymentChannelLaneStateColumnNames() []string
	StoragePowerActorStateTableName() []string
	StoragePowerActorStateColumnNames() []string
	StoragePowerCronEventBucketsTableName() []string
	StoragePowerCronEventBucketsColumnNames() []string
	StoragePowerCronEventsTableName() []string
	StoragePowerCronEventsColumnNames() []string
	StoragePowerClaimsTableName() []string
	StoragePowerClaimsColumnNames() []string
	StoragePowerProofValidationBucketsTableName() []string
	StoragePowerProofValidationBucketsColumnNames() []string
	StoragePowerProofSealVerifyInfosTableName() []string
	StoragePowerProofSealVerifyInfosColumnNames() []string
	VerifiedRegistryActorStateTableName() []string
	VerifiedRegistryVerifiersTableName() []string
	VerifiedRegistryVerifiersColumnNames() []string
	VerifiedRegistryClientsTableName() []string
	VerifiedRegistryClientsColumnNames() []string
	FEVMActorStateTableNames() []string
	FEVMActorStateColumnNames() []string
	FEVMActorStorageTableNames() []string
	FEVMActorStorageColumnNames() []string
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
