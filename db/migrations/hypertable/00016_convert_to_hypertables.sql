-- +goose Up
SELECT create_hypertable('ipld.blocks', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.tip_sets', 'block_number', migrate_data => true, chunk_time_interval => 100800);
SELECT create_hypertable('filecoin.tip_set_members', 'block_number', migrate_data => true, chunk_time_interval => 20160);
SELECT create_hypertable('filecoin.block_headers', 'block_number', migrate_data => true, chunk_time_interval => 20160);
SELECT create_hypertable('filecoin.block_parents', 'block_number', migrate_data => true, chunk_time_interval => 20160);
SELECT create_hypertable('filecoin.block_messages', 'block_number', migrate_data => true, chunk_time_interval => 32768);
SELECT create_hypertable('filecoin.messages', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.parsed_messages', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.internal_messages', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.internal_parsed_messages', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.vm_messages', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.receipts', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.drand_block_entries', 'block_number', migrate_data => true, chunk_time_interval => 100800);
SELECT create_hypertable('filecoin.actors', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.actor_states', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.actor_events', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.init_actor_id_addresses', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.cron_actor_method_receivers', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.reward_actor_v0state', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.reward_actor_v2state', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.account_actor_addresses', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_actor_state', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_actor_deal_proposals', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_actor_deal_states', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_actor_pending_proposals', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_actor_escrows', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_actor_locked_tokens', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_actor_deal_ops_buckets', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_actor_deal_ops_at_epoch', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_actor_locked_tokens', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.miner_actor_v0state', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.miner_actor_v2state', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.miner_v0infos', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.miner_v2infos', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.miner_vesting_funds', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.miner_v0deadlines', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.miner_v2deadlines', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.miner_pre_committed_sector_infos', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.miner_v0sector_infos', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.miner_v2sector_infos', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.miner_v0partitions', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.miner_v2partitions', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.miner_partition_expirations', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.multisig_actor_state', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.multisig_pending_txs', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.payment_channel_actor_state', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.payment_channel_lane_states', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_power_actor_v0state', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_power_actor_v2state', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_power_cron_event_buckets', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_power_cron_events', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_power_v0claims', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_power_v2claims', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_power_proof_validation_buckets', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.storage_power_proof_seal_verify_infos', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.verified_registry_actor_state', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.verified_registry_verifiers', 'block_number', migrate_data => true, chunk_time_interval => 2880);
SELECT create_hypertable('filecoin.verified_registry_clients', 'block_number', migrate_data => true, chunk_time_interval => 2880);

-- update version
INSERT INTO public.db_version (singleton, version) VALUES (true, 'v0.0.0-h')
    ON CONFLICT (singleton) DO UPDATE SET (version, tstamp) = ('v0.0.0-h', NOW());

-- +goose Down
INSERT INTO public.db_version (singleton, version) VALUES (true, 'v0.0.0')
    ON CONFLICT (singleton) DO UPDATE SET (version, tstamp) = ('v0.0.0', NOW());

-- reversing conversion to hypertable requires migrating all data from every chunk back to a single table
-- create new regular tables
CREATE TABLE ipld.blocks_i (LIKE ipld.blocks INCLUDING ALL);
CREATE TABLE filecoin.tip_sets_i (LIKE filecoin.tip_sets INCLUDING ALL);
CREATE TABLE filecoin.tip_set_members_i (LIKE filecoin.tip_set_members INCLUDING ALL);
CREATE TABLE filecoin.block_headers_i (LIKE filecoin.block_headers INCLUDING ALL);
CREATE TABLE filecoin.block_parents_i (LIKE filecoin.block_parents INCLUDING ALL);
CREATE TABLE filecoin.block_messages_i (LIKE filecoin.block_messages INCLUDING ALL);
CREATE TABLE filecoin.messages_i (LIKE filecoin.messages INCLUDING ALL);
CREATE TABLE filecoin.parsed_messages_i (LIKE filecoin.parsed_messages INCLUDING ALL);
CREATE TABLE filecoin.internal_messages_i (LIKE filecoin.internal_messages INCLUDING ALL);
CREATE TABLE filecoin.internal_parsed_messages_i (LIKE filecoin.internal_parsed_messages INCLUDING ALL);
CREATE TABLE filecoin.vm_messages_i (LIKE filecoin.vm_messages INCLUDING ALL);
CREATE TABLE filecoin.receipts_i (LIKE filecoin.receipts INCLUDING ALL);
CREATE TABLE filecoin.drand_block_entries_i (LIKE filecoin.drand_block_entries INCLUDING ALL);
CREATE TABLE filecoin.actors_i (LIKE filecoin.actors INCLUDING ALL);
CREATE TABLE filecoin.actor_states_i (LIKE filecoin.actor_states INCLUDING ALL);
CREATE TABLE filecoin.actor_events_i (LIKE filecoin.actor_events INCLUDING ALL);
CREATE TABLE filecoin.init_actor_id_addresses_i (LIKE filecoin.init_actor_id_addresses INCLUDING ALL);
CREATE TABLE filecoin.cron_actor_method_receivers_i (LIKE filecoin.cron_actor_method_receivers INCLUDING ALL);
CREATE TABLE filecoin.reward_actor_v0state_i (LIKE filecoin.reward_actor_v0state INCLUDING ALL);
CREATE TABLE filecoin.reward_actor_v2state_i (LIKE filecoin.reward_actor_v2state INCLUDING ALL);
CREATE TABLE filecoin.account_actor_addresses_i (LIKE filecoin.account_actor_addresses INCLUDING ALL);
CREATE TABLE filecoin.storage_actor_state_i (LIKE filecoin.storage_actor_state INCLUDING ALL);
CREATE TABLE filecoin.storage_actor_deal_proposals_i (LIKE filecoin.storage_actor_deal_proposals INCLUDING ALL);
CREATE TABLE filecoin.storage_actor_deal_states_i (LIKE filecoin.storage_actor_deal_states INCLUDING ALL);
CREATE TABLE filecoin.storage_actor_pending_proposals_i (LIKE filecoin.storage_actor_pending_proposals INCLUDING ALL);
CREATE TABLE filecoin.storage_actor_escrows_i (LIKE filecoin.storage_actor_escrows INCLUDING ALL);
CREATE TABLE filecoin.storage_actor_locked_tokens_i (LIKE filecoin.storage_actor_locked_tokens INCLUDING ALL);
CREATE TABLE filecoin.storage_actor_deal_ops_buckets_i (LIKE filecoin.storage_actor_deal_ops_buckets INCLUDING ALL);
CREATE TABLE filecoin.storage_actor_deal_ops_at_epoch_i (LIKE filecoin.storage_actor_deal_ops_at_epoch INCLUDING ALL);
CREATE TABLE filecoin.storage_actor_locked_tokens_i (LIKE filecoin.storage_actor_locked_tokens INCLUDING ALL);
CREATE TABLE filecoin.miner_actor_v0state_i (LIKE filecoin.miner_actor_v0state INCLUDING ALL);
CREATE TABLE filecoin.miner_actor_v2state_i (LIKE filecoin.miner_actor_v2state INCLUDING ALL);
CREATE TABLE filecoin.miner_v0infos_i (LIKE filecoin.miner_v0infos INCLUDING ALL);
CREATE TABLE filecoin.miner_v2infos_i (LIKE filecoin.miner_v2infos INCLUDING ALL);
CREATE TABLE filecoin.miner_vesting_funds_i (LIKE filecoin.miner_vesting_funds INCLUDING ALL);
CREATE TABLE filecoin.miner_v0deadlines_i (LIKE filecoin.miner_v0deadlines INCLUDING ALL);
CREATE TABLE filecoin.miner_v2deadlines_i (LIKE filecoin.miner_v2deadlines INCLUDING ALL);
CREATE TABLE filecoin.miner_pre_committed_sector_infos_i (LIKE filecoin.miner_pre_committed_sector_infos INCLUDING ALL);
CREATE TABLE filecoin.miner_v0sector_infos_i (LIKE filecoin.miner_v0sector_infos INCLUDING ALL);
CREATE TABLE filecoin.miner_v2sector_infos_i (LIKE filecoin.miner_v2sector_infos INCLUDING ALL);
CREATE TABLE filecoin.miner_v0partitions_i (LIKE filecoin.miner_v0partitions INCLUDING ALL);
CREATE TABLE filecoin.miner_v2partitions_i (LIKE filecoin.miner_v2partitions INCLUDING ALL);
CREATE TABLE filecoin.miner_partition_expirations_i (LIKE filecoin.miner_partition_expirations INCLUDING ALL);
CREATE TABLE filecoin.multisig_actor_state_i (LIKE filecoin.multisig_actor_state INCLUDING ALL);
CREATE TABLE filecoin.multisig_pending_txs_i (LIKE filecoin.multisig_pending_txs INCLUDING ALL);
CREATE TABLE filecoin.payment_channel_actor_state_i (LIKE filecoin.payment_channel_actor_state INCLUDING ALL);
CREATE TABLE filecoin.payment_channel_lane_states_i (LIKE filecoin.payment_channel_lane_states INCLUDING ALL);
CREATE TABLE filecoin.storage_power_actor_v0state_i (LIKE filecoin.storage_power_actor_v0state INCLUDING ALL);
CREATE TABLE filecoin.storage_power_actor_v2state_i (LIKE filecoin.storage_power_actor_v2state INCLUDING ALL);
CREATE TABLE filecoin.storage_power_cron_event_buckets_i (LIKE filecoin.storage_power_cron_event_buckets INCLUDING ALL);
CREATE TABLE filecoin.storage_power_cron_events_i (LIKE filecoin.storage_power_cron_events INCLUDING ALL);
CREATE TABLE filecoin.storage_power_v0claims_i (LIKE filecoin.storage_power_v0claims INCLUDING ALL);
CREATE TABLE filecoin.storage_power_v2claims_i (LIKE filecoin.storage_power_v2claims INCLUDING ALL);
CREATE TABLE filecoin.storage_power_proof_validation_buckets_i (LIKE filecoin.storage_power_proof_validation_buckets INCLUDING ALL);
CREATE TABLE filecoin.storage_power_proof_seal_verify_infos_i (LIKE filecoin.storage_power_proof_seal_verify_infos INCLUDING ALL);
CREATE TABLE filecoin.verified_registry_actor_state_i (LIKE filecoin.verified_registry_actor_state INCLUDING ALL);
CREATE TABLE filecoin.verified_registry_verifiers_i (LIKE filecoin.verified_registry_verifiers INCLUDING ALL);
CREATE TABLE filecoin.verified_registry_clients_i (LIKE filecoin.verified_registry_clients INCLUDING ALL);

-- migrate data
INSERT INTO ipld.blocks_i (SELECT * FROM ipld.blocks);
INSERT INTO filecoin.tip_sets_i (SELECT * FROM filecoin.tip_sets);
INSERT INTO filecoin.tip_set_members_i (SELECT * FROM filecoin.tip_set_members);
INSERT INTO filecoin.block_headers_i (SELECT * FROM filecoin.block_headers);
INSERT INTO filecoin.block_parents_i (SELECT * FROM filecoin.block_parents);
INSERT INTO filecoin.block_messages_i (SELECT * FROM filecoin.block_messages);
INSERT INTO filecoin.messages_i (SELECT * FROM filecoin.messages);
INSERT INTO filecoin.parsed_messages_i (SELECT * FROM filecoin.parsed_messages);
INSERT INTO filecoin.internal_messages_i (SELECT * FROM filecoin.internal_messages);
INSERT INTO filecoin.internal_parsed_messages_i (SELECT * FROM filecoin.internal_parsed_messages);
INSERT INTO filecoin.vm_messages_i (SELECT * FROM filecoin.vm_messages);
INSERT INTO filecoin.receipts_i (SELECT * FROM filecoin.receipts);
INSERT INTO filecoin.drand_block_entries_i (SELECT * FROM filecoin.drand_block_entries);
INSERT INTO filecoin.actors_i (SELECT * FROM filecoin.actors);
INSERT INTO filecoin.actor_states_i (SELECT * FROM filecoin.actor_states);
INSERT INTO filecoin.actor_events_i (SELECT * FROM filecoin.actor_events);
INSERT INTO filecoin.init_actor_id_addresses_i (SELECT * FROM filecoin.init_actor_id_addresses);
INSERT INTO filecoin.cron_actor_method_receivers_i (SELECT * FROM filecoin.cron_actor_method_receivers);
INSERT INTO filecoin.reward_actor_v0state_i (SELECT * FROM filecoin.reward_actor_v0state);
INSERT INTO filecoin.reward_actor_v2state_i (SELECT * FROM filecoin.reward_actor_v2state);
INSERT INTO filecoin.account_actor_addresses_i (SELECT * FROM filecoin.account_actor_addresses);
INSERT INTO filecoin.storage_actor_state_i (SELECT * FROM filecoin.storage_actor_state);
INSERT INTO filecoin.storage_actor_deal_proposals_i (SELECT * FROM filecoin.storage_actor_deal_proposals);
INSERT INTO filecoin.storage_actor_deal_states_i (SELECT * FROM filecoin.storage_actor_deal_states);
INSERT INTO filecoin.storage_actor_pending_proposals_i (SELECT * FROM filecoin.storage_actor_pending_proposals);
INSERT INTO filecoin.storage_actor_escrows_i (SELECT * FROM filecoin.storage_actor_escrows);
INSERT INTO filecoin.storage_actor_locked_tokens_i (SELECT * FROM filecoin.storage_actor_locked_tokens);
INSERT INTO filecoin.storage_actor_deal_ops_buckets_i (SELECT * FROM filecoin.storage_actor_deal_ops_buckets);
INSERT INTO filecoin.storage_actor_deal_ops_at_epoch_i (SELECT * FROM filecoin.storage_actor_deal_ops_at_epoch);
INSERT INTO filecoin.storage_actor_locked_tokens_i (SELECT * FROM filecoin.storage_actor_locked_tokens);
INSERT INTO filecoin.miner_actor_v0state_i (SELECT * FROM filecoin.miner_actor_v0state);
INSERT INTO filecoin.miner_actor_v2state_i (SELECT * FROM filecoin.miner_actor_v2state);
INSERT INTO filecoin.miner_v0infos_i (SELECT * FROM filecoin.miner_v0infos);
INSERT INTO filecoin.miner_v2infos_i (SELECT * FROM filecoin.miner_v2infos);
INSERT INTO filecoin.miner_vesting_funds_i (SELECT * FROM filecoin.miner_vesting_funds);
INSERT INTO filecoin.miner_v0deadlines_i (SELECT * FROM filecoin.miner_v0deadlines);
INSERT INTO filecoin.miner_v2deadlines_i (SELECT * FROM filecoin.miner_v2deadlines);
INSERT INTO filecoin.miner_pre_committed_sector_infos_i (SELECT * FROM filecoin.miner_pre_committed_sector_infos);
INSERT INTO filecoin.miner_v0sector_infos_i (SELECT * FROM filecoin.miner_v0sector_infos);
INSERT INTO filecoin.miner_v2sector_infos_i (SELECT * FROM filecoin.miner_v2sector_infos);
INSERT INTO filecoin.miner_v0partitions_i (SELECT * FROM filecoin.miner_v0partitions);
INSERT INTO filecoin.miner_v2partitions_i (SELECT * FROM filecoin.miner_v2partitions);
INSERT INTO filecoin.miner_partition_expirations_i (SELECT * FROM filecoin.miner_partition_expirations);
INSERT INTO filecoin.multisig_actor_state_i (SELECT * FROM filecoin.multisig_actor_state);
INSERT INTO filecoin.multisig_pending_txs_i (SELECT * FROM filecoin.multisig_pending_txs);
INSERT INTO filecoin.payment_channel_actor_state_i (SELECT * FROM filecoin.payment_channel_actor_state);
INSERT INTO filecoin.payment_channel_lane_states_i (SELECT * FROM filecoin.payment_channel_lane_states);
INSERT INTO filecoin.storage_power_actor_v0state_i (SELECT * FROM filecoin.storage_power_actor_v0state);
INSERT INTO filecoin.storage_power_actor_v2state_i (SELECT * FROM filecoin.storage_power_actor_v2state);
INSERT INTO filecoin.storage_power_cron_event_buckets_i (SELECT * FROM filecoin.storage_power_cron_event_buckets);
INSERT INTO filecoin.storage_power_cron_events_i (SELECT * FROM filecoin.storage_power_cron_events);
INSERT INTO filecoin.storage_power_v0claims_i (SELECT * FROM filecoin.storage_power_v0claims);
INSERT INTO filecoin.storage_power_v2claims_i (SELECT * FROM filecoin.storage_power_v2claims);
INSERT INTO filecoin.storage_power_proof_validation_buckets_i (SELECT * FROM filecoin.storage_power_proof_validation_buckets);
INSERT INTO filecoin.storage_power_proof_seal_verify_infos_i (SELECT * FROM filecoin.storage_power_proof_seal_verify_infos);
INSERT INTO filecoin.verified_registry_actor_state_i (SELECT * FROM filecoin.verified_registry_actor_state);
INSERT INTO filecoin.verified_registry_verifiers_i (SELECT * FROM filecoin.verified_registry_verifiers);
INSERT INTO filecoin.verified_registry_clients_i (SELECT * FROM filecoin.verified_registry_clients);

-- drop hypertables
DROP TABLE  ipld.blocks;
DROP TABLE  filecoin.tip_sets;
DROP TABLE  filecoin.tip_set_members;
DROP TABLE  filecoin.block_headers;
DROP TABLE  filecoin.block_parents;
DROP TABLE  filecoin.block_messages;
DROP TABLE  filecoin.messages;
DROP TABLE  filecoin.parsed_messages;
DROP TABLE  filecoin.internal_messages;
DROP TABLE  filecoin.internal_parsed_messages;
DROP TABLE  filecoin.vm_messages;
DROP TABLE  filecoin.receipts;
DROP TABLE  filecoin.drand_block_entries;
DROP TABLE  filecoin.actors;
DROP TABLE  filecoin.actor_states;
DROP TABLE  filecoin.actor_events;
DROP TABLE  filecoin.init_actor_id_addresses;
DROP TABLE  filecoin.cron_actor_method_receivers;
DROP TABLE  filecoin.reward_actor_v0state;
DROP TABLE  filecoin.reward_actor_v2state;
DROP TABLE  filecoin.account_actor_addresses;
DROP TABLE  filecoin.storage_actor_state;
DROP TABLE  filecoin.storage_actor_deal_proposals;
DROP TABLE  filecoin.storage_actor_deal_states;
DROP TABLE  filecoin.storage_actor_pending_proposals;
DROP TABLE  filecoin.storage_actor_escrows;
DROP TABLE  filecoin.storage_actor_locked_tokens;
DROP TABLE  filecoin.storage_actor_deal_ops_buckets;
DROP TABLE  filecoin.storage_actor_deal_ops_at_epoch;
DROP TABLE  filecoin.storage_actor_locked_tokens;
DROP TABLE  filecoin.miner_actor_v0state;
DROP TABLE  filecoin.miner_actor_v2state;
DROP TABLE  filecoin.miner_v0infos;
DROP TABLE  filecoin.miner_v2infos;
DROP TABLE  filecoin.miner_vesting_funds;
DROP TABLE  filecoin.miner_v0deadlines;
DROP TABLE  filecoin.miner_v2deadlines;
DROP TABLE  filecoin.miner_pre_committed_sector_infos;
DROP TABLE  filecoin.miner_v0sector_infos;
DROP TABLE  filecoin.miner_v2sector_infos;
DROP TABLE  filecoin.miner_v0partitions;
DROP TABLE  filecoin.miner_v2partitions;
DROP TABLE  filecoin.miner_partition_expirations;
DROP TABLE  filecoin.multisig_actor_state;
DROP TABLE  filecoin.multisig_pending_txs;
DROP TABLE  filecoin.payment_channel_actor_state;
DROP TABLE  filecoin.payment_channel_lane_states;
DROP TABLE  filecoin.storage_power_actor_v0state;
DROP TABLE  filecoin.storage_power_actor_v2state;
DROP TABLE  filecoin.storage_power_cron_event_buckets;
DROP TABLE  filecoin.storage_power_cron_events;
DROP TABLE  filecoin.storage_power_v0claims;
DROP TABLE  filecoin.storage_power_v2claims;
DROP TABLE  filecoin.storage_power_proof_validation_buckets;
DROP TABLE  filecoin.storage_power_proof_seal_verify_infos;
DROP TABLE  filecoin.verified_registry_actor_state;
DROP TABLE  filecoin.verified_registry_verifiers;
DROP TABLE  filecoin.verified_registry_clients;

-- rename new tables
ALTER TABLE filecoin.tip_sets RENAME TO tip_sets;
ALTER TABLE filecoin.tip_set_members RENAME TO tip_set_members;
ALTER TABLE filecoin.block_headers RENAME TO block_headers;
ALTER TABLE filecoin.block_parents RENAME TO block_parents;
ALTER TABLE filecoin.block_messages RENAME TO block_messages;
ALTER TABLE filecoin.messages RENAME TO messages;
ALTER TABLE filecoin.parsed_messages RENAME TO parsed_messages;
ALTER TABLE filecoin.internal_messages RENAME TO internal_messages;
ALTER TABLE filecoin.internal_parsed_messages RENAME TO internal_parsed_messages;
ALTER TABLE filecoin.vm_messages RENAME TO vm_messages;
ALTER TABLE filecoin.receipts RENAME TO receipts;
ALTER TABLE filecoin.drand_block_entries RENAME TO drand_block_entries;
ALTER TABLE filecoin.actors RENAME TO actors;
ALTER TABLE filecoin.actor_states RENAME TO actor_states;
ALTER TABLE filecoin.actor_events RENAME TO actor_events;
ALTER TABLE filecoin.init_actor_id_addresses RENAME TO init_actor_id_addresses;
ALTER TABLE filecoin.cron_actor_method_receivers RENAME TO cron_actor_method_receivers;
ALTER TABLE filecoin.reward_actor_v0state RENAME TO reward_actor_v0state;
ALTER TABLE filecoin.reward_actor_v2state RENAME TO reward_actor_v2state;
ALTER TABLE filecoin.account_actor_addresses RENAME TO account_actor_addresses;
ALTER TABLE filecoin.storage_actor_state RENAME TO storage_actor_state;
ALTER TABLE filecoin.storage_actor_deal_proposals RENAME TO storage_actor_deal_proposals;
ALTER TABLE filecoin.storage_actor_deal_states RENAME TO storage_actor_deal_states;
ALTER TABLE filecoin.storage_actor_pending_proposals RENAME TO storage_actor_pending_proposals;
ALTER TABLE filecoin.storage_actor_escrows RENAME TO storage_actor_escrows;
ALTER TABLE filecoin.storage_actor_locked_tokens RENAME TO storage_actor_locked_tokens;
ALTER TABLE filecoin.storage_actor_deal_ops_buckets RENAME TO storage_actor_deal_ops_buckets;
ALTER TABLE filecoin.storage_actor_deal_ops_at_epoch RENAME TO storage_actor_deal_ops_at_epoch;
ALTER TABLE filecoin.storage_actor_locked_tokens RENAME TO storage_actor_locked_tokens;
ALTER TABLE filecoin.miner_actor_v0state RENAME TO miner_actor_v0state;
ALTER TABLE filecoin.miner_actor_v2state RENAME TO miner_actor_v2state;
ALTER TABLE filecoin.miner_v0infos RENAME TO miner_v0infos;
ALTER TABLE filecoin.miner_v2infos RENAME TO miner_v2infos;
ALTER TABLE filecoin.miner_vesting_funds RENAME TO miner_vesting_funds;
ALTER TABLE filecoin.miner_v0deadlines RENAME TO miner_v0deadlines;
ALTER TABLE filecoin.miner_v2deadlines RENAME TO miner_v2deadlines;
ALTER TABLE filecoin.miner_pre_committed_sector_infos RENAME TO miner_pre_committed_sector_infos;
ALTER TABLE filecoin.miner_v0sector_infos RENAME TO miner_v0sector_infos;
ALTER TABLE filecoin.miner_v2sector_infos RENAME TO miner_v2sector_infos;
ALTER TABLE filecoin.miner_v0partitions RENAME TO miner_v0partitions;
ALTER TABLE filecoin.miner_v2partitions RENAME TO miner_v2partitions;
ALTER TABLE filecoin.miner_partition_expirations RENAME TO miner_partition_expirations;
ALTER TABLE filecoin.multisig_actor_state RENAME TO multisig_actor_state;
ALTER TABLE filecoin.multisig_pending_txs RENAME TO multisig_pending_txs;
ALTER TABLE filecoin.payment_channel_actor_state RENAME TO payment_channel_actor_state;
ALTER TABLE filecoin.payment_channel_lane_states RENAME TO payment_channel_lane_states;
ALTER TABLE filecoin.storage_power_actor_v0state RENAME TO storage_power_actor_v0state;
ALTER TABLE filecoin.storage_power_actor_v2state RENAME TO storage_power_actor_v2state;
ALTER TABLE filecoin.storage_power_cron_event_buckets RENAME TO storage_power_cron_event_buckets;
ALTER TABLE filecoin.storage_power_cron_events RENAME TO storage_power_cron_events;
ALTER TABLE filecoin.storage_power_v0claims RENAME TO storage_power_v0claims;
ALTER TABLE filecoin.storage_power_v2claims RENAME TO storage_power_v2claims;
ALTER TABLE filecoin.storage_power_proof_validation_buckets RENAME TO storage_power_proof_validation_buckets;
ALTER TABLE filecoin.storage_power_proof_seal_verify_infos RENAME TO storage_power_proof_seal_verify_infos;
ALTER TABLE filecoin.verified_registry_actor_state RENAME TO verified_registry_actor_state;
ALTER TABLE filecoin.verified_registry_verifiers RENAME TO verified_registry_verifiers;
ALTER TABLE filecoin.verified_registry_clients RENAME TO verified_registry_clients;
ALTER TABLE ipld.blocks_i RENAME TO blocks;