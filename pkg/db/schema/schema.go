package schema

var TableIPLDs = Table{
	Name: `ipld.blocks`,
	Columns: []Column{
		{Name: "block_number", Type: Dbigint},
		{Name: "key", Type: Dtext},
		{Name: "data", Type: Dbytea},
	},
	UpsertClause: OnConflict("block_number", "key"),
}

var TableCIDs = Table{
	Name: `filecin.cids`,
	Columns: []Column{
		{Name: "cid", Type: Dtext},
		{Name: "id", Type: Dbigint},
	},
	UpsertClause: OnConflict("id"),
}

var TableTipSets = Table{
	Name: `filecoin.tip_sets`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "parent_tip_set_key_cid", Type: Dbigint},
		{Name: "parent_state_root_cid", Type: Dbigint},
	},
	UpsertClause: OnConflict("height", "parent_tip_set_key_cid"),
}

var TableTipSetMembers = Table{
	Name: `filecoin.tip_set_members`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "parent_tip_set_key_cid", Type: Dbigint},
		{Name: "index", Type: Dinteger},
		{Name: "block_cid", Type: Dbigint},
	},
	UpsertClause: OnConflict("height", "parent_tip_set_key_cid", "index"),
}

var TableBlockHeaders = Table{
	Name: `filecoin.block_headers`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "block_cid", Type: Dbigint},
		{Name: "parent_weight", Type: Dnumeric},
		{Name: "parent_state_root_cid", Type: Dbigint},
		{Name: "parent_tip_set_key_cid", Type: Dbigint},
		{Name: "parent_message_receipts_root_cid", Type: Dbigint},
		{Name: "messages_root_cid", Type: Dbigint},
		{Name: "bls_aggregate", Type: Dtext},
		{Name: "miner", Type: Dtext},
		{Name: "block_sig", Type: Dtext},
		{Name: "timestamp", Type: Dbigint},
		{Name: "win_count", Type: Dbigint},
		{Name: "parent_base_fee", Type: Dtext},
		{Name: "fork_signaling", Type: Dbigint},
	},
	UpsertClause: OnConflict("height", "block_cid"),
}

var TableBlockParents = Table{
	Name: `filecoin.block_parents`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "block_cid", Type: Dbigint},
		{Name: "parent_cid", Type: Dbigint},
	},
	UpsertClause: OnConflict("height", "block_cid", "parent_cid"),
}

var TableBlockMessages = Table{
	Name: `filecoin.block_messages`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "block_cid", Type: Dbigint},
		{Name: "message_cid", Type: Dbigint},
	},
	UpsertClause: OnConflict("height", "block_cid", "message_cid"),
}

var TableMessages = Table{
	Name: `filecoin.messages`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "block_cid", Type: Dbigint},
		{Name: "message_cid", Type: Dbigint},
		{Name: "from", Type: Dtext},
		{Name: "to", Type: Dtext},
		{Name: "size_bytes", Type: Dbigint},
		{Name: "nonce", Type: Dbigint},
		{Name: "value", Type: Dnumeric},
		{Name: "gas_fee_cap", Type: Dnumeric},
		{Name: "gas_premium", Type: Dnumeric},
		{Name: "gas_limit", Type: Dbigint},
		{Name: "method", Type: Dbigint},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "block_cid", "message_cid"),
}

var TableParsedMessages = Table{
	Name: "filecoin.parsed_messages",
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "block_cid", Type: Dbigint},
		{Name: "message_cid", Type: Dbigint},
		{Name: "params", Type: Djsonb},
	},
	UpsertClause: OnConflict("height", "block_cid", "message_cid"),
}

var TableInternalMessages = Table{
	Name: `filecoin.internal_messages`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "block_cid", Type: Dbigint},
		{Name: "message_cid", Type: Dbigint},
		{Name: "source", Type: Dtext},
		{Name: "from", Type: Dtext},
		{Name: "to", Type: Dtext},
		{Name: "value", Type: Dnumeric},
		{Name: "method", Type: Dbigint},
		{Name: "actor_name", Type: Dtext},
		{Name: "actor_family", Type: Dtext},
		{Name: "exit_code", Type: Dbigint},
		{Name: "gas_used", Type: Dbigint},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "block_cid", "message_cid", "source"),
}

var TableInternalParsedMessages = Table{
	Name: "filecoin.internal_parsed_messages",
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "block_cid", Type: Dbigint},
		{Name: "message_cid", Type: Dbigint},
		{Name: "source", Type: Dtext},
		{Name: "params", Type: Djsonb},
	},
	UpsertClause: OnConflict("height", "block_cid", "message_cid", "source"),
}

var TableVMMessages = Table{
	Name: `filecoin.vm_messages`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "block_cid", Type: Dbigint},
		{Name: "message_cid", Type: Dbigint},
		{Name: "source", Type: Dtext},
		{Name: "actor_code", Type: Dtext},
		{Name: "params", Type: Djsonb},
		{Name: "returns", Type: Djsonb},
	},
	UpsertClause: OnConflict("height", "block_cid", "message_cid", "source"),
}

var TableReceipts = Table{
	Name: `filecoin.receipts`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "block_cid", Type: Dbigint},
		{Name: "message_cid", Type: Dbigint},
		{Name: "idx", Type: Dbigint},
		{Name: "exit_code", Type: Dbigint},
		{Name: "gas_used", Type: Dbigint},
		{Name: "return", Type: Dbytea},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "block_cid", "message_cid", "idx"),
}

var TableDrandBlockEntries = Table{
	Name: `filecoin.drand_block_entries`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "block_cid", Type: Dbigint},
		{Name: "round", Type: Dbigint},
		{Name: "signature", Type: Dtext},
		{Name: "previous_signature", Type: Dtext},
	},
	UpsertClause: OnConflict("height", "block_cid", "round"),
}

var TableActors = Table{
	Name: `filecoin.actors`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "id", Type: Dtext},
		{Name: "code", Type: Dtext},
		{Name: "head_cid", Type: Dbigint},
		{Name: "nonce", Type: Dbigint},
		{Name: "balance", Type: Dnumeric},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "id"),
}

var TableActorStates = Table{
	Name: `filecoin.actor_states`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "id", Type: Dtext},
		{Name: "state", Type: Djsonb},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "id"),
}

var TableActorEvents = Table{
	Name: `filecoin.actor_events`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "block_cid", Type: Dbigint},
		{Name: "message_cid", Type: Dbigint},
		{Name: "event_index", Type: Dbigint},
		{Name: "emitter", Type: Dtext},
		{Name: "flags", Type: Dbytea},
		{Name: "codec", Type: Dbigint},
		{Name: "key", Type: Dtext},
		{Name: "value", Type: Dbytea},
	},
	UpsertClause: OnConflict("height", "block_cid", "message_cid", "event_index"),
}

var TableInitActorIDAddresses = Table{
	Name: `filecoin.init_actor_id_addresses`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "init_actor_id", Type: Dtext},
		{Name: "address", Type: Dtext},
		{Name: "id", Type: Dtext},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "init_actor_id", "address"),
}

var TableCronActorMethodReceivers = Table{
	Name: `filecoin.cron_actor_method_receivers`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "cron_actor_id", Type: Dtext},
		{Name: "index", Type: Dbigint},
		{Name: "receiver", Type: Dtext},
		{Name: "method_num", Type: Dbigint},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "cron_actor_id", "receiver", "index"),
}

var TableRewardActorStates = Table{
	Name: `filecoin.reward_actor_state`
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "reward_actor_id", Type: Dtext},
		{Name: "cumsum_baseline", Type: Dnumeric},
		{Name: "cumsum_realized", Type: Dnumeric},
		{Name: "effective_network_time", Type: Dbigint},
		{Name: "effective_baseline_power", Type: Dnumeric},
		{Name: "this_epoch_reward", Type: Dnumeric},
		{Name: "position_estimate", Type: Dnumeric},
		{Name: "velocity_estimate", Type: Dnumeric},
		{Name: "this_epoch_baseline_power", Type: Dnumeric},
		{Name: "total_mined", Type: Dnumeric},
		{Name: "total_storage_power_reward", Type: Dnumeric},
		{Name: "simple_total", Type: Dnumeric},
		{Name: "baseline_total", Type: Dnumeric},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "reward_actor_id"),
}

var TableAccountActorAddresses = Table{
	Name: `filecoin.account_actor_addresses`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "account_actor_id", Type: Dtext},
		{Name: "address", Type: Dtext},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "account_actor_id"),
}

var TableStorageActorStates = Table{
	Name: `filecoin.storage_actor_state`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "storage_actor_id", Type: Dtext},
		{Name: "proposals_root_cid", Type: Dbigint},
		{Name: "deal_states_root_cid", Type: Dbigint},
		{Name: "pending_proposals_root_cid", Type: Dbigint},
		{Name: "escrows_root_cid", Type: Dbigint},
		{Name: "locked_tokens_root_cid", Type: Dbigint},
		{Name: "next_deal_id", Type: Dbigint},
		{Name: "deal_ops_by_epoch_root_cid", Type: Dbigint},
		{Name: "last_cron", Type: Dbigint},
		{Name: "total_client_locked_collateral", Type: Dnumeric},
		{Name: "total_provider_locked_collateral", Type: Dnumeric},
		{Name: "total_client_storage_fee", Type: Dnumeric},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "storage_actor_id"),
}

var TableStorageActorDealProposals = Table{
	Name: `filecoin.storage_actor_deal_proposals`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "storage_actor_id", Type: Dtext},
		{Name: "deal_id", Type: Dbigint},
		{Name: "piece_cid", Type: Dbigint},
		{Name: "padded_piece_size", Type: Dbigint},
		{Name: "unpadded_piece_size", Type: Dbigint},
		{Name: "is_verified", Type: Dboolean},
		{Name: "client_id", Type: Dtext},
		{Name: "provider_id", Type: Dtext},
		{Name: "start_epoch", Type: Dbigint},
		{Name: "end_epoch", Type: Dbigint},
		{Name: "storage_price_per_epoch", Type: Dnumeric},
		{Name: "provider_collateral", Type: Dnumeric},
		{Name: "client_collateral", Type: Dnumeric},
		{Name: "label", Type: Dtext},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "storage_actor_id", "deal_id"),
}

var TableStorageActorDealStates = Table{
	Name: `filecoin.storage_actor_deal_states`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "storage_actor_id", Type: Dtext},
		{Name: "deal_id", Type: Dbigint},
		{Name: "sector_start_epoch", Type: Dbigint},
		{Name: "last_updated_epoch", Type: Dbigint},
		{Name: "slash_epoch", Type: Dbigint},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "storage_actor_id", "deal_id"),
}

var TableStorageActorPendingProposals = Table{
	Name: `filecoin.storage_actor_pending_proposals`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "storage_actor_id", Type: Dtext},
		{Name: "deal_cid", Type: Dbigint},
		{Name: "piece_cid", Type: Dbigint},
		{Name: "padded_piece_size", Type: Dbigint},
		{Name: "unpadded_piece_size", Type: Dbigint},
		{Name: "is_verified", Type: Dboolean},
		{Name: "client_id", Type: Dtext},
		{Name: "provider_id", Type: Dtext},
		{Name: "start_epoch", Type: Dbigint},
		{Name: "end_epoch", Type: Dbigint},
		{Name: "storage_price_per_epoch", Type: Dnumeric},
		{Name: "provider_collateral", Type: Dnumeric},
		{Name: "client_collateral", Type: Dnumeric},
		{Name: "label", Type: Dtext},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "storage_actor_id", "deal_cid"),
}

var TableStorageActorEscrows = Table{
	Name: `filecoin.storage_actor_escrows`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "storage_actor_id", Type: Dtext},
		{Name: "address", Type: Dtext},
		{Name: "value", Type: Dnumeric},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "storage_actor_id", "address"),
}

var TableStorageActorLockedTokens = Table{
	Name: `filecoin.storage_actor_locked_tokens`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "storage_actor_id", Type: Dtext},
		{Name: "address", Type: Dtext},
		{Name: "value", Type: Dnumeric},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "storage_actor_id", "address"),
}

var TableStorageActorDealOpsBuckets = Table{
	Name: `filecoin.storage_actor_deal_ops_buckets`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "storage_actor_id", Type: Dtext},
		{Name: "epoch", Type: Dbigint},
		{Name: "deals_root_cid", Type: Dbigint},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "storage_actor_id", "epoch"),
}

var TableStorageActorDealOpsAtEpoch = Table{
	Name: `filecoin.storage_actor_deal_ops_at_epoch`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "storage_actor_id", Type: Dtext},
		{Name: "epoch", Type: Dbigint},
		{Name: "deal_id", Type: Dbigint},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "storage_actor_id", "epoch", "deal_id"),
}

var TableMinerActorStates = Table{
	Name: `filecoin.miner_actor_states`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "miner_actor_id", Type: Dtext},
		{Name: "pre_commit_deposits", Type: Dnumeric},
		{Name: "locked_funds", Type: Dnumeric},
		{Name: "vesting_funds_cid", Type: Dbigint},
		{Name: "initial_pledge", Type: Dnumeric},
		{Name: "pre_committed_sectors_root_cid", Type: Dbigint},
		{Name: "pre_committed_sectors_expiry_root_cid", Type: Dbigint},
		{Name: "allocated_sectors_cid", Type: Dbigint},
		{Name: "sectors_root_cid", Type: Dbigint},
		{Name: "proving_period_start", Type: Dnumeric},
		{Name: "current_deadline", Type: Dbigint},
		{Name: "deadlines_cid", Type: Dbigint},
		{Name: "early_terminations", Type: Dbytea},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "miner_actor_id"),
}

var TableMinerInfos = Table{
	Name: `filecoin.miner_infos`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "miner_actor_id", Type: Dtext},
		{Name: "owner_id", Type: Dtext},
		{Name: "worker_id", Type: Dtext},
		{Name: "peer_id", Type: Dtext},
		{Name: "control_addresses", Type: Djsonb},
		{Name: "new_worker", Type: Dtext},
		{Name: "new_worker_start_epoch", Type: Dbigint},
		{Name: "multi_addresses", Type: Djsonb},
		{Name: "seal_proof_type", Type: Dinteger},
		{Name: "sector_size", Type: Dbigint},
		{Name: "consensus_faulted_elapsed", Type: Dbigint},
		{Name: "pending_owner", Type: Dtext},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "miner_actor_id"),
}

var TableMinerVestingFunds = Table{
	Name: `filecoin.miner_vesting_funds`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "miner_actor_id", Type: Dtext},
		{Name: "vests_at", Type: Dbigint},
		{Name: "amount", Type: Dnumeric},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "miner_actor_id", "vests_at"),
}

var TableMinerDeadlines = Table{
	Name: `filecoin.miner_deadlines`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "miner_actor_id", Type: Dtext},
		{Name: "index", Type: Dinteger},
		{Name: "partitions_root_cid", Type: Dbigint},
		{Name: "expiration_epochs_root_cid", Type: Dbigint},
		{Name: "post_submissions", Type: Dbytea},
		{Name: "early_terminations", Type: Dbytea},
		{Name: "live_sectors", Type: Dbigint},
		{Name: "total_sectors", Type: Dbigint},
		{Name: "faulty_power_pair_raw", Type: Dnumeric},
		{Name: "faulty_power_pair_qa", Type: Dnumeric},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "miner_actor_id", "index"),
}

var TableMinerPreCommittedSectorInfos = Table{
	Name: `filecoin.miner_pre_committed_sector_infos`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "miner_actor_id", Type: Dtext},
		{Name: "sector_number", Type: Dbigint},
		{Name: "pre_commit_deposit", Type: Dnumeric},
		{Name: "pre_commit_epoch", Type: Dbigint},
		{Name: "deal_weight", Type: Dnumeric},
		{Name: "verified_deal_weight", Type: Dnumeric},
		{Name: "seal_proof", Type: Dinteger},
		{Name: "sealed_cid", Type: Dbigint},
		{Name: "seal_rand_epoch", Type: Dbigint},
		{Name: "deal_ids", Type: DbigintArray},
		{Name: "expiration_epoch", Type: Dbigint},
		{Name: "replace_capacity", Type: Dboolean},
		{Name: "replace_sector_deadline", Type: Dbigint},
		{Name: "replace_sector_partition_number", Type: Dbigint},
		{Name: "replace_sector_number", Type: Dbigint},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "miner_actor_id", "sector_number"),
}

var TableMinerSectorInfos = Table{
	Name: `filecoin.miner_sector_infos`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "miner_actor_id", Type: Dtext},
		{Name: "sector_number", Type: Dbigint},
		{Name: "registered_seal_proof", Type: Dbigint},
		{Name: "sealed_cid", Type: Dbigint},
		{Name: "deal_ids", Type: DbigintArray},
		{Name: "activation_epoch", Type: Dbigint},
		{Name: "expiration_epoch", Type: Dbigint},
		{Name: "deal_weight", Type: Dnumeric},
		{Name: "verified_deal_weight", Type: Dnumeric},
		{Name: "initial_pledge", Type: Dnumeric},
		{Name: "expected_day_reward", Type: Dnumeric},
		{Name: "expected_storage_pledge", Type: Dnumeric},
		{Name: "replaced_sector_age", Type: Dbigint},
		{Name: "replaced_day_reward", Type: Dnumeric},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "miner_actor_id", "sector_number"),
}

var TableMinerPartitions = Table{
	Name: `filecoin.miner_partitions`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "miner_actor_id", Type: Dtext},
		{Name: "deadline_index", Type: Dinteger},
		{Name: "partition_number", Type: Dinteger},
		{Name: "sectors", Type: Dbytea},
		{Name: "faults", Type: Dbytea},
		{Name: "unproven", Type: Dbytea},
		{Name: "recoveries", Type: Dbytea},
		{Name: "terminated", Type: Dbytea},
		{Name: "expiration_epochs_root_cid", Type: Dbigint},
		{Name: "early_terminated_root_cid", Type: Dbigint},
		{Name: "live_power_pair_raw", Type: Dnumeric},
		{Name: "live_power_pair_qa", Type: Dnumeric},
		{Name: "unproven_power_pair_raw", Type: Dnumeric},
		{Name: "unproven_power_pair_qa", Type: Dnumeric},
		{Name: "faulty_power_pair_raw", Type: Dnumeric},
		{Name: "faulty_power_pair_qa", Type: Dnumeric},
		{Name: "recovering_power_pair_raw", Type: Dnumeric},
		{Name: "recovering_power_pair_qa", Type: Dnumeric},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "miner_actor_id", "deadline_index", "partition_number"),
}

var TableMinerPartitionExpirations = Table{
	Name: `filecoin.miner_partition_expirations`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "miner_actor_id", Type: Dtext},
		{Name: "deadline_index", Type: Dinteger},
		{Name: "partition_number", Type: Dinteger},
		{Name: "epoch", Type: Dbigint},
		{Name: "on_time_sectors", Type: Dbytea},
		{Name: "early_sectors", Type: Dbytea},
		{Name: "on_time_pledge", Type: Dnumeric},
		{Name: "active_power_pair_raw", Type: Dnumeric},
		{Name: "active_power_pair_qa", Type: Dnumeric},
		{Name: "faulty_power_pair_raw", Type: Dnumeric},
		{Name: "faulty_power_pair_qa", Type: Dnumeric},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "miner_actor_id", "deadline_index", "partition_number", "epoch"),
}

var TableMultisigActorStates = Table{
	Name: `filecoin.multisig_actor_states`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "multisig_actor_id", Type: Dtext},
		{Name: "signers", Type: DtextArray},
		{Name: "num_approvals_threshold", Type: Dbigint},
		{Name: "next_tx_id", Type: Dbigint},
		{Name: "initial_balance", Type: Dnumeric},
		{Name: "start_epoch", Type: Dbigint},
		{Name: "unlock_duration", Type: Dbigint},
		{Name: "pending_txs_root_cid", Type: Dbigint},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "multisig_actor_id"),
}

var TableMultisigPendingTransactions = Table{
	Name: `filecoin.multisig_pending_txs`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "multisig_actor_id", Type: Dtext},
		{Name: "transaction_id", Type: Dbigint},
		{Name: "to", Type: Dtext},
		{Name: "value", Type: Dnumeric},
		{Name: "params", Type: Dbytea},
		{Name: "approved", Type: DtextArray},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "multisig_actor_id", "transaction_id"),
}

var TablePaymentChannelActorStates = Table{
	Name: `filecoin.payment_channel_actor_states`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "payment_channel_actor_id", Type: Dtext},
		{Name: "from", Type: Dtext},
		{Name: "to", Type: Dtext},
		{Name: "to_send", Type: Dnumeric},
		{Name: "settling_at_epoch", Type: Dbigint},
		{Name: "min_settle_height", Type: Dbigint},
		{Name: "lane_states_root_cid", Type: Dbigint},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "payment_channel_actor_id"),
}

var TablePaymentChannelLaneStates = Table{
	Name: `filecoin.payment_channel_lane_states`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "payment_channel_actor_id", Type: Dtext},
		{Name: "lane_id", Type: Dinteger},
		{Name: "redeemed", Type: Dnumeric},
		{Name: "nonce", Type: Dbigint},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "payment_channel_actor_id", "lane_id"),
}

var TableStoragePowerActorStates = Table{
	Name: `filecoin.storage_power_actor_states`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "storage_power_actor_id", Type: Dtext},
		{Name: "total_raw_byte_power", Type: Dnumeric},
		{Name: "total_bytes_committed", Type: Dnumeric},
		{Name: "total_quality_adj_power", Type: Dnumeric},
		{Name: "total_qa_bytes_committed", Type: Dnumeric},
		{Name: "total_pledge_collateral", Type: Dnumeric},
		{Name: "this_epoch_raw_byte_power", Type: Dnumeric},
		{Name: "this_epoch_quality_adj_power", Type: Dnumeric},
		{Name: "this_epoch_pledge_collateral", Type: Dnumeric},
		{Name: "this_epoch_qa_power_smoothed_pos", Type: Dnumeric},
		{Name: "this_epoch_qa_power_smoothed_vel", Type: Dnumeric},
		{Name: "miner_count", Type: Dinteger},
		{Name: "miner_above_min_power_count", Type: Dinteger},
		{Name: "cron_event_queue_root_cid", Type: Dbigint},
		{Name: "first_cron_epoch", Type: Dbigint},
		{Name: "last_processed_cron_epoch", Type: Dbigint},
		{Name: "proof_validation_batch_root_cid", Type: Dbigint},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "storage_power_actor_id"),
}

var TableStoragePowerCronEventBuckets = Table{
	Name: `filecoin.storage_power_cron_event_buckets`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "storage_power_actor_id", Type: Dtext},
		{Name: "epoch", Type: Dbigint},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "storage_power_actor_id", "epoch"),
}

var TableStoragePowerCronEvents = Table{
	Name: `filecoin.storage_power_cron_events`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "storage_power_actor_id", Type: Dtext},
		{Name: "epoch", Type: Dbigint},
		{Name: "index", Type: Dinteger},
		{Name: "miner_address", Type: Dtext},
		{Name: "callback_payload", Type: Dbytea},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "storage_power_actor_id", "epoch", "index"),
}

var TableStoragePowerClaims = Table{
	Name: `filecoin.storage_power_claims`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "storage_power_actor_id", Type: Dtext},
		{Name: "address", Type: Dtext},
		{Name: "seal_proof_type", Type: Dinteger},
		{Name: "raw_byte_power", Type: Dnumeric},
		{Name: "quality_adj_power", Type: Dnumeric},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "storage_power_actor_id", "address"),
}

var TableStoragePowerProofValidationBuckets = Table{
	Name: `filecoin.storage_power_proof_validation_buckets`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "storage_power_actor_id", Type: Dtext},
		{Name: "address", Type: Dtext},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "storage_power_actor_id", "address"),
}

var TableStoragePowerProofSealVerifyInfos = Table{
	Name: `filecoin.storage_power_proof_seal_verify_infos`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "storage_power_actor_id", Type: Dtext},
		{Name: "address", Type: Dtext},
		{Name: "index", Type: Dbigint},
		{Name: "seal_proof", Type: Dbigint},
		{Name: "sector_id", Type: Dbigint},
		{Name: "deal_ids", Type: DbigintArray},
		{Name: "randomness", Type: Dbytea},
		{Name: "interactive_randomness", Type: Dbytea},
		{Name: "proof", Type: Dbytea},
		{Name: "sealed_cid", Type: Dbigint},
		{Name: "unsealed_cid", Type: Dbigint},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "storage_power_actor_id", "address", "index"),
}

var TableVerifiedRegistryActorStates = Table{
	Name: `filecoin.verified_registry_actor_states`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "verified_registry_actor_id", Type: Dtext},
		{Name: "root_address", Type: Dtext},
		{Name: "verifiers_root_cid", Type: Dbigint},
		{Name: "verified_clients_root_cid", Type: Dbigint},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "verified_registry_actor_id"),
}

var TableVerifiedRegistryVerifiers = Table{
	Name: `filecoin.verified_registry_verifiers`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "verified_registry_actor_id", Type: Dtext},
		{Name: "address", Type: Dtext},
		{Name: "data_cap", Type: Dnumeric},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "verified_registry_actor_id", "address"),
}

var TableVerifiedRegistryClients = Table{
	Name: `filecoin.verified_registry_clients`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "verified_registry_actor_id", Type: Dtext},
		{Name: "address", Type: Dtext},
		{Name: "data_cap", Type: Dnumeric},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "verified_registry_actor_id", "address"),
}

var TableFEVMActorState = Table{
	Name: `filecoin.fevm_actor_state`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "state_account_id", Type: Dtext},
		{Name: "byte_code", Type: Dbytea},
		{Name: "storage_root_cid", Type: Dbigint},
		{Name: "logs_root_cid", Type: Dbigint},
		{Name: "diff", Type: Dboolean},
		{Name: "removed", Type: Dboolean},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "state_account_id"),
}

var TableFEVMActorStorage = Table{
	Name: `filecoin.fevm_actor_storage`,
	Columns: []Column{
		{Name: "height", Type: Dbigint},
		{Name: "state_root_cid", Type: Dbigint},
		{Name: "state_account_id", Type: Dtext},
		{Name: "storage_id", Type: Dtext},
		{Name: "val", Type: Dbytea},
		{Name: "diff", Type: Dboolean},
		{Name: "removed", Type: Dboolean},
		{Name: "selector_suffix", Type: DintegerArray},
	},
	UpsertClause: OnConflict("height", "state_root_cid", "state_account_id", "storage_id"),
}
