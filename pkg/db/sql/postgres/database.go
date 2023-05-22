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

func (db *DB) InsertCIDsStm() string {
	return schema.TableCIDs.ToInsertStatement(db.upsert)
}

func (db *DB) InsertIPLDsStm() string {
	return schema.TableIPLDs.ToInsertStatement(db.upsert)
}

func (db *DB) InsertTipSetsStm() string {
	return schema.TableTipSets.ToInsertStatement(db.upsert)
}

func (db *DB) InsertTipSetMembersStm() string {
	return schema.TableTipSetMembers.ToInsertStatement(db.upsert)
}

func (db *DB) InsertBlockHeadersStm() string {
	return schema.TableBlockHeaders.ToInsertStatement(db.upsert)
}

func (db *DB) InsertBlockParentsStm() string {
	return schema.TableBlockParents.ToInsertStatement(db.upsert)
}

func (db *DB) InsertBlockMessagesStm() string {
	return schema.TableBlockMessages.ToInsertStatement(db.upsert)
}

func (db *DB) InsertMessagesStm() string {
	return schema.TableMessages.ToInsertStatement(db.upsert)
}

func (db *DB) InsertParsedMessagesStm() string {
	return schema.TableParsedMessages.ToInsertStatement(db.upsert)
}

func (db *DB) InsertInternalMessagesStm() string {
	return schema.TableInternalMessages.ToInsertStatement(db.upsert)
}

func (db *DB) InsertInternalParsedMessagesStm() string {
	return schema.TableInternalParsedMessages.ToInsertStatement(db.upsert)
}

func (db *DB) InsertVMMessagesStm() string {
	return schema.TableVMMessages.ToInsertStatement(db.upsert)
}

func (db *DB) InsertReceiptsStm() string {
	return schema.TableReceipts.ToInsertStatement(db.upsert)
}

func (db *DB) InsertDRandsStm() string {
	return schema.TableDrandBlockEntries.ToInsertStatement(db.upsert)
}

func (db *DB) InsertActorsStm() string {
	return schema.TableActors.ToInsertStatement(db.upsert)
}

func (db *DB) InsertActorStateStm() string {
	return schema.TableActorState.ToInsertStatement(db.upsert)
}

func (db *DB) InsertActorEventsStm() string {
	return schema.TableActorEvents.ToInsertStatement(db.upsert)
}

func (db *DB) InsertInitActorIdAddressesStm() string {
	return schema.TableInitActorIDAddresses.ToInsertStatement(db.upsert)
}

func (db *DB) InsertCronActorMethodReceiversStm() string {
	return schema.TableCronActorMethodReceivers.ToInsertStatement(db.upsert)
}

func (db *DB) InsertRewardActorStateStm() string {
	return schema.TableRewardActorState.ToInsertStatement(db.upsert)
}

func (db *DB) InsertAccountActorAddressesStm() string {
	return schema.TableAccountActorAddresses.ToInsertStatement(db.upsert)
}

func (db *DB) InsertStorageActorStateStm() string {
	return schema.TableStorageActorState.ToInsertStatement(db.upsert)
}

func (db *DB) InsertStorageActorDealProposalsStm() string {
	return schema.TableStorageActorDealProposals.ToInsertStatement(db.upsert)
}

func (db *DB) InsertStorageActorDealStateStm() string {
	return schema.TableStorageActorDealState.ToInsertStatement(db.upsert)
}

func (db *DB) InsertStorageActorPendingProposalsStm() string {
	return schema.TableStorageActorPendingProposals.ToInsertStatement(db.upsert)
}

func (db *DB) InsertStorageActorEscrowsStm() string {
	return schema.TableStorageActorEscrows.ToInsertStatement(db.upsert)
}

func (db *DB) InsertStorageActorLockedFundsStm() string {
	return schema.TableStorageActorLockedTokens.ToInsertStatement(db.upsert)
}

func (db *DB) InsertStorageActorDealOpsBucketsStm() string {
	return schema.TableStorageActorDealOpsBuckets.ToInsertStatement(db.upsert)
}

func (db *DB) InsertStorageActorDealOpsAtEpochStm() string {
	return schema.TableStorageActorDealOpsAtEpoch.ToInsertStatement(db.upsert)
}

func (db *DB) InsertMinerActorStateStm() string {
	return schema.TableMinerActorState.ToInsertStatement(db.upsert)
}

func (db *DB) InsertMinerInfosStm() string {
	return schema.TableMinerInfos.ToInsertStatement(db.upsert)
}

func (db *DB) InsertMinerVestingFundsStm() string {
	return schema.TableMinerVestingFunds.ToInsertStatement(db.upsert)
}

func (db *DB) InsertMinerDeadlinesStm() string {
	return schema.TableMinerDeadlines.ToInsertStatement(db.upsert)
}

func (db *DB) InsertMinerPreCommittedSectorInfosStm() string {
	return schema.TableMinerPreCommittedSectorInfos.ToInsertStatement(db.upsert)
}

func (db *DB) InsertMinerSectorInfosStm() string {
	return schema.TableMinerSectorInfos.ToInsertStatement(db.upsert)
}

func (db *DB) InsertMinerPartitionsStm() string {
	return schema.TableMinerPartitions.ToInsertStatement(db.upsert)
}

func (db *DB) InsertMinerPartitionExpirationsStm() string {
	return schema.TableMinerPartitionExpirations.ToInsertStatement(db.upsert)
}

func (db *DB) InsertMultisigActorStateStm() string {
	return schema.TableMultisigActorState.ToInsertStatement(db.upsert)
}

func (db *DB) InsertMultisigActorPendingTxsStm() string {
	return schema.TableMultisigPendingTransactions.ToInsertStatement(db.upsert)
}

func (db *DB) InsertPaymentChannelActorStateStm() string {
	return schema.TablePaymentChannelActorState.ToInsertStatement(db.upsert)
}

func (db *DB) InsertPaymentChannelLaneStateStm() string {
	return schema.TablePaymentChannelLaneState.ToInsertStatement(db.upsert)
}

func (db *DB) InsertStoragePowerActorStateStm() string {
	return schema.TableStoragePowerActorState.ToInsertStatement(db.upsert)
}

func (db *DB) InsertStoragePowerCronBucketsStm() string {
	return schema.TableStoragePowerCronEventBuckets.ToInsertStatement(db.upsert)
}

func (db *DB) InsertStoragePowerCronEventsStm() string {
	return schema.TableStoragePowerCronEvents.ToInsertStatement(db.upsert)
}

func (db *DB) InsertStoragePowerClaimsStm() string {
	return schema.TableStoragePowerClaims.ToInsertStatement(db.upsert)
}

func (db *DB) InsertStoragePowerProofValidationBucketsStm() string {
	return schema.TableStoragePowerProofValidationBuckets.ToInsertStatement(db.upsert)
}

func (db *DB) InsertStoragePowerProofSealVerifyInfosStm() string {
	return schema.TableStoragePowerProofSealVerifyInfos.ToInsertStatement(db.upsert)
}

func (db *DB) InsertVerifiedRegistryActorStateStm() string {
	return schema.TableVerifiedRegistryActorState.ToInsertStatement(db.upsert)
}

func (db *DB) InsertVerifiedRegistryVerifiersStm() string {
	return schema.TableVerifiedRegistryVerifiers.ToInsertStatement(db.upsert)
}

func (db *DB) InsertVerifiedRegistryClientsStm() string {
	return schema.TableVerifiedRegistryClients.ToInsertStatement(db.upsert)
}

func (db *DB) InsertFEVMActorStateStm() string {
	return schema.TableFEVMActorState.ToInsertStatement(db.upsert)
}

func (db *DB) InsertFEVMActorStorageStm() string {
	return schema.TableFEVMActorStorage.ToInsertStatement(db.upsert)
}

func (db *DB) CIDsTableName() []string {
	return schema.TableCIDs.FullName()
}

func (db *DB) CIDsColumnNames() []string {
	return schema.TableCIDs.ColumnNames()
}

func (db *DB) IPLDsTableName() []string {
	return schema.TableIPLDs.FullName()
}

func (db *DB) IPLDsColumnNames() []string {
	return schema.TableIPLDs.ColumnNames()
}

func (db *DB) TipSetsTableName() []string {
	return schema.TableTipSets.FullName()
}

func (db *DB) TipSetsColumnNames() []string {
	return schema.TableTipSets.ColumnNames()
}

func (db *DB) TipSetMembersTableName() []string {
	return schema.TableTipSetMembers.FullName()
}

func (db *DB) TipSetMembersColumnNames() []string {
	return schema.TableTipSetMembers.ColumnNames()
}

func (db *DB) BlockHeadersTableName() []string {
	return schema.TableBlockHeaders.FullName()
}

func (db *DB) BlockHeadersColumnNames() []string {
	return schema.TableBlockHeaders.ColumnNames()
}

func (db *DB) BlockParentsTableName() []string {
	return schema.TableBlockParents.FullName()
}

func (db *DB) BlockParentsColumnNames() []string {
	return schema.TableBlockParents.ColumnNames()
}

func (db *DB) BlockMessagesTableName() []string {
	return schema.TableBlockMessages.FullName()
}

func (db *DB) BlockMessagesColumnNames() []string {
	return schema.TableBlockMessages.ColumnNames()
}

func (db *DB) MessagesTableName() []string {
	return schema.TableMessages.FullName()
}

func (db *DB) MessagesColumnNames() []string {
	return schema.TableMessages.ColumnNames()
}

func (db *DB) ParsedMessagesTableName() []string {
	return schema.TableParsedMessages.FullName()
}

func (db *DB) ParsedMessagesColumnNames() []string {
	return schema.TableParsedMessages.ColumnNames()
}

func (db *DB) InternalMessagesTableName() []string {
	return schema.TableInternalMessages.FullName()
}

func (db *DB) InternalMessagesColumnNames() []string {
	return schema.TableInternalMessages.ColumnNames()
}

func (db *DB) InternalParsedMessagesTableName() []string {
	return schema.TableParsedMessages.FullName()
}

func (db *DB) InternalParsedMessagesColumnNames() []string {
	return schema.TableParsedMessages.ColumnNames()
}

func (db *DB) VMMessagesTableName() []string {
	return schema.TableVMMessages.FullName()
}

func (db *DB) VMMessagesColumnNames() []string {
	return schema.TableVMMessages.ColumnNames()
}

func (db *DB) ReceiptsTableName() []string {
	return schema.TableReceipts.FullName()
}

func (db *DB) ReceiptsColumnNames() []string {
	return schema.TableReceipts.ColumnNames()
}

func (db *DB) DRandsTableName() []string {
	return schema.TableDrandBlockEntries.FullName()
}

func (db *DB) DRandsColumnNames() []string {
	return schema.TableDrandBlockEntries.ColumnNames()
}

func (db *DB) ActorsTableName() []string {
	return schema.TableActors.FullName()
}

func (db *DB) ActorsColumnNames() []string {
	return schema.TableActors.ColumnNames()
}

func (db *DB) ActorStateTableName() []string {
	return schema.TableActorState.FullName()
}

func (db *DB) ActorStateColumnNames() []string {
	return schema.TableActorState.ColumnNames()
}

func (db *DB) ActorEventsTableName() []string {
	return schema.TableActorEvents.FullName()
}

func (db *DB) ActorEventsColumnNames() []string {
	return schema.TableActorEvents.ColumnNames()
}

func (db *DB) InitActorIdAddressesTableName() []string {
	return schema.TableInitActorIDAddresses.FullName()
}

func (db *DB) InitActorIdAddressesColumnNames() []string {
	return schema.TableInitActorIDAddresses.ColumnNames()
}

func (db *DB) CronActorMethodReceiversTableName() []string {
	return schema.TableCronActorMethodReceivers.FullName()
}

func (db *DB) CronActorMethodReceiversColumnNames() []string {
	return schema.TableCronActorMethodReceivers.ColumnNames()
}

func (db *DB) RewardActorStateTableName() []string {
	return schema.TableRewardActorState.FullName()
}

func (db *DB) RewardActorStateColumnNames() []string {
	return schema.TableRewardActorState.ColumnNames()
}

func (db *DB) AccountActorAddressesTableName() []string {
	return schema.TableAccountActorAddresses.FullName()
}

func (db *DB) AccountActorAddressColumnNames() []string {
	return schema.TableAccountActorAddresses.ColumnNames()
}

func (db *DB) StorageActorStateTableName() []string {
	return schema.TableStorageActorState.FullName()
}

func (db *DB) StorageActorStateColumnNames() []string {
	return schema.TableStorageActorState.ColumnNames()
}

func (db *DB) StorageActorDealProposalsTableName() []string {
	return schema.TableStorageActorDealProposals.FullName()
}

func (db *DB) StorageActorDealProposalsColumnNames() []string {
	return schema.TableStorageActorDealProposals.ColumnNames()
}

func (db *DB) StorageActorDealStateTableName() []string {
	return schema.TableStorageActorDealState.FullName()
}

func (db *DB) StorageActorDealStateColumnNames() []string {
	return schema.TableStorageActorDealState.ColumnNames()
}

func (db *DB) StorageActorPendingProposalsTableName() []string {
	return schema.TableStorageActorPendingProposals.FullName()
}

func (db *DB) StorageActorPendingProposalsColumnNames() []string {
	return schema.TableStorageActorPendingProposals.ColumnNames()
}

func (db *DB) StorageActorEscrowsTableName() []string {
	return schema.TableStorageActorEscrows.FullName()
}

func (db *DB) StorageActorEscrowsColumnNames() []string {
	return schema.TableStorageActorEscrows.ColumnNames()
}

func (db *DB) StorageActorLockedTokensTableName() []string {
	return schema.TableStorageActorLockedTokens.FullName()
}

func (db *DB) StorageActorLockedTokensColumnNames() []string {
	return schema.TableStorageActorLockedTokens.ColumnNames()
}

func (db *DB) StorageActorDealOpsBucketsTableName() []string {
	return schema.TableStorageActorDealOpsBuckets.FullName()
}

func (db *DB) StorageActorDealOpsBucketsColumnNames() []string {
	return schema.TableStorageActorDealOpsBuckets.ColumnNames()
}

func (db *DB) StorageActorDealOpsAtEpochTableName() []string {
	return schema.TableStorageActorDealOpsAtEpoch.FullName()
}

func (db *DB) StorageActorDealOpsAtEpochColumnNames() []string {
	return schema.TableStorageActorDealOpsAtEpoch.ColumnNames()
}

func (db *DB) MinerActorStateTableName() []string {
	return schema.TableMinerActorState.FullName()
}

func (db *DB) MinerActorStateColumnNames() []string {
	return schema.TableMinerActorState.ColumnNames()
}

func (db *DB) MinerInfosTableName() []string {
	return schema.TableMinerInfos.FullName()
}

func (db *DB) MinerInfosColumnNames() []string {
	return schema.TableMinerInfos.ColumnNames()
}

func (db *DB) MinerVestingFundsTableName() []string {
	return schema.TableMinerVestingFunds.FullName()
}

func (db *DB) MinerVestingFundsColumnNames() []string {
	return schema.TableMinerVestingFunds.ColumnNames()
}

func (db *DB) MinerDeadlinesTableName() []string {
	return schema.TableMinerDeadlines.FullName()
}

func (db *DB) MinerDeadlinesColumnNames() []string {
	return schema.TableMinerDeadlines.ColumnNames()
}

func (db *DB) MinerPreCommittedSectorInfosTableName() []string {
	return schema.TableMinerPreCommittedSectorInfos.FullName()
}

func (db *DB) MinerPreCommittedSectorInfosColumnNames() []string {
	return schema.TableMinerPreCommittedSectorInfos.ColumnNames()
}

func (db *DB) MinerSectorInfosTableName() []string {
	return schema.TableMinerSectorInfos.FullName()
}

func (db *DB) MinerSectorInfosColumnNames() []string {
	return schema.TableMinerSectorInfos.ColumnNames()
}

func (db *DB) MinerPartitionsTableName() []string {
	return schema.TableMinerPartitions.FullName()
}

func (db *DB) MinerPartitionsColumnNames() []string {
	return schema.TableMinerPartitions.ColumnNames()
}

func (db *DB) MinerPartitionExpirationsTableName() []string {
	return schema.TableMinerPartitionExpirations.FullName()
}

func (db *DB) MinerPartitionExpirationsColumnNames() []string {
	return schema.TableMinerPartitionExpirations.ColumnNames()
}

func (db *DB) MultisigActorStateTableName() []string {
	return schema.TableMultisigActorState.FullName()
}

func (db *DB) MultisigActorStateColumnNames() []string {
	return schema.TableMultisigActorState.ColumnNames()
}

func (db *DB) MultisigPendingTxsTableName() []string {
	return schema.TableMultisigPendingTransactions.FullName()
}

func (db *DB) MultisigPendingTxsColumnNames() []string {
	return schema.TableMultisigPendingTransactions.ColumnNames()
}

func (db *DB) PaymentChannelActorStateTableName() []string {
	return schema.TablePaymentChannelActorState.FullName()
}

func (db *DB) PaymentChannelActorStateColumnNames() []string {
	return schema.TablePaymentChannelActorState.ColumnNames()
}

func (db *DB) PaymentChannelLaneStateTableName() []string {
	return schema.TablePaymentChannelLaneState.FullName()
}

func (db *DB) PaymentChannelLaneStateColumnNames() []string {
	return schema.TablePaymentChannelLaneState.ColumnNames()
}

func (db *DB) StoragePowerActorStateTableName() []string {
	return schema.TableStoragePowerActorState.FullName()
}

func (db *DB) StoragePowerActorStateColumnNames() []string {
	return schema.TableStoragePowerActorState.ColumnNames()
}

func (db *DB) StoragePowerCronEventBucketsTableName() []string {
	return schema.TableStoragePowerCronEventBuckets.FullName()
}

func (db *DB) StoragePowerCronEventBucketsColumnNames() []string {
	return schema.TableStoragePowerCronEventBuckets.ColumnNames()
}

func (db *DB) StoragePowerCronEventsTableName() []string {
	return schema.TableStoragePowerCronEvents.FullName()
}

func (db *DB) StoragePowerCronEventsColumnNames() []string {
	return schema.TableStoragePowerCronEvents.ColumnNames()
}

func (db *DB) StoragePowerClaimsTableName() []string {
	return schema.TableStoragePowerClaims.FullName()
}

func (db *DB) StoragePowerClaimsColumnNames() []string {
	return schema.TableStoragePowerClaims.ColumnNames()
}

func (db *DB) StoragePowerProofValidationBucketsTableName() []string {
	return schema.TableStoragePowerProofValidationBuckets.FullName()
}

func (db *DB) StoragePowerProofValidationBucketsColumnNames() []string {
	return schema.TableStoragePowerProofValidationBuckets.ColumnNames()
}

func (db *DB) StoragePowerProofSealVerifyInfosTableName() []string {
	return schema.TableStoragePowerProofSealVerifyInfos.FullName()
}

func (db *DB) StoragePowerProofSealVerifyInfosColumnNames() []string {
	return schema.TableStoragePowerProofSealVerifyInfos.ColumnNames()
}

func (db *DB) VerifiedRegistryActorStateTableName() []string {
	return schema.TableVerifiedRegistryActorState.FullName()
}

func (db *DB) VerifiedRegistryVerifiersTableName() []string {
	return schema.TableVerifiedRegistryVerifiers.FullName()
}

func (db *DB) VerifiedRegistryVerifiersColumnNames() []string {
	return schema.TableVerifiedRegistryVerifiers.ColumnNames()
}

func (db *DB) VerifiedRegistryClientsTableName() []string {
	return schema.TableVerifiedRegistryClients.FullName()
}

func (db *DB) VerifiedRegistryClientsColumnNames() []string {
	return schema.TableVerifiedRegistryClients.ColumnNames()
}

func (db *DB) FEVMActorStateTableNames() []string {
	return schema.TableFEVMActorState.FullName()
}

func (db *DB) FEVMActorStateColumnNames() []string {
	return schema.TableFEVMActorState.ColumnNames()
}

func (db *DB) FEVMActorStorageTableNames() []string {
	return schema.TableFEVMActorStorage.FullName()
}

func (db *DB) FEVMActorStorageColumnNames() []string {
	return schema.TableFEVMActorStorage.ColumnNames()
}
