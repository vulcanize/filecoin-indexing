package schema

import (
	"encoding/json"

	"github.com/lib/pq"
)

type Model interface {
	Schema() string
	TableName() string
	Values() []interface{}
}

// IPLDModel is the db model for ipld.blocks
type IPLDModel struct {
	Height string `db:"height"`
	Key    string `db:"key"`
	Data   []byte `db:"data"`
}

func (m IPLDModel) Schema() string {
	return "ipld"
}

func (m IPLDModel) TableName() string {
	return "blocks"
}

func (m IPLDModel) Values() []interface{} {
	return []interface{}{m.Height, m.Key, m.Data}
}

type CIDModel struct {
	ID  string `db:"id"`
	CID string `db:"cid"`
}

func (m CIDModel) Schema() string {
	return "filecoin"
}

func (m CIDModel) TableName() string {
	return "cids"
}

func (m CIDModel) Values() []interface{} {
	return []interface{}{m.CID, m.ID}
}

type TipSetModel struct {
	Height             string `db:"height"`
	ParentTipSetKey    string `db:"parent_tip_set_key"`
	ParentStateRootCID string `db:"parent_state_root_cid"`
}

func (m TipSetModel) Schema() string {
	return "filecoin"
}

func (m TipSetModel) TableName() string {
	return "tip_sets"
}

func (m TipSetModel) Values() []interface{} {
	return []interface{}{m.Height, m.ParentTipSetKey, m.ParentStateRootCID}
}

type TipSetMember struct {
	Height          string `db:"height"`
	ParentTipSetKey string `db:"parent_tip_set_key"`
	Index           string `db:"index"`
	BlockCID        string `db:"block_cid"`
}

func (m TipSetMember) Schema() string {
	return "filecoin"
}

func (m TipSetMember) TableName() string {
	return "tip_set_members"
}

func (m TipSetMember) Values() []interface{} {
	return []interface{}{m.Height, m.ParentTipSetKey, m.Index, m.BlockCID}
}

type BlockHeaderModel struct {
	Height                       string `db:"height"`
	BlockCID                     string `db:"block_cid"`
	ParentWeight                 string `db:"parent_weight"`
	ParentStateRootCID           string `db:"parent_state_root_cid"`
	ParentTipSetKeyCID           string `db:"parent_tip_set_key_cid"`
	ParentMessageReceiptsRootCID string `db:"parent_message_receipts_root_cid"`
	MessagesRootCID              string `db:"messages_root_cid"`
	BLSAggregate                 string `db:"bls_aggregate"`
	Miner                        string `db:"miner"`
	BlockSig                     string `db:"block_sig"`
	Timestamp                    string `db:"timestamp"`
	WinCount                     string `db:"win_count"`
	ParentBaseFee                string `db:"parent_base_fee"`
	ForkSignaling                string `db:"fork_signaling"`
}

func (m BlockHeaderModel) Schema() string {
	return "filecoin"
}

func (m BlockHeaderModel) TableName() string {
	return "block_headers"
}

func (m BlockHeaderModel) Values() []interface{} {
	return []interface{}{m.Height, m.BlockCID, m.ParentWeight, m.ParentStateRootCID, m.ParentTipSetKeyCID,
		m.ParentMessageReceiptsRootCID, m.MessagesRootCID, m.BLSAggregate, m.Miner, m.BlockSig,
		m.Timestamp, m.WinCount, m.ParentBaseFee, m.ForkSignaling}
}

type BlockParentModel struct {
	Height    string `db:"height"`
	BlockCID  string `db:"block_cid"`
	ParentCID string `db:"parent_cid"`
}

func (m BlockParentModel) Schema() string {
	return "filecoin"
}

func (m BlockParentModel) TableName() string {
	return "block_parents"
}

func (m BlockParentModel) Values() []interface{} {
	return []interface{}{m.Height, m.BlockCID, m.ParentCID}
}

type BlockMessageModel struct {
	Height     string `db:"height"`
	BlockCID   string `db:"block_cid"`
	MessageCID string `db:"message_cid"`
}

func (m BlockMessageModel) Schema() string {
	return "filecoin"
}

func (m BlockMessageModel) TableName() string {
	return "block_messages"
}

func (m BlockMessageModel) Values() []interface{} {
	return []interface{}{m.Height, m.BlockCID, m.MessageCID}
}

type MessageModel struct {
	Height         string        `db:"height"`
	BlockCID       string        `db:"block_cid"`
	MessageCID     string        `db:"message_cid"`
	From           string        `db:"from"`
	To             string        `db:"to"`
	SizeBytes      string        `db:"size_bytes"`
	Nonce          string        `db:"nonce"`
	Value          string        `db:"value"`
	GasFeeCap      string        `db:"gas_fee_cap"`
	GasPremium     string        `db:"gas_premium"`
	GasLimit       string        `db:"gas_limit"`
	Method         string        `db:"method"`
	SelectorSuffix pq.Int32Array `db:"selector_suffix"`
}

func (m MessageModel) Schema() string {
	return "filecoin"
}

func (m MessageModel) TableName() string {
	return "messages"
}

func (m MessageModel) Values() []interface{} {
	return []interface{}{m.Height, m.BlockCID, m.MessageCID, m.From, m.To, m.SizeBytes, m.Nonce, m.Value,
		m.GasFeeCap, m.GasPremium, m.GasLimit, m.Method, m.SelectorSuffix}
}

type ParsedMessageModel struct {
	Height     string                 `db:"height"`
	BlockCID   string                 `db:"block_cid"`
	MessageCID string                 `db:"message_cid"`
	Params     map[string]interface{} `db:"params"`
}

func (m ParsedMessageModel) Schema() string {
	return "filecoin"
}

func (m ParsedMessageModel) TableName() string {
	return "parsed_messages"
}

func (m ParsedMessageModel) Values() []interface{} {
	b, _ := json.Marshal(m.Params)
	return []interface{}{m.Height, m.BlockCID, m.MessageCID, string(b)}
}

type InternalMessageModel struct {
	Height         string        `db:"height"`
	BlockCID       string        `db:"block_cid"`
	MessageCID     string        `db:"message_cid"`
	Source         string        `db:"source"`
	From           string        `db:"from"`
	To             string        `db:"to"`
	Value          string        `db:"value"`
	Method         string        `db:"method"`
	ActorName      string        `db:"actor_name"`
	ActorFamily    string        `db:"actor_family"`
	ExitCode       string        `db:"exit_code"`
	GasUsed        string        `db:"gas_used"`
	SelectorSuffix pq.Int32Array `db:"selector_suffix"`
}

func (m InternalMessageModel) Schema() string {
	return "filecoin"
}

func (m InternalMessageModel) TableName() string {
	return "internal_messages"
}

func (m InternalMessageModel) Values() []interface{} {
	return []interface{}{m.Height, m.BlockCID, m.MessageCID, m.Source, m.From, m.To, m.Value, m.Method,
		m.ActorName, m.ActorFamily, m.ExitCode, m.GasUsed, m.SelectorSuffix}
}

type InternalParsedMessageModel struct {
	Height     string                 `db:"height"`
	BlockCID   string                 `db:"block_cid"`
	MessageCID string                 `db:"message_cid"`
	Source     string                 `db:"source"`
	Params     map[string]interface{} `db:"params"`
}

func (m InternalParsedMessageModel) Schema() string {
	return "filecoin"
}

func (m InternalParsedMessageModel) TableName() string {
	return "internal_parsed_messages"
}

func (m InternalParsedMessageModel) Values() []interface{} {
	b, _ := json.Marshal(m.Params)
	return []interface{}{m.Height, m.BlockCID, m.MessageCID, m.Source, string(b)}
}

type VMMessageModel struct {
	Height     string                 `db:"height"`
	BlockCID   string                 `db:"block_cid"`
	MessageCID string                 `db:"message_cid"`
	Source     string                 `db:"source"`
	ActorCode  string                 `db:"actor_code"`
	Params     map[string]interface{} `db:"params"`
	Returns    map[string]interface{} `db:"returns"`
}

func (m VMMessageModel) Schema() string {
	return "filecoin"
}

func (m VMMessageModel) TableName() string {
	return "vm_messages"
}

func (m VMMessageModel) Values() []interface{} {
	b, _ := json.Marshal(m.Params)
	c, _ := json.Marshal(m.Returns)
	return []interface{}{m.Height, m.BlockCID, m.MessageCID, m.Source, m.ActorCode, string(b), string(c)}
}

type ReceiptModel struct {
	Height         string        `db:"height"`
	BlockCID       string        `db:"block_cid"`
	MessageCID     string        `db:"message_cid"`
	Index          string        `db:"idx"`
	ExitCode       string        `db:"exit_code"`
	GasUsed        string        `db:"gas_used"`
	Return         []byte        `db:"return"`
	SelectorSuffix pq.Int32Array `db:"selector_suffix"`
}

func (m ReceiptModel) Schema() string {
	return "filecoin"
}

func (m ReceiptModel) TableName() string {
	return "receipts"
}

func (m ReceiptModel) Values() []interface{} {
	return []interface{}{m.Height, m.BlockCID, m.MessageCID, m.Index, m.ExitCode, m.GasUsed, m.Return, m.SelectorSuffix}
}

type DRandBlockEntryModel struct {
	Height            string `db:"height"`
	BlockCID          string `db:"block_cid"`
	Round             string `db:"round"`
	Signature         []byte `db:"signature"`
	PreviousSignature []byte `db:"previous_signature"`
}

func (m DRandBlockEntryModel) Schema() string {
	return "filecoin"
}

func (m DRandBlockEntryModel) TableName() string {
	return "drand_block_entries"
}

func (m DRandBlockEntryModel) Values() []interface{} {
	return []interface{}{m.Height, m.BlockCID, m.Round, m.Signature, m.PreviousSignature}
}

type ActorModel struct {
	Height         string        `db:"height"`
	StateRootCID   string        `db:"state_root_cid"`
	ID             string        `db:"id"`
	Code           string        `db:"code"`
	HeadCID        string        `db:"head_cid"`
	Nonce          string        `db:"nonce"`
	Balance        string        `db:"balance"`
	SelectorSuffix pq.Int32Array `db:"selector_suffix"`
}

func (m ActorModel) Schema() string {
	return "filecoin"
}

func (m ActorModel) TableName() string {
	return "actors"
}

func (m ActorModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.ID, m.Code, m.HeadCID, m.Nonce, m.Balance, m.SelectorSuffix}
}

type ActorStateModel struct {
	Height       string                 `db:"height"`
	StateRootCID string                 `db:"state_root_cid"`
	ID           string                 `db:"id"`
	State        map[string]interface{} `db:"state"`
}

func (m ActorStateModel) Schema() string {
	return "filecoin"
}

func (m ActorStateModel) TableName() string {
	return "actor_state"
}

func (m ActorStateModel) Values() []interface{} {
	b, _ := json.Marshal(m.State)
	return []interface{}{m.Height, m.StateRootCID, m.ID, string(b)}
}

type ActorEventModel struct {
	Height     string `db:"height"`
	BlockCID   string `db:"block_cid"`
	MessageCID string `db:"message_cid"`
	EventIndex string `db:"event_index"`
	Emitter    string `db:"emitter"`
	Flags      []byte `db:"flags"`
	Codec      string `db:"codec"`
	Key        string `db:"key"`
	Value      []byte `db:"value"`
}

func (m ActorEventModel) Schema() string {
	return "filecoin"
}

func (m ActorEventModel) TableName() string {
	return "actor_events"
}

func (m ActorEventModel) Values() []interface{} {
	return []interface{}{m.Height, m.BlockCID, m.MessageCID, m.EventIndex, m.Emitter, m.Flags, m.Codec, m.Key, m.Value}
}

type InitActorIDAddressModel struct {
	Height         string        `db:"height"`
	StateRootCID   string        `db:"state_root_cid"`
	InitActorID    string        `db:"init_actor_id"`
	Address        string        `db:"address"`
	ID             string        `db:"id"`
	SelectorSuffix pq.Int32Array `db:"selector_suffix"`
}

func (m InitActorIDAddressModel) Schema() string {
	return "filecoin"
}

func (m InitActorIDAddressModel) TableName() string {
	return "init_actor_id_addresses"
}

func (m InitActorIDAddressModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.InitActorID, m.Address, m.ID, m.SelectorSuffix}
}

type CronActorMethodReceiverModel struct {
	Height       string `db:"height"`
	StateRootCID string `db:"state_root_cid"`
	CronActorID  string `db:"cron_actor_id"`
	Index        string `db:"index"`
	Receiver     string `db:"receiver"`
	MethodNum    string `db:"method_num"`
}

func (m CronActorMethodReceiverModel) Schema() string {
	return "filecoin"
}

func (m CronActorMethodReceiverModel) TableName() string {
	return "cron_actor_method_receivers"
}

func (m CronActorMethodReceiverModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.CronActorID, m.Index, m.Receiver, m.MethodNum}
}

type RewardActorStateModel struct {
	Height                  string `db:"height"`
	StateRootCID            string `db:"state_root_cid"`
	RewardActorID           string `db:"reward_actor_id"`
	CumSumBaseline          string `db:"cumsum_baseline"`
	CumSumRealized          string `db:"cumsum_realized"`
	EffectiveNetworkTime    string `db:"effective_network_time"`
	EffectiveBaselinePower  string `db:"effective_baseline_power"`
	ThisEpochReward         string `db:"this_epoch_reward"`
	PositionEstimate        string `db:"position_estimate"`
	VelocityEstimate        string `db:"velocity_estimate"`
	ThisEpochBaselinePower  string `db:"this_epoch_baseline_power"`
	TotalMined              string `db:"total_mined"`
	TotalStoragePowerReward string `db:"total_storage_power_reward"`
	SimpleTotal             string `db:"simple_total"`
	BaselineTotal           string `db:"baseline_total"`
}

func (m RewardActorStateModel) Schema() string {
	return "filecoin"
}

func (m RewardActorStateModel) TableName() string {
	return "reward_actor_state"
}

func (m RewardActorStateModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.RewardActorID, m.CumSumBaseline, m.CumSumRealized,
		m.EffectiveNetworkTime, m.EffectiveBaselinePower, m.ThisEpochReward, m.PositionEstimate, m.VelocityEstimate,
		m.ThisEpochBaselinePower, m.TotalMined, m.TotalStoragePowerReward, m.SimpleTotal, m.BaselineTotal}
}

type AccountActorAddressModel struct {
	Height         string `db:"height"`
	StateRootCID   string `db:"state_root_cid"`
	AccountActorID string `db:"account_actor_id"`
	Address        string `db:"address"`
}

func (m AccountActorAddressModel) Schema() string {
	return "filecoin"
}

func (m AccountActorAddressModel) TableName() string {
	return "account_actor_addresses"
}

func (m AccountActorAddressModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.AccountActorID, m.Address}
}

type StorageActorStateModel struct {
	Height                        string `db:"height"`
	StateRootCID                  string `db:"state_root_cid"`
	StorageActorID                string `db:"storage_actor_id"`
	ProposalsRootCID              string `db:"proposals_root_cid"`
	DealStateRootCID              string `db:"deal_state_root_cid"`
	PendingProposalsRootCID       string `db:"pending_proposals_root_cid"`
	EscrowsRootCID                string `db:"escrows_root_cid"`
	LockedTokensRootCID           string `db:"locked_tokens_root_cid"`
	NextDealID                    string `db:"next_deal_id"`
	DealOpsByEpochRootCID         string `db:"deal_ops_by_epoch_root_cid"`
	LastCron                      string `db:"last_cron"`
	TotalClientLockedCollateral   string `db:"total_client_locked_collateral"`
	TotalProviderLockedCollateral string `db:"total_provider_locked_collateral"`
	TotalClientStorageFee         string `db:"total_client_storage_fee"`
}

func (m StorageActorStateModel) Schema() string {
	return "filecoin"
}

func (m StorageActorStateModel) TableName() string {
	return "storage_actor_state"
}

func (m StorageActorStateModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StorageActorID, m.ProposalsRootCID, m.DealStateRootCID,
		m.PendingProposalsRootCID, m.EscrowsRootCID, m.LockedTokensRootCID, m.NextDealID, m.DealOpsByEpochRootCID,
		m.LastCron, m.TotalClientLockedCollateral, m.TotalProviderLockedCollateral, m.TotalClientStorageFee}
}

type StorageActorDealProposalModel struct {
	Height               string        `db:"height"`
	StateRootCID         string        `db:"state_root_cid"`
	StorageActorID       string        `db:"storage_actor_id"`
	DealID               string        `db:"deal_id"`
	PieceCID             string        `db:"piece_cid"`
	PaddedPieceSize      string        `db:"padded_piece_size"`
	UnpaddedPieceSize    string        `db:"unpadded_piece_size"`
	IsVerified           bool          `db:"is_verified"`
	ClientID             string        `db:"client_id"`
	ProviderID           string        `db:"provider_id"`
	StartEpoch           string        `db:"start_epoch"`
	EndEpoch             string        `db:"end_epoch"`
	StoragePricePerEpoch string        `db:"storage_price_per_epoch"`
	ProviderCollateral   string        `db:"provider_collateral"`
	ClientCollateral     string        `db:"client_collateral"`
	Label                string        `db:"label"`
	SelectorSuffix       pq.Int32Array `db:"selector_suffix"`
}

func (m StorageActorDealProposalModel) Schema() string {
	return "filecoin"
}

func (m StorageActorDealProposalModel) TableName() string {
	return "storage_actor_deal_proposals"
}

func (m StorageActorDealProposalModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StorageActorID, m.DealID, m.PieceCID, m.PaddedPieceSize,
		m.UnpaddedPieceSize, m.IsVerified, m.ClientID, m.ProviderID, m.StartEpoch, m.EndEpoch,
		m.StoragePricePerEpoch, m.ProviderCollateral, m.ClientCollateral, m.Label, m.SelectorSuffix}
}

type StorageActorDealStateModel struct {
	Height           string        `db:"height"`
	StateRootCID     string        `db:"state_root_cid"`
	StorageActorID   string        `db:"storage_actor_id"`
	DealID           string        `db:"deal_id"`
	SectorStartEpoch string        `db:"sector_start_epoch"`
	LastUpdatedEpoch string        `db:"last_updated_epoch"`
	SlashEpoch       string        `db:"slash_epoch"`
	SelectorSuffix   pq.Int32Array `db:"selector_suffix"`
}

func (m StorageActorDealStateModel) Schema() string {
	return "filecoin"
}

func (m StorageActorDealStateModel) TableName() string {
	return "storage_actor_deal_state"
}

func (m StorageActorDealStateModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StorageActorID, m.DealID, m.SectorStartEpoch, m.LastUpdatedEpoch,
		m.SlashEpoch, m.SelectorSuffix}
}

type StorageActorPendingProposalModel struct {
	Height               string        `db:"height"`
	StateRootCID         string        `db:"state_root_cid"`
	StorageActorID       string        `db:"storage_actor_id"`
	DealCID              string        `db:"deal_cid"`
	PieceCID             string        `db:"piece_cid"`
	PaddedPieceSize      string        `db:"padded_piece_size"`
	UnpaddedPieceSize    string        `db:"unpadded_piece_size"`
	IsVerified           bool          `db:"is_verified"`
	ClientID             string        `db:"client_id"`
	ProviderID           string        `db:"provider_id"`
	StartEpoch           string        `db:"start_epoch"`
	EndEpoch             string        `db:"end_epoch"`
	StoragePricePerEpoch string        `db:"storage_price_per_epoch"`
	ProviderCollateral   string        `db:"provider_collateral"`
	ClientCollateral     string        `db:"client_collateral"`
	Label                string        `db:"label"`
	SelectorSuffix       pq.Int32Array `db:"selector_suffix"`
}

func (m StorageActorPendingProposalModel) Schema() string {
	return "filecoin"
}

func (m StorageActorPendingProposalModel) TableName() string {
	return "storage_actor_pending_proposals"
}

func (m StorageActorPendingProposalModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StorageActorID, m.DealCID, m.PieceCID, m.PaddedPieceSize,
		m.UnpaddedPieceSize, m.IsVerified, m.ClientID, m.ProviderID, m.StartEpoch, m.EndEpoch,
		m.StoragePricePerEpoch, m.ProviderCollateral, m.ClientCollateral, m.Label, m.SelectorSuffix}
}

type StorageActorEscrowModel struct {
	Height         string        `db:"height"`
	StateRootCID   string        `db:"state_root_cid"`
	StorageActorID string        `db:"storage_actor_id"`
	Address        string        `db:"address"`
	Value          string        `db:"value"`
	SelectorSuffix pq.Int32Array `db:"selector_suffix"`
}

func (m StorageActorEscrowModel) Schema() string {
	return "filecoin"
}

func (m StorageActorEscrowModel) TableName() string {
	return "storage_actor_escrows"
}

func (m StorageActorEscrowModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StorageActorID, m.Address, m.Value, m.SelectorSuffix}
}

type StorageActorLockedTokensModel struct {
	Height         string        `db:"height"`
	StateRootCID   string        `db:"state_root_cid"`
	StorageActorID string        `db:"storage_actor_id"`
	Address        string        `db:"address"`
	Value          string        `db:"value"`
	SelectorSuffix pq.Int32Array `db:"selector_suffix"`
}

func (m StorageActorLockedTokensModel) Schema() string {
	return "filecoin"
}

func (m StorageActorLockedTokensModel) TableName() string {
	return "storage_actor_locked_tokens"
}

func (m StorageActorLockedTokensModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StorageActorID, m.Address, m.Value, m.SelectorSuffix}
}

type StorageActorDealOpsBucketModel struct {
	Height         string `db:"height"`
	StateRootCID   string `db:"state_root_cid"`
	StorageActorID string `db:"storage_actor_id"`
	Epoch          string `db:"epoch"`
	DealsRootCID   string `db:"deals_root_cid"`
}

func (m StorageActorDealOpsBucketModel) Schema() string {
	return "filecoin"
}

func (m StorageActorDealOpsBucketModel) TableName() string {
	return "storage_actor_deal_ops_buckets"
}

func (m StorageActorDealOpsBucketModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StorageActorID, m.Epoch, m.DealsRootCID}
}

type StorageActorDealOpsAtEpochModel struct {
	Height         string        `db:"height"`
	StateRootCID   string        `db:"state_root_cid"`
	StorageActorID string        `db:"storage_actor_id"`
	Epoch          string        `db:"epoch"`
	DealID         string        `db:"deal_id"`
	SelectorSuffix pq.Int32Array `db:"selector_suffix"`
}

func (m StorageActorDealOpsAtEpochModel) Schema() string {
	return "filecoin"
}

func (m StorageActorDealOpsAtEpochModel) TableName() string {
	return "storage_actor_deal_ops_at_epoch"
}

func (m StorageActorDealOpsAtEpochModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StorageActorID, m.Epoch, m.DealID, m.SelectorSuffix}
}

type MinerActorStateModel struct {
	Height                           string `db:"height"`
	StateRootCID                     string `db:"state_root_cid"`
	MinerActorID                     string `db:"miner_actor_id"`
	PreCommitDeposits                string `db:"pre_commit_deposits"`
	LockedFunds                      string `db:"locked_funds"`
	VestingFundsCID                  string `db:"vesting_funds_cid"`
	InitialPledge                    string `db:"initial_pledge"`
	PreCommittedSectorsRootCID       string `db:"pre_committed_sectors_root_cid"`
	PreCommittedSectorsExpiryRootCID string `db:"pre_committed_sectors_expiry_root_cid"`
	AllocatedSectorsCID              string `db:"allocated_sectors_cid"`
	SectorsRootCID                   string `db:"sectors_root_cid"`
	ProvingPeriodStart               string `db:"proving_period_start"`
	CurrentDeadline                  string `db:"current_deadline"`
	DeadlinesCID                     string `db:"deadlines_cid"`
	EarlyTerminations                []byte `db:"early_terminations"`
}

func (m MinerActorStateModel) Schema() string {
	return "filecoin"
}

func (m MinerActorStateModel) TableName() string {
	return "miner_actor_state"
}

func (m MinerActorStateModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.MinerActorID, m.PreCommitDeposits, m.LockedFunds,
		m.VestingFundsCID, m.InitialPledge, m.PreCommittedSectorsRootCID, m.PreCommittedSectorsExpiryRootCID,
		m.AllocatedSectorsCID, m.SectorsRootCID, m.ProvingPeriodStart, m.CurrentDeadline, m.DeadlinesCID,
		m.EarlyTerminations}
}

type MinerInfoModel struct {
	Height                 string                 `db:"height"`
	StateRootCID           string                 `db:"state_root_cid"`
	MinerActorID           string                 `db:"miner_actor_id"`
	OwnerID                string                 `db:"owner_id"`
	WorkerID               string                 `db:"worker_id"`
	PeerID                 string                 `db:"peer_id"`
	ControlAddresses       map[string]interface{} `db:"control_addresses"`
	NewWorker              string                 `db:"new_worker"`
	NewWorkerStartEpoch    string                 `db:"new_worker_start_epoch"`
	MultiAddresses         map[string]interface{} `db:"multi_addresses"`
	SealProofType          int                    `db:"seal_proof_type"`
	SectorSize             string                 `db:"sector_size"`
	ConsensusFaultedElapse string                 `db:"consensus_faulted_elapse"`
	PendingOwner           string                 `db:"pending_owner"`
}

func (m MinerInfoModel) Schema() string {
	return "filecoin"
}

func (m MinerInfoModel) TableName() string {
	return "miner_infos"
}

func (m MinerInfoModel) Values() []interface{} {
	b, _ := json.Marshal(m.ControlAddresses)
	c, _ := json.Marshal(m.MultiAddresses)
	return []interface{}{m.Height, m.StateRootCID, m.MinerActorID, m.OwnerID, m.WorkerID, m.PeerID,
		b, m.NewWorker, m.NewWorkerStartEpoch, c, m.SealProofType,
		m.SectorSize, m.ConsensusFaultedElapse, m.PendingOwner}
}

type MinerVestingFundsModel struct {
	Height       string `db:"height"`
	StateRootCID string `db:"state_root_cid"`
	MinerActorID string `db:"miner_actor_id"`
	VestsAt      string `db:"vests_at"`
	Amount       string `db:"amount"`
}

func (m MinerVestingFundsModel) Schema() string {
	return "filecoin"
}

func (m MinerVestingFundsModel) TableName() string {
	return "miner_vesting_funds"
}

func (m MinerVestingFundsModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.MinerActorID, m.VestsAt, m.Amount}
}

type MinerDeadlineModel struct {
	Height                  string `db:"height"`
	StateRootCID            string `db:"state_root_cid"`
	MinerActorID            string `db:"miner_actor_id"`
	Index                   int    `db:"index"`
	PartitionsRootCID       string `db:"partitions_root_cid"`
	ExpirationEpochsRootCID string `db:"expiration_epochs_root_cid"`
	PostSubmissions         []byte `db:"post_submissions"`
	EarlyTerminations       []byte `db:"early_terminations"`
	LiveSectors             string `db:"live_sectors"`
	TotalSectors            string `db:"total_sectors"`
	FaultPowerPairRaw       string `db:"fault_power_pair_raw"`
	FaultyPowerPairQA       string `db:"faulty_power_pair_qa"`
}

func (m MinerDeadlineModel) Schema() string {
	return "filecoin"
}

func (m MinerDeadlineModel) TableName() string {
	return "miner_deadlines"
}

func (m MinerDeadlineModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.MinerActorID, m.Index, m.PartitionsRootCID,
		m.ExpirationEpochsRootCID, m.PostSubmissions, m.EarlyTerminations, m.LiveSectors, m.TotalSectors,
		m.FaultPowerPairRaw, m.FaultyPowerPairQA}
}

type MinerPreCommittedSectorInfoModel struct {
	Height                       string         `db:"height"`
	StateRootCID                 string         `db:"state_root_cid"`
	MinerActorID                 string         `db:"miner_actor_id"`
	SectorNumber                 string         `db:"sector_number"`
	PreCommitDeposit             string         `db:"pre_commit_deposit"`
	PreCommitEpoch               string         `db:"pre_commit_epoch"`
	DealWeight                   string         `db:"deal_weight"`
	VerifiedDealWeight           string         `db:"verified_deal_weight"`
	SealProof                    string         `db:"seal_proof"`
	SealedCID                    string         `db:"sealed_cid"`
	SealRandEpoch                string         `db:"seal_rand_epoch"`
	DealIDs                      pq.StringArray `db:"deal_ids"`
	ExpirationEpoch              string         `db:"expiration_epoch"`
	ReplaceCapacity              bool           `db:"replace_capacity"`
	ReplaceSectorDeadline        string         `db:"replace_sector_deadline"`
	ReplaceSectorPartitionNumber string         `db:"replace_sector_partition_number"`
	ReplaceSectorNumber          string         `db:"replace_sector_number"`
	SelectorSuffix               pq.Int32Array  `db:"selector_suffix"`
}

func (m MinerPreCommittedSectorInfoModel) Schema() string {
	return "filecoin"
}

func (m MinerPreCommittedSectorInfoModel) TableName() string {
	return "miner_pre_committed_sector_infos"
}

func (m MinerPreCommittedSectorInfoModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.MinerActorID, m.SectorNumber, m.PreCommitDeposit,
		m.PreCommitEpoch, m.DealWeight, m.VerifiedDealWeight, m.SealProof, m.SealedCID, m.SealRandEpoch,
		m.DealIDs, m.ExpirationEpoch, m.ReplaceCapacity, m.ReplaceSectorDeadline, m.ReplaceSectorPartitionNumber,
		m.ReplaceSectorNumber, m.SelectorSuffix}
}

type MinerSectorInfoModel struct {
	Height                string         `db:"height"`
	StateRootCID          string         `db:"state_root_cid"`
	MinerActorID          string         `db:"miner_actor_id"`
	SectorNumber          string         `db:"sector_number"`
	RegisteredSealProof   string         `db:"registered_seal_proof"`
	SealedCID             string         `db:"sealed_cid"`
	DealIDs               pq.StringArray `db:"deal_ids"`
	ActivationEpoch       string         `db:"activation_epoch"`
	ExpirationEpoch       string         `db:"expiration_epoch"`
	DealWeight            string         `db:"deal_weight"`
	VerifiedDealWeight    string         `db:"verified_deal_weight"`
	InitialPledge         string         `db:"initial_pledge"`
	ExpectedDayReward     string         `db:"expected_day_reward"`
	ExpectedStoragePledge string         `db:"expected_storage_pledge"`
	ReplacedSectorAge     string         `db:"replaced_sector_age"`
	ReplacedDayReward     string         `db:"replaced_day_reward"`
	SelectorSuffix        pq.Int32Array  `db:"selector_suffix"`
}

func (m MinerSectorInfoModel) Schema() string {
	return "filecoin"
}

func (m MinerSectorInfoModel) TableName() string {
	return "miner_sector_infos"
}

func (m MinerSectorInfoModel) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.MinerActorID, m.SectorNumber, m.RegisteredSealProof,
		m.SealedCID, m.DealIDs, m.ActivationEpoch, m.ExpirationEpoch, m.DealWeight, m.VerifiedDealWeight,
		m.InitialPledge, m.ExpectedDayReward, m.ExpectedStoragePledge, m.ReplacedSectorAge, m.ReplacedDayReward,
		m.SelectorSuffix}
}

type MinerPartitionRecord struct {
	Height                  string        `db:"height"`
	StateRootCID            string        `db:"state_root_cid"`
	MinerActorID            string        `db:"miner_actor_id"`
	DeadlineIndex           int           `db:"deadline_index"`
	PartitionNumber         int           `db:"partition_number"`
	Sectors                 []byte        `db:"sectors"`
	Faults                  []byte        `db:"faults"`
	Unproven                []byte        `db:"unproven"`
	Recoveries              []byte        `db:"recoveries"`
	Terminated              []byte        `db:"terminated"`
	ExpirationEpochsRootCID string        `db:"expiration_epochs_root_cid"`
	EarlyTerminatedRootCID  string        `db:"early_terminated_root_cid"`
	LivePowerPairRaw        string        `db:"live_power_pair_raw"`
	LivePowerPairQA         string        `db:"live_power_pair_qa"`
	UnprovenPowerPairRaw    string        `db:"unproven_power_pair_raw"`
	UnprovenPowerPairQA     string        `db:"unproven_power_pair_qa"`
	FaultyPowerPairRaw      string        `db:"faulty_power_pair_raw"`
	FaultyPowerPairQA       string        `db:"faulty_power_pair_qa"`
	RecoveringPowerPairRaw  string        `db:"recovering_power_pair_raw"`
	RecoveringPowerPairQA   string        `db:"recovering_power_pair_qa"`
	SelectorSuffix          pq.Int32Array `db:"selector_suffix"`
}

func (m MinerPartitionRecord) Schema() string {
	return "filecoin"
}

func (m MinerPartitionRecord) TableName() string {
	return "miner_partitions"
}

func (m MinerPartitionRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.MinerActorID, m.DeadlineIndex, m.PartitionNumber,
		m.Sectors, m.Faults, m.Unproven, m.Recoveries, m.Terminated, m.ExpirationEpochsRootCID,
		m.EarlyTerminatedRootCID, m.LivePowerPairRaw, m.LivePowerPairQA, m.UnprovenPowerPairRaw,
		m.UnprovenPowerPairQA, m.FaultyPowerPairRaw, m.FaultyPowerPairQA, m.RecoveringPowerPairRaw,
		m.RecoveringPowerPairQA, m.SelectorSuffix}
}

type MinerPartitionExpirationRecord struct {
	Height             string        `db:"height"`
	StateRootCID       string        `db:"state_root_cid"`
	MinerActorID       string        `db:"miner_actor_id"`
	DeadlineIndex      int           `db:"deadline_index"`
	PartitionNumber    int           `db:"partition_number"`
	Epoch              string        `db:"epoch"`
	OnTimeSectors      []byte        `db:"on_time_sectors"`
	EarlySectors       []byte        `db:"early_sectors"`
	OnTimePledge       string        `db:"on_time_pledge"`
	ActivePowerPairRaw string        `db:"active_power_pair_raw"`
	ActivePowerPairQA  string        `db:"active_power_pair_qa"`
	FaultyPowerPairRaw string        `db:"faulty_power_pair_raw"`
	FaultyPowerPairQA  string        `db:"faulty_power_pair_qa"`
	SelectorSuffix     pq.Int32Array `db:"selector_suffix"`
}

func (m MinerPartitionExpirationRecord) Schema() string {
	return "filecoin"
}

func (m MinerPartitionExpirationRecord) TableName() string {
	return "miner_partition_expirations"
}

func (m MinerPartitionExpirationRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.MinerActorID, m.DeadlineIndex, m.PartitionNumber,
		m.Epoch, m.OnTimeSectors, m.EarlySectors, m.OnTimePledge, m.ActivePowerPairRaw, m.ActivePowerPairQA,
		m.FaultyPowerPairRaw, m.FaultyPowerPairQA, m.SelectorSuffix}
}

type MultisigActorStateRecord struct {
	Height                string         `db:"height"`
	StateRootCID          string         `db:"state_root_cid"`
	MultisigActorID       string         `db:"multisig_actor_id"`
	Signers               pq.StringArray `db:"signers"`
	NumApprovalsThreshold string         `db:"num_approvals_threshold"`
	NextTxID              string         `db:"next_tx_id"`
	InitialBalance        string         `db:"initial_balance"`
	StartEpoch            string         `db:"start_epoch"`
	UnlockDuration        string         `db:"unlock_duration"`
	PendingTxsRootCID     string         `db:"pending_txs_root_cid"`
}

func (m MultisigActorStateRecord) Schema() string {
	return "filecoin"
}

func (m MultisigActorStateRecord) TableName() string {
	return "multisig_actor_state"
}

func (m MultisigActorStateRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.MultisigActorID, m.Signers, m.NumApprovalsThreshold,
		m.NextTxID, m.InitialBalance, m.StartEpoch, m.UnlockDuration, m.PendingTxsRootCID}
}

type MultisigPendingTransactionRecord struct {
	Height          string         `db:"height"`
	StateRootCID    string         `db:"state_root_cid"`
	MultisigActorID string         `db:"multisig_actor_id"`
	TransactionID   string         `db:"transaction_id"`
	To              string         `db:"to"`
	Value           string         `db:"value"`
	Params          []byte         `db:"params"`
	Approved        pq.StringArray `db:"approved"`
	SelectorSuffix  pq.Int32Array  `db:"selector_suffix"`
}

func (m MultisigPendingTransactionRecord) Schema() string {
	return "filecoin"
}

func (m MultisigPendingTransactionRecord) TableName() string {
	return "multisig_pending_transactions"
}

func (m MultisigPendingTransactionRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.MultisigActorID, m.TransactionID, m.To, m.Value,
		m.Params, m.Approved, m.SelectorSuffix}
}

type PaymentChannelActorStateRecord struct {
	Height                string `db:"height"`
	StateRootCID          string `db:"state_root_cid"`
	PaymentChannelActorID string `db:"payment_channel_actor_id"`
	From                  string `db:"from"`
	To                    string `db:"to"`
	ToSend                string `db:"to_send"`
	SettlingAtEpoch       string `db:"settling_at_epoch"`
	MinSettleHeight       string `db:"min_settle_height"`
	LaneStateRootCID      string `db:"lane_state_root_cid"`
}

func (m PaymentChannelActorStateRecord) Schema() string {
	return "filecoin"
}

func (m PaymentChannelActorStateRecord) TableName() string {
	return "payment_channel_actor_state"
}

func (m PaymentChannelActorStateRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.PaymentChannelActorID, m.From, m.To, m.ToSend,
		m.SettlingAtEpoch, m.MinSettleHeight, m.LaneStateRootCID}
}

type PaymentChannelLaneStateRecord struct {
	Height                string        `db:"height"`
	StateRootCID          string        `db:"state_root_cid"`
	PaymentChannelActorID string        `db:"payment_channel_actor_id"`
	LaneID                int           `db:"lane_id"`
	Redeemed              string        `db:"redeemed"`
	Nonce                 string        `db:"nonce"`
	SelectorSuffix        pq.Int32Array `db:"selector_suffix"`
}

func (m PaymentChannelLaneStateRecord) Schema() string {
	return "filecoin"
}

func (m PaymentChannelLaneStateRecord) TableName() string {
	return "payment_channel_lane_state"
}

func (m PaymentChannelLaneStateRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.PaymentChannelActorID, m.LaneID, m.Redeemed, m.Nonce,
		m.SelectorSuffix}
}

type StoragePowerActorStateRecord struct {
	Height                      string `db:"height"`
	StateRootCID                string `db:"state_root_cid"`
	StoragePowerActorID         string `db:"storage_power_actor_id"`
	TotalRawBytePower           string `db:"total_raw_byte_power"`
	TotalBytesCommitted         string `db:"total_bytes_committed"`
	TotalQualityAdjPower        string `db:"total_quality_adj_power"`
	TotalQABytesCommitted       string `db:"total_qa_bytes_committed"`
	TotalPledgeCollateral       string `db:"total_pledge_collateral"`
	ThisEpochRawBytePower       string `db:"this_epoch_raw_byte_power"`
	ThisEpochQualityAdjPower    string `db:"this_epoch_quality_adj_power"`
	ThisEpochPledgeCollateral   string `db:"this_epoch_pledge_collateral"`
	ThisEpochQAPowerSmoothedPOS string `db:"this_epoch_qa_power_smoothed_pos"`
	ThisEpochQAPowerSmoothedVel string `db:"this_epoch_qa_power_smoothed_vel"`
	MinerCount                  int    `db:"miner_count"`
	MinerAboveMinPowerCount     int    `db:"miner_above_min_power_count"`
	CronEventQueueRootCID       string `db:"cron_event_queue_root_cid"`
	FirstChronEpoch             string `db:"first_chron_epoch"`
	LastProcessedCronEpoch      string `db:"last_processed_cron_epoch"`
	ProofValidationBatchRootCID string `db:"proof_validation_batch_root_cid"`
}

func (m StoragePowerActorStateRecord) Schema() string {
	return "filecoin"
}

func (m StoragePowerActorStateRecord) TableName() string {
	return "storage_power_actor_state"
}

func (m StoragePowerActorStateRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StoragePowerActorID, m.TotalRawBytePower, m.TotalBytesCommitted,
		m.TotalQualityAdjPower, m.TotalQABytesCommitted, m.TotalPledgeCollateral, m.ThisEpochRawBytePower,
		m.ThisEpochQualityAdjPower, m.ThisEpochPledgeCollateral, m.ThisEpochQAPowerSmoothedPOS,
		m.ThisEpochQAPowerSmoothedVel, m.MinerCount, m.MinerAboveMinPowerCount, m.CronEventQueueRootCID,
		m.FirstChronEpoch, m.LastProcessedCronEpoch, m.ProofValidationBatchRootCID}
}

type StoragePowerCronEventBucketRecord struct {
	Height              string `db:"height"`
	StateRootCID        string `db:"state_root_cid"`
	StoragePowerActorID string `db:"storage_power_actor_id"`
	Epoch               string `db:"epoch"`
}

func (m StoragePowerCronEventBucketRecord) Schema() string {
	return "filecoin"
}

func (m StoragePowerCronEventBucketRecord) TableName() string {
	return "storage_power_cron_event_buckets"
}

func (m StoragePowerCronEventBucketRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StoragePowerActorID, m.Epoch}
}

type StoragePowerCronEventRecord struct {
	Height              string        `db:"height"`
	StateRootCID        string        `db:"state_root_cid"`
	StoragePowerActorID string        `db:"storage_power_actor_id"`
	Epoch               string        `db:"epoch"`
	Index               int           `db:"index"`
	MinerAddress        string        `db:"miner_address"`
	CallbackPayload     []byte        `db:"callback_payload"`
	SelectorSuffix      pq.Int32Array `db:"selector_suffix"`
}

func (m StoragePowerCronEventRecord) Schema() string {
	return "filecoin"
}

func (m StoragePowerCronEventRecord) TableName() string {
	return "storage_power_cron_events"
}

func (m StoragePowerCronEventRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StoragePowerActorID, m.Epoch, m.Index, m.MinerAddress,
		m.CallbackPayload, m.SelectorSuffix}
}

type StoragePowerClaimRecord struct {
	Height              string        `db:"height"`
	StateRootCID        string        `db:"state_root_cid"`
	StoragePowerActorID string        `db:"storage_power_actor_id"`
	Address             string        `db:"address"`
	SealProofType       int           `db:"seal_proof_type"`
	RawBytePower        string        `db:"raw_byte_power"`
	QualityAdjPower     string        `db:"quality_adj_power"`
	SelectorSuffix      pq.Int32Array `db:"selector_suffix"`
}

func (m StoragePowerClaimRecord) Schema() string {
	return "filecoin"
}

func (m StoragePowerClaimRecord) TableName() string {
	return "storage_power_claims"
}

func (m StoragePowerClaimRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StoragePowerActorID, m.Address, m.SealProofType,
		m.RawBytePower, m.QualityAdjPower, m.SelectorSuffix}
}

type StoragePowerProofValidationBucketRecord struct {
	Height              string `db:"height"`
	StateRootCID        string `db:"state_root_cid"`
	StoragePowerActorID string `db:"storage_power_actor_id"`
	Address             string `db:"address"`
}

func (m StoragePowerProofValidationBucketRecord) Schema() string {
	return "filecoin"
}

func (m StoragePowerProofValidationBucketRecord) TableName() string {
	return "storage_power_proof_validation_buckets"
}

func (m StoragePowerProofValidationBucketRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StoragePowerActorID, m.Address}
}

type StoragePowerProofSealVerifyInfoRecord struct {
	Height                string         `db:"height"`
	StateRootCID          string         `db:"state_root_cid"`
	StoragePowerActorID   string         `db:"storage_power_actor_id"`
	Address               string         `db:"address"`
	Index                 string         `db:"index"`
	SealProof             string         `db:"seal_proof"`
	SectorID              string         `db:"sector_id"`
	DealIDs               pq.StringArray `db:"deal_ids"`
	Randomness            []byte         `db:"randomness"`
	InteractiveRandomness []byte         `db:"interactive_randomness"`
	Proof                 []byte         `db:"proof"`
	SealedCID             string         `db:"sealed_cid"`
	UnsealedCID           string         `db:"unsealed_cid"`
	SelectorSuffix        pq.Int32Array  `db:"selector_suffix"`
}

func (m StoragePowerProofSealVerifyInfoRecord) Schema() string {
	return "filecoin"
}

func (m StoragePowerProofSealVerifyInfoRecord) TableName() string {
	return "storage_power_proof_seal_verify_infos"
}

func (m StoragePowerProofSealVerifyInfoRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StoragePowerActorID, m.Address, m.Index, m.SealProof,
		m.SectorID, m.DealIDs, m.Randomness, m.InteractiveRandomness, m.Proof, m.SealedCID, m.UnsealedCID,
		m.SelectorSuffix}
}

type VerifiedRegistryActorStateRecord struct {
	Height                  string `db:"height"`
	StateRootCID            string `db:"state_root_cid"`
	VerifiedRegistryActorID string `db:"verified_registry_actor_id"`
	RootAddress             string `db:"root_address"`
	VerifiersRootCID        string `db:"verifiers_root_cid"`
	VerifiedClientsRootCID  string `db:"verified_clients_root_cid"`
}

func (m VerifiedRegistryActorStateRecord) Schema() string {
	return "filecoin"
}

func (m VerifiedRegistryActorStateRecord) TableName() string {
	return "verified_registry_actor_state"
}

func (m VerifiedRegistryActorStateRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.VerifiedRegistryActorID, m.RootAddress,
		m.VerifiersRootCID, m.VerifiedClientsRootCID}
}

type VerifiedRegistryVerifierRecord struct {
	Height                  string        `db:"height"`
	StateRootCID            string        `db:"state_root_cid"`
	VerifiedRegistryActorID string        `db:"verified_registry_actor_id"`
	Address                 string        `db:"address"`
	DataCap                 string        `db:"data_cap"`
	SelectorSuffix          pq.Int32Array `db:"selector_suffix"`
}

func (m VerifiedRegistryVerifierRecord) Schema() string {
	return "filecoin"
}

func (m VerifiedRegistryVerifierRecord) TableName() string {
	return "verified_registry_verifiers"
}

func (m VerifiedRegistryVerifierRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.VerifiedRegistryActorID, m.Address, m.DataCap,
		m.SelectorSuffix}
}

type VerifiedRegistryClientRecord struct {
	Height                  string        `db:"height"`
	StateRootCID            string        `db:"state_root_cid"`
	VerifiedRegistryActorID string        `db:"verified_registry_actor_id"`
	Address                 string        `db:"address"`
	DataCap                 string        `db:"data_cap"`
	SelectorSuffix          pq.Int32Array `db:"selector_suffix"`
}

func (m VerifiedRegistryClientRecord) Schema() string {
	return "filecoin"
}

func (m VerifiedRegistryClientRecord) TableName() string {
	return "verified_registry_clients"
}

func (m VerifiedRegistryClientRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.VerifiedRegistryActorID, m.Address, m.DataCap,
		m.SelectorSuffix}
}

type FEVMActorStateRecord struct {
	Height         string `db:"height"`
	StateRootCID   string `db:"state_root_cid"`
	StateAccountID string `db:"state_account_id"`
	ByteCode       []byte `db:"byte_code"`
	StorageRootCID string `db:"storage_root_cid"`
	LogsRootCID    string `db:"logs_root_cid"`
	Diff           bool   `db:"diff"`
	Removed        bool   `db:"removed"`
}

func (m FEVMActorStateRecord) Schema() string {
	return "filecoin"
}

func (m FEVMActorStateRecord) TableName() string {
	return "fevm_actor_state"
}

func (m FEVMActorStateRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StateAccountID, m.ByteCode, m.StorageRootCID,
		m.LogsRootCID, m.Diff, m.Removed}
}

type FEVMActorStorageRecord struct {
	Height         string        `db:"height"`
	StateRootCID   string        `db:"state_root_cid"`
	StateAccountID string        `db:"state_account_id"`
	StorageID      string        `db:"storage_id"`
	Val            []byte        `db:"val"`
	Diff           bool          `db:"diff"`
	Removed        bool          `db:"removed"`
	SelectorSuffix pq.Int32Array `db:"selector_suffix"`
}

func (m FEVMActorStorageRecord) Schema() string {
	return "filecoin"
}

func (m FEVMActorStorageRecord) TableName() string {
	return "fevm_actor_storage"
}

func (m FEVMActorStorageRecord) Values() []interface{} {
	return []interface{}{m.Height, m.StateRootCID, m.StateAccountID, m.StorageID, m.Val, m.Diff,
		m.Removed, m.SelectorSuffix}
}
