-- +goose Up
-- ipld blockstore table
ALTER TABLE ipld.blocks
ADD CONSTRAINT blocks_key_filecoin_cids_fkey
FOREIGN KEY (key)
REFERENCES filecoin.cids (id);

-- tip set tables
ALTER TABLE filecoin.tip_sets
ADD CONSTRAINT tip_sets_height_parent_tip_set_key_cid_ipld_blocks_fkey
FOREIGN KEY (height, parent_tip_set_key_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.tip_sets
ADD CONSTRAINT tip_sets_height_parent_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, parent_state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.tip_set_members
ADD CONSTRAINT tip_set_members_height_parent_tip_set_key_cid_ipld_blocks_fkey
FOREIGN KEY (height, parent_tip_set_key_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.tip_set_members
ADD CONSTRAINT tip_set_members_height_block_cid_ipld_blocks_fkey
FOREIGN KEY (height, block_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.tip_set_members
ADD CONSTRAINT tip_set_members_height_parent_tip_set_key_cid_tip_sets_fkey
FOREIGN KEY (height, parent_tip_set_key_cid)
REFERENCES ipld.blocks (height, key);

-- block header tables
ALTER TABLE filecoin.block_headers
ADD CONSTRAINT headers_height_parent_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, parent_state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.block_headers
ADD CONSTRAINT headers_height_parent_tip_set_key_cid_ipld_blocks_fkey
FOREIGN KEY (height, parent_tip_set_key_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.block_headers
ADD CONSTRAINT headers_height_parent_message_rcts_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, parent_state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.block_headers
ADD CONSTRAINT headers_height_messages_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, parent_state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.block_headers
ADD CONSTRAINT headers_height_parent_tip_set_key_cid_tip_sets_fkey
FOREIGN KEY (height, parent_state_root_cid)
REFERENCES filecoin.tip_sets (height, parent_tip_set_key_cid);

ALTER TABLE filecoin.block_parents
ADD CONSTRAINT parents_height_block_cid_ipld_blocks_fkey
FOREIGN KEY (height, block_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.block_parents
ADD CONSTRAINT parents_height_parent_cid_ipld_blocks_fkey
FOREIGN KEY (height, parent_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.block_parents
ADD CONSTRAINT parents_height_block_cid_block_headers_fkey
FOREIGN KEY (height, block_cid)
REFERENCES filecoin.block_headers (height, block_cid);

ALTER TABLE filecoin.block_parents
ADD CONSTRAINT parents_height_parent_cid_block_headers_fkey
FOREIGN KEY (height, parent_cid)
REFERENCES filecoin.block_headers (height, block_cid);

-- messages tables
ALTER TABLE filecoin.block_messages
ADD CONSTRAINT block_messages_height_block_cid_ipld_blocks_fkey
FOREIGN KEY (height, block_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.block_messages
ADD CONSTRAINT block_messages_height_message_cid_ipld_blocks_fkey
FOREIGN KEY (height, message_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.block_messages
ADD CONSTRAINT block_messages_height_block_cid_headers_fkey
FOREIGN KEY (height, block_cid)
REFERENCES filecoin.block_headers (height, block_cid);

ALTER TABLE filecoin.messages
ADD CONSTRAINT messages_height_block_cid_ipld_blocks_fkey
FOREIGN KEY (height, block_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.messages
ADD CONSTRAINT messages_height_message_cid_ipld_blocks_fkey
FOREIGN KEY (height, message_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.messages
ADD CONSTRAINT messages_height_block_cid_message_cid_block_messages_fkey
FOREIGN KEY (height, block_cid, message_cid)
REFERENCES filecoin.block_messages (height, block_cid, message_cid);

ALTER TABLE filecoin.parsed_messages
ADD CONSTRAINT parsed_messages_height_block_cid_ipld_blocks_fkey
FOREIGN KEY (height, block_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.parsed_messages
ADD CONSTRAINT parsed_messages_height_message_cid_ipld_blocks_fkey
FOREIGN KEY (height, message_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.parsed_messages
ADD CONSTRAINT parsed_messages_height_block_cid_message_cid_messages_fkey
FOREIGN KEY (height, block_cid, message_cid)
REFERENCES filecoin.messages (height, block_cid, message_cid);

ALTER TABLE filecoin.internal_messages
ADD CONSTRAINT internal_messages_height_block_cid_ipld_blocks_fkey
FOREIGN KEY (height, block_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.internal_messages
ADD CONSTRAINT internal_messages_height_message_cid_ipld_blocks_fkey
FOREIGN KEY (height, message_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.internal_messages
ADD CONSTRAINT internal_msgs_height_block_cid_message_cid_block_messages_fkey
FOREIGN KEY (height, block_cid, message_cid)
REFERENCES filecoin.block_messages (height, block_cid, message_cid);

ALTER TABLE filecoin.internal_parsed_messages
ADD CONSTRAINT int_parsed_messages_height_block_cid_ipld_blocks_fkey
FOREIGN KEY (height, block_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.internal_parsed_messages
ADD CONSTRAINT int_parsed_messages_height_message_cid_ipld_blocks_fkey
FOREIGN KEY (height, message_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.internal_parsed_messages
ADD CONSTRAINT int_parsed_messages_height_block_cid_message_cid_messages_fkey
FOREIGN KEY (height, block_cid, message_cid)
REFERENCES filecoin.internal_messages (height, block_cid, message_cid);

ALTER TABLE filecoin.vm_messages
ADD CONSTRAINT vm_messages_height_block_cid_ipld_blocks_fkey
FOREIGN KEY (height, block_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.vm_messages
ADD CONSTRAINT vm_messages_height_message_cid_ipld_blocks_fkey
FOREIGN KEY (height, message_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.vm_messages
ADD CONSTRAINT vm_msgs_height_block_cid_message_cid_block_messages_fkey
FOREIGN KEY (height, block_cid, message_cid)
REFERENCES filecoin.block_messages (height, block_cid, message_cid);

-- receipts table
ALTER TABLE filecoin.receipts
ADD CONSTRAINT receipts_height_block_cid_ipld_blocks_fkey
FOREIGN KEY (height, block_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.receipts
ADD CONSTRAINT receipts_height_message_cid_ipld_blocks_fkey
FOREIGN KEY (height, message_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.receipts
ADD CONSTRAINT receipts_height_block_cid_message_cid_block_messages_fkey
FOREIGN KEY (height, block_cid, message_cid)
REFERENCES filecoin.block_messages (height, block_cid, message_cid);

-- drand table
ALTER TABLE filecoin.drand_block_entries
ADD CONSTRAINT drand_height_block_cid_ipld_blocks_fkey
FOREIGN KEY (height, block_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.drand_block_entries
ADD CONSTRAINT drand_height_block_cid_block_headers_fkey
FOREIGN KEY (height, block_cid)
REFERENCES filecoin.block_headers (height, block_cid);

-- actor tables
ALTER TABLE filecoin.actors
ADD CONSTRAINT actors_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.actors
ADD CONSTRAINT actors_height_head_cid_ipld_blocks_fkey
FOREIGN KEY (height, head_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.actors
ADD CONSTRAINT actors_height_state_root_cid_tip_sets_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES filecoin.tip_sets (height, parent_state_root_cid);

ALTER TABLE filecoin.actor_states
ADD CONSTRAINT actor_states_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.actor_states
ADD CONSTRAINT actor_states_height_state_root_cid_id_actors_fkey
FOREIGN KEY (height, state_root_cid, id)
REFERENCES filecoin.actors (height, state_root_cid, id);

ALTER TABLE filecoin.actor_events
ADD CONSTRAINT actor_events_height_block_cid_ipld_blocks_fkey
FOREIGN KEY (height, block_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.actor_events
ADD CONSTRAINT actor_events_height_message_cid_ipld_blocks_fkey
FOREIGN KEY (height, message_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.actor_events
ADD CONSTRAINT actor_events_height_block_cid_message_cid_block_messages_fkey
FOREIGN KEY (height, block_cid, message_cid)
REFERENCES filecoin.block_messages (height, block_cid, message_cid);

-- rich actor state tables
ALTER TABLE filecoin.init_actor_id_addresses
ADD CONSTRAINT id_addresses_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.init_actor_id_addresses
ADD CONSTRAINT id_addresses_height_state_root_cid_init_actor_id_actors_fkey
FOREIGN KEY (height, state_root_cid, init_actor_id)
REFERENCES filecoin.actors (height, state_root_cid, id);

ALTER TABLE filecoin.cron_actor_method_receivers
ADD CONSTRAINT method_receivers_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.cron_actor_method_receivers
ADD CONSTRAINT method_rcvrs_height_state_root_cid_cron_actor_id_actors_fkey
FOREIGN KEY (height, state_root_cid, cron_actor_id)
REFERENCES filecoin.actors (height, state_root_cid, id);

ALTER TABLE filecoin.reward_actor_v0state
ADD CONSTRAINT reward_v0state_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.reward_actor_v0state
ADD CONSTRAINT rwrd_v0state_height_state_root_cid_reward_actor_id_actors_fkey
FOREIGN KEY (height, state_root_cid, reward_actor_id)
REFERENCES filecoin.actors (height, state_root_cid, id);

ALTER TABLE filecoin.reward_actor_v2state
ADD CONSTRAINT reward_v2state_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.reward_actor_v2state
ADD CONSTRAINT rwrd_v2state_height_state_root_cid_reward_actor_id_actors_fkey
FOREIGN KEY (height, state_root_cid, reward_actor_id)
REFERENCES filecoin.actors (height, state_root_cid, id);

ALTER TABLE filecoin.account_actor_addresses
ADD CONSTRAINT addresses_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.account_actor_addresses
ADD CONSTRAINT addresses_height_state_root_cid_account_actor_id_actors_fkey
FOREIGN KEY (height, state_root_cid, account_actor_id)
REFERENCES filecoin.actors (height, state_root_cid, id);

ALTER TABLE filecoin.storage_actor_state
ADD CONSTRAINT storage_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_state
ADD CONSTRAINT storage_height_proposals_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, proposals_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_state
ADD CONSTRAINT storage_height_deal_states_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, deal_states_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_state
ADD CONSTRAINT storage_height_pending_proposals_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, pending_proposals_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_state
ADD CONSTRAINT storage_height_escrows_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, escrows_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_state
ADD CONSTRAINT storage_height_locked_tokens_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, locked_tokens_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_state
ADD CONSTRAINT storage_height_deal_ops_by_epoch_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, deal_ops_by_epoch_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_state
ADD CONSTRAINT storage_height_state_root_cid_storage_actor_id_actors_fkey
FOREIGN KEY (height, state_root_cid, storage_actor_id)
REFERENCES filecoin.actors (height, state_root_cid, id);

ALTER TABLE filecoin.storage_actor_deal_proposals
ADD CONSTRAINT deal_props_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_deal_proposals
ADD CONSTRAINT deal_props_height_piece_cid_ipld_blocks_fkey
FOREIGN KEY (height, piece_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_deal_proposals
ADD CONSTRAINT deal_props_height_state_root_cid_storage_actor_id_storage_fkey
FOREIGN KEY (height, state_root_cid, storage_actor_id)
REFERENCES filecoin.storage_actor_state (height, state_root_cid, storage_actor_id);

ALTER TABLE filecoin.storage_actor_deal_states
ADD CONSTRAINT deal_states_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_deal_states
ADD CONSTRAINT deal_states_height_state_root_cid_storage_actor_id_storage_fkey
FOREIGN KEY (height, state_root_cid, storage_actor_id)
REFERENCES filecoin.storage_actor_state (height, state_root_cid, storage_actor_id);

ALTER TABLE filecoin.storage_actor_pending_proposals
ADD CONSTRAINT pending_props_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_pending_proposals
ADD CONSTRAINT pending_props_height_deal_cid_ipld_blocks_fkey
FOREIGN KEY (height, deal_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_pending_proposals
ADD CONSTRAINT pending_props_height_piece_cid_ipld_blocks_fkey
FOREIGN KEY (height, piece_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_pending_proposals
ADD CONSTRAINT pnd_props_height_state_root_cid_storage_actor_id_storage_fkey
FOREIGN KEY (height, state_root_cid, storage_actor_id)
REFERENCES filecoin.storage_actor_state (height, state_root_cid, storage_actor_id);

ALTER TABLE filecoin.storage_actor_escrows
ADD CONSTRAINT escrows_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_escrows
ADD CONSTRAINT escrows_height_state_root_cid_storage_actor_id_storage_fkey
FOREIGN KEY (height, state_root_cid, storage_actor_id)
REFERENCES filecoin.storage_actor_state (height, state_root_cid, storage_actor_id);

ALTER TABLE filecoin.storage_actor_locked_tokens
ADD CONSTRAINT locked_tokens_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_locked_tokens
ADD CONSTRAINT locked_tkns_height_state_root_cid_storage_actor_id_storage_fkey
FOREIGN KEY (height, state_root_cid, storage_actor_id)
REFERENCES filecoin.storage_actor_state (height, state_root_cid, storage_actor_id);

ALTER TABLE filecoin.storage_actor_deal_ops_buckets
ADD CONSTRAINT deal_buckets_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_deal_ops_buckets
ADD CONSTRAINT deal_buckets_height_deals_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, deals_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_deal_ops_buckets
ADD CONSTRAINT deal_bkts_height_state_root_cid_storage_actor_id_storage_fkey
FOREIGN KEY (height, state_root_cid, storage_actor_id)
REFERENCES filecoin.storage_actor_state (height, state_root_cid, storage_actor_id);

ALTER TABLE filecoin.storage_actor_deal_ops_at_epoch
ADD CONSTRAINT ops_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_actor_deal_ops_at_epoch
ADD CONSTRAINT ops_height_state_root_cid_storage_actor_id_epoch_deal_bkts_fkey
FOREIGN KEY (height, state_root_cid, storage_actor_id, epoch)
REFERENCES filecoin.storage_actor_deal_ops_buckets (height, state_root_cid, storage_actor_id, epoch);

ALTER TABLE filecoin.miner_actor_v0state
ADD CONSTRAINT miner_v0state_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_actor_v0state
ADD CONSTRAINT miner_v0state_height_vesting_funds_cid_ipld_blocks_fkey
FOREIGN KEY (height, vesting_funds_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_actor_v0state
ADD CONSTRAINT miner_v0state_height_pre_com_sec_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, pre_committed_sectors_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_actor_v0state
ADD CONSTRAINT miner_v0state_height_pre_com_sec_exp_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, pre_committed_sectors_expiry_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_actor_v0state
ADD CONSTRAINT miner_v0state_height_allocated_sectors_cid_ipld_blocks_fkey
FOREIGN KEY (height, allocated_sectors_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_actor_v0state
ADD CONSTRAINT miner_v0state_height_sectors_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, sectors_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_actor_v0state
ADD CONSTRAINT miner_v0state_height_deadlines_cid_ipld_blocks_fkey
FOREIGN KEY (height, deadlines_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_actor_v0state
ADD CONSTRAINT miner_v0state_height_state_root_cid_miner_actor_id_actors_fkey
FOREIGN KEY (height, state_root_cid, miner_actor_id)
REFERENCES filecoin.actors (height, state_root_cid, id);

ALTER TABLE filecoin.miner_actor_v2state
ADD CONSTRAINT miner_v2state_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_actor_v2state
ADD CONSTRAINT miner_v2state_height_vesting_funds_cid_ipld_blocks_fkey
FOREIGN KEY (height, vesting_funds_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_actor_v2state
ADD CONSTRAINT miner_v2state_height_pre_com_sec_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, pre_committed_sectors_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_actor_v2state
ADD CONSTRAINT miner_v2state_height_pre_com_sec_exp_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, pre_committed_sectors_expiry_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_actor_v2state
ADD CONSTRAINT miner_v2state_height_allocated_sectors_cid_ipld_blocks_fkey
FOREIGN KEY (height, allocated_sectors_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_actor_v2state
ADD CONSTRAINT miner_v2state_height_sectors_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, sectors_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_actor_v2state
ADD CONSTRAINT miner_v2state_height_deadlines_cid_ipld_blocks_fkey
FOREIGN KEY (height, deadlines_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_actor_v2state
ADD CONSTRAINT miner_v2state_height_state_root_cid_miner_actor_id_actors_fkey
FOREIGN KEY (height, state_root_cid, miner_actor_id)
REFERENCES filecoin.actors (height, state_root_cid, id);

ALTER TABLE filecoin.miner_v0infos
ADD CONSTRAINT miner_v0infos_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v0infos
ADD CONSTRAINT miner_v0infos_height_state_root_cid_miner_actor_id_v0state_fkey
FOREIGN KEY (height, state_root_cid, miner_actor_id)
REFERENCES filecoin.miner_actor_v0state (height, state_root_cid, miner_actor_id);

ALTER TABLE filecoin.miner_v2infos
ADD CONSTRAINT miner_v2infos_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v2infos
ADD CONSTRAINT miner_v2infos_height_state_root_cid_miner_actor_id_v2state_fkey
FOREIGN KEY (height, state_root_cid, miner_actor_id)
REFERENCES filecoin.miner_actor_v2state (height, state_root_cid, miner_actor_id);

ALTER TABLE filecoin.miner_vesting_funds
ADD CONSTRAINT vesting_funds_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_vesting_funds
ADD CONSTRAINT vesting_funds_height_state_root_cid_miner_actor_id_v0state_fkey
FOREIGN KEY (height, state_root_cid, miner_actor_id)
REFERENCES filecoin.miner_actor_v0state (height, state_root_cid, miner_actor_id);

ALTER TABLE filecoin.miner_v0deadlines
ADD CONSTRAINT miner_v0deadlines_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v0deadlines
ADD CONSTRAINT miner_v0deadlines_height_partitions_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, partitions_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v0deadlines
ADD CONSTRAINT miner_v0deadlines_height_exp_epochs_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, expiration_epochs_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v0deadlines
ADD CONSTRAINT miner_v0dls_height_state_root_cid_miner_actor_id_v0state_fkey
FOREIGN KEY (height, state_root_cid, miner_actor_id)
REFERENCES filecoin.miner_actor_v0state (height, state_root_cid, miner_actor_id);

ALTER TABLE filecoin.miner_v2deadlines
ADD CONSTRAINT miner_v2deadlines_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v2deadlines
ADD CONSTRAINT miner_v2deadlines_height_partitions_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, partitions_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v2deadlines
ADD CONSTRAINT miner_v2deadlines_height_exp_epochs_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, expiration_epochs_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v2deadlines
ADD CONSTRAINT miner_v2dls_height_state_root_cid_miner_actor_id_v2state_fkey
FOREIGN KEY (height, state_root_cid, miner_actor_id)
REFERENCES filecoin.miner_actor_v2state (height, state_root_cid, miner_actor_id);

ALTER TABLE filecoin.miner_pre_committed_sector_infos
ADD CONSTRAINT pre_sec_infos_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_pre_committed_sector_infos
ADD CONSTRAINT pre_sec_infos_height_sealed_cid_ipld_blocks_fkey
FOREIGN KEY (height, sealed_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_pre_committed_sector_infos
ADD CONSTRAINT pre_sec_infos_height_state_root_cid_miner_actor_id_v0state_fkey
FOREIGN KEY (height, state_root_cid, miner_actor_id)
REFERENCES filecoin.miner_actor_v0state (height, state_root_cid, miner_actor_id);

ALTER TABLE filecoin.miner_v0sector_infos
ADD CONSTRAINT m_v0sec_infos_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v0sector_infos
ADD CONSTRAINT m_v0sec_infos_height_sealed_cid_ipld_blocks_fkey
FOREIGN KEY (height, sealed_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v0sector_infos
ADD CONSTRAINT m_v0sec_infos_height_state_root_cid_miner_actor_id_v0state_fkey
FOREIGN KEY (height, state_root_cid, miner_actor_id)
REFERENCES filecoin.miner_actor_v0state (height, state_root_cid, miner_actor_id);

ALTER TABLE filecoin.miner_v2sector_infos
ADD CONSTRAINT m_v2sec_infos_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v2sector_infos
ADD CONSTRAINT m_v2sec_infos_height_sealed_cid_ipld_blocks_fkey
FOREIGN KEY (height, sealed_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v2sector_infos
ADD CONSTRAINT m_v2sec_infos_height_state_root_cid_miner_actor_id_v2state_fkey
FOREIGN KEY (height, state_root_cid, miner_actor_id)
REFERENCES filecoin.miner_actor_v2state (height, state_root_cid, miner_actor_id);

ALTER TABLE filecoin.miner_v0partitions
ADD CONSTRAINT miner_v0parts_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v0partitions
ADD CONSTRAINT miner_v0parts_height_exp_epochs_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, expiration_epochs_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v0partitions
ADD CONSTRAINT miner_v0parts_height_early_term_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, early_terminated_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v0partitions
ADD CONSTRAINT m_v0parts_height_state_root_cid_m_actor_id_dl_index_v0dls_fkey
FOREIGN KEY (height, state_root_cid, miner_actor_id, deadline_index)
REFERENCES filecoin.miner_v0deadlines (height, state_root_cid, miner_actor_id, index);

ALTER TABLE filecoin.miner_v2partitions
ADD CONSTRAINT miner_v2parts_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v2partitions
ADD CONSTRAINT miner_v2parts_height_exp_epochs_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, expiration_epochs_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v2partitions
ADD CONSTRAINT miner_v2parts_height_early_term_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, early_terminated_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_v2partitions
ADD CONSTRAINT m_v2parts_height_state_root_cid_m_actor_id_dl_index_v2dls_fkey
FOREIGN KEY (height, state_root_cid, miner_actor_id, deadline_index)
REFERENCES filecoin.miner_v2deadlines (height, state_root_cid, miner_actor_id, index);

ALTER TABLE filecoin.miner_partition_expirations
ADD CONSTRAINT exps_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.miner_partition_expirations
ADD CONSTRAINT exps_height_state_root_cid_m_actor_id_dl_index_p_num_v0ps_fkey
FOREIGN KEY (height, state_root_cid, miner_actor_id, deadline_index, partition_number)
REFERENCES filecoin.miner_v0partitions (height, state_root_cid, miner_actor_id, deadline_index, partition_number);

ALTER TABLE filecoin.multisig_actor_state
ADD CONSTRAINT msig_state_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.multisig_actor_state
ADD CONSTRAINT msig_state_height_pending_txs_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, pending_txs_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.multisig_actor_state
ADD CONSTRAINT msig_state_height_state_root_cid_msig_actor_id_actors_fkey
FOREIGN KEY (height, state_root_cid, multisig_actor_id)
REFERENCES filecoin.actors (height, state_root_cid, id);

ALTER TABLE filecoin.multisig_pending_txs
ADD CONSTRAINT msig_pending_txs_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.multisig_pending_txs
ADD CONSTRAINT msig_p_txs_height_state_root_cid_msig_actor_id_msig_state_fkey
FOREIGN KEY (height, state_root_cid, multisig_actor_id)
REFERENCES filecoin.multisig_actor_state (height, state_root_cid, multisig_actor_id);

ALTER TABLE filecoin.payment_channel_actor_state
ADD CONSTRAINT pay_chan_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.payment_channel_actor_state
ADD CONSTRAINT pay_chan_height_lane_states_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, lane_states_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.payment_channel_actor_state
ADD CONSTRAINT pay_chan_height_state_root_cid_pay_chan_actor_id_actors_fkey
FOREIGN KEY (height, state_root_cid, payment_channel_actor_id)
REFERENCES filecoin.actors (height, state_root_cid, id);

ALTER TABLE filecoin.payment_channel_lane_states
ADD CONSTRAINT pay_lanes_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.payment_channel_lane_states
ADD CONSTRAINT pay_lanes_height_state_root_cid_pay_chan_actor_id_pay_chan_fkey
FOREIGN KEY (height, state_root_cid, payment_channel_actor_id)
REFERENCES filecoin.payment_channel_actor_state (height, state_root_cid, payment_channel_actor_id);

ALTER TABLE filecoin.storage_power_actor_v0state
ADD CONSTRAINT power_v0state_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_actor_v0state
ADD CONSTRAINT power_v0state_height_cron_event_queue_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, cron_event_queue_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_actor_v0state
ADD CONSTRAINT power_v0state_height_claims_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, claims_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_actor_v0state
ADD CONSTRAINT power_v0state_height_proof_val_batch_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, proof_validation_batch_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_actor_v0state
ADD CONSTRAINT power_v0state_height_state_root_cid_s_pow_actor_id_actors_fkey
FOREIGN KEY (height, state_root_cid, storage_power_actor_id)
REFERENCES filecoin.actors (height, state_root_cid, id);

ALTER TABLE filecoin.storage_power_actor_v2state
ADD CONSTRAINT power_v2state_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_actor_v2state
ADD CONSTRAINT power_v2state_height_cron_event_queue_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, cron_event_queue_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_actor_v2state
ADD CONSTRAINT power_v2state_height_claims_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, claims_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_actor_v2state
ADD CONSTRAINT power_v2state_height_proof_val_batch_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, proof_validation_batch_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_actor_v2state
ADD CONSTRAINT power_v2state_height_state_root_cid_s_pow_actor_id_actors_fkey
FOREIGN KEY (height, state_root_cid, storage_power_actor_id)
REFERENCES filecoin.actors (height, state_root_cid, id);

ALTER TABLE filecoin.storage_power_cron_event_buckets
ADD CONSTRAINT cron_buckets_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_cron_event_buckets
ADD CONSTRAINT cron_bs_height_state_root_cid_s_pow_actor_id_pow_v0state_fkey
FOREIGN KEY (height, state_root_cid, storage_power_actor_id)
REFERENCES filecoin.storage_power_actor_v0state (height, state_root_cid, storage_power_actor_id);

ALTER TABLE filecoin.storage_power_cron_events
ADD CONSTRAINT cron_events_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_cron_events
ADD CONSTRAINT cron_es_height_state_root_cid_s_pow_actor_id_epoch_cron_bs_fkey
FOREIGN KEY (height, state_root_cid, storage_power_actor_id, epoch)
REFERENCES filecoin.storage_power_cron_event_buckets (height, state_root_cid, storage_power_actor_id, epoch);

ALTER TABLE filecoin.storage_power_v0claims
ADD CONSTRAINT pow_v0claims_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_v0claims
ADD CONSTRAINT pow_v0cs_height_state_root_cid_s_pow_actor_id_pow_v0state_fkey
FOREIGN KEY (height, state_root_cid, storage_power_actor_id)
REFERENCES filecoin.storage_power_actor_v0state (height, state_root_cid, storage_power_actor_id);

ALTER TABLE filecoin.storage_power_v2claims
ADD CONSTRAINT pow_v2claims_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_v2claims
ADD CONSTRAINT pow_v2cs_height_state_root_cid_s_pow_actor_id_pow_v2state_fkey
FOREIGN KEY (height, state_root_cid, storage_power_actor_id)
REFERENCES filecoin.storage_power_actor_v2state (height, state_root_cid, storage_power_actor_id);

ALTER TABLE filecoin.storage_power_proof_validation_buckets
ADD CONSTRAINT proof_buckets_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_proof_validation_buckets
ADD CONSTRAINT proof_bs_height_state_root_cid_s_pow_actor_id_pow_state_fkey
FOREIGN KEY (height, state_root_cid, storage_power_actor_id)
REFERENCES filecoin.storage_power_actor_v0state (height, state_root_cid, storage_power_actor_id);

ALTER TABLE filecoin.storage_power_proof_seal_verify_infos
ADD CONSTRAINT proofs_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_proof_seal_verify_infos
ADD CONSTRAINT proofs_height_sealed_cid_ipld_blocks_fkey
FOREIGN KEY (height, sealed_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_proof_seal_verify_infos
ADD CONSTRAINT proofs_height_unsealed_cid_ipld_blocks_fkey
FOREIGN KEY (height, unsealed_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.storage_power_proof_seal_verify_infos
ADD CONSTRAINT proofs_height_state_root_cid_s_pow_actor_id_addr_proof_bs_fkey
FOREIGN KEY (height, state_root_cid, storage_power_actor_id, address)
REFERENCES filecoin.storage_power_proof_validation_buckets (height, state_root_cid, storage_power_actor_id, address);

ALTER TABLE filecoin.verified_registry_actor_state
ADD CONSTRAINT ver_reg_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.verified_registry_actor_state
ADD CONSTRAINT ver_reg_height_verifiers_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, verifiers_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.verified_registry_actor_state
ADD CONSTRAINT ver_reg_height_verified_clients_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, verified_clients_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.verified_registry_actor_state
ADD CONSTRAINT ver_reg_height_state_root_cid_ver_reg_actor_id_actors_fkey
FOREIGN KEY (height, state_root_cid, verified_registry_actor_id)
REFERENCES filecoin.actors (height, state_root_cid, id);

ALTER TABLE filecoin.verified_registry_verifiers
ADD CONSTRAINT verifiers_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.verified_registry_verifiers
ADD CONSTRAINT verifiers_height_state_root_cid_ver_reg_actor_id_ver_reg_fkey
FOREIGN KEY (height, state_root_cid, verified_registry_actor_id)
REFERENCES filecoin.verified_registry_actor_state (height, state_root_cid, verified_registry_actor_id);

ALTER TABLE filecoin.verified_registry_clients
ADD CONSTRAINT reg_clients_height_state_root_cid_ipld_blocks_fkey
FOREIGN KEY (height, state_root_cid)
REFERENCES ipld.blocks (height, key);

ALTER TABLE filecoin.verified_registry_clients
ADD CONSTRAINT reg_clients_height_state_root_cid_ver_reg_actor_id_ver_reg_fkey
FOREIGN KEY (height, state_root_cid, verified_registry_actor_id)
REFERENCES filecoin.verified_registry_actor_state (height, state_root_cid, verified_registry_actor_id);

-- +goose Down
-- rich actor state tables
ALTER TABLE filecoin.verified_registry_clients
DROP CONSTRAINT reg_clients_height_state_root_cid_ver_reg_actor_id_ver_reg_fkey;

ALTER TABLE filecoin.verified_registry_clients
DROP CONSTRAINT reg_clients_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.verified_registry_verifiers
DROP CONSTRAINT verifiers_height_state_root_cid_ver_reg_actor_id_ver_reg_fkey;

ALTER TABLE filecoin.verified_registry_verifiers
DROP CONSTRAINT verifiers_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.verified_registry_actor_state
DROP CONSTRAINT ver_reg_height_state_root_cid_ver_reg_actor_id_actors_fkey;

ALTER TABLE filecoin.verified_registry_actor_state
DROP CONSTRAINT ver_reg_height_verified_clients_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.verified_registry_actor_state
DROP CONSTRAINT ver_reg_height_verifiers_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.verified_registry_actor_state
DROP CONSTRAINT ver_reg_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_proof_seal_verify_infos
DROP CONSTRAINT proofs_height_state_root_cid_s_pow_actor_id_addr_proof_bs_fkey;

ALTER TABLE filecoin.storage_power_proof_seal_verify_infos
DROP CONSTRAINT proofs_height_unsealed_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_proof_seal_verify_infos
DROP CONSTRAINT proofs_height_sealed_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_proof_seal_verify_infos
DROP CONSTRAINT proofs_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_proof_validation_buckets
DROP CONSTRAINT proof_bs_height_state_root_cid_s_pow_actor_id_pow_state_fkey;

ALTER TABLE filecoin.storage_power_proof_validation_buckets
DROP CONSTRAINT proof_buckets_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_v2claims
DROP CONSTRAINT pow_v2cs_height_state_root_cid_s_pow_actor_id_pow_v2state_fkey;

ALTER TABLE filecoin.storage_power_v2claims
DROP CONSTRAINT pow_v2claims_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_v0claims
DROP CONSTRAINT pow_v0cs_height_state_root_cid_s_pow_actor_id_pow_v0state_fkey;

ALTER TABLE filecoin.storage_power_v0claims
DROP CONSTRAINT pow_v0claims_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_cron_events
DROP CONSTRAINT cron_es_height_state_root_cid_s_pow_actor_id_epoch_cron_bs_fkey;

ALTER TABLE filecoin.storage_power_cron_events
DROP CONSTRAINT cron_events_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_cron_event_buckets
DROP CONSTRAINT cron_bs_height_state_root_cid_s_pow_actor_id_pow_v0state_fkey;

ALTER TABLE filecoin.storage_power_cron_event_buckets
DROP CONSTRAINT cron_buckets_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_actor_v2state
DROP CONSTRAINT power_v2state_height_state_root_cid_s_pow_actor_id_actors_fkey;

ALTER TABLE filecoin.storage_power_actor_v2state
DROP CONSTRAINT power_v2state_height_proof_val_batch_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_actor_v2state
DROP CONSTRAINT power_v2state_height_claims_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_actor_v2state
DROP CONSTRAINT power_v2state_height_cron_event_queue_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_actor_v2state
DROP CONSTRAINT power_v2state_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_actor_v0state
DROP CONSTRAINT power_v0state_height_state_root_cid_s_pow_actor_id_actors_fkey;

ALTER TABLE filecoin.storage_power_actor_v0state
DROP CONSTRAINT power_v0state_height_proof_val_batch_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_actor_v0state
DROP CONSTRAINT power_v0state_height_claims_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_actor_v0state
DROP CONSTRAINT power_v0state_height_cron_event_queue_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_power_actor_v0state
DROP CONSTRAINT power_v0state_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.payment_channel_lane_states
DROP CONSTRAINT pay_lanes_height_state_root_cid_pay_chan_actor_id_pay_chan_fkey;

ALTER TABLE filecoin.payment_channel_lane_states
DROP CONSTRAINT pay_lanes_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.payment_channel_actor_state
DROP CONSTRAINT pay_chan_height_state_root_cid_pay_chan_actor_id_actors_fkey;

ALTER TABLE filecoin.payment_channel_actor_state
DROP CONSTRAINT pay_chan_height_lane_states_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.payment_channel_actor_state
DROP CONSTRAINT pay_chan_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.multisig_pending_txs
DROP CONSTRAINT msig_p_txs_height_state_root_cid_msig_actor_id_msig_state_fkey;

ALTER TABLE filecoin.multisig_pending_txs
DROP CONSTRAINT msig_pending_txs_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.multisig_actor_state
DROP CONSTRAINT msig_state_height_state_root_cid_msig_actor_id_actors_fkey;

ALTER TABLE filecoin.multisig_actor_state
DROP CONSTRAINT msig_state_height_pending_txs_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.multisig_actor_state
DROP CONSTRAINT msig_state_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_partition_expirations
DROP CONSTRAINT exps_height_state_root_cid_m_actor_id_dl_index_p_num_v0ps_fkey;

ALTER TABLE filecoin.miner_partition_expirations
DROP CONSTRAINT exps_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v2partitions
DROP CONSTRAINT m_v2parts_height_state_root_cid_m_actor_id_dl_index_v2dls_fkey;

ALTER TABLE filecoin.miner_v2partitions
DROP CONSTRAINT miner_v2parts_height_early_term_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v2partitions
DROP CONSTRAINT miner_v2parts_height_exp_epochs_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v2partitions
DROP CONSTRAINT miner_v2parts_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v0partitions
DROP CONSTRAINT m_v0parts_height_state_root_cid_m_actor_id_dl_index_v0dls_fkey;

ALTER TABLE filecoin.miner_v0partitions
DROP CONSTRAINT miner_v0parts_height_early_term_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v0partitions
DROP CONSTRAINT miner_v0parts_height_exp_epochs_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v0partitions
DROP CONSTRAINT miner_v0parts_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v2sector_infos
DROP CONSTRAINT m_v2sec_infos_height_state_root_cid_miner_actor_id_v2state_fkey;

ALTER TABLE filecoin.miner_v2sector_infos
DROP CONSTRAINT m_v2sec_infos_height_sealed_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v2sector_infos
DROP CONSTRAINT m_v2sec_infos_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v0sector_infos
DROP CONSTRAINT m_v0sec_infos_height_state_root_cid_miner_actor_id_v0state_fkey;

ALTER TABLE filecoin.miner_v0sector_infos
DROP CONSTRAINT m_v0sec_infos_height_sealed_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v0sector_infos
DROP CONSTRAINT m_v0sec_infos_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_pre_committed_sector_infos
DROP CONSTRAINT pre_sec_infos_height_state_root_cid_miner_actor_id_v0state_fkey;

ALTER TABLE filecoin.miner_pre_committed_sector_infos
DROP CONSTRAINT pre_sec_infos_height_sealed_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_pre_committed_sector_infos
DROP CONSTRAINT pre_sec_infos_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v2deadlines
DROP CONSTRAINT miner_v2dls_height_state_root_cid_miner_actor_id_v2state_fkey;

ALTER TABLE filecoin.miner_v2deadlines
DROP CONSTRAINT miner_v2deadlines_height_exp_epochs_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v2deadlines
DROP CONSTRAINT miner_v2deadlines_height_partitions_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v2deadlines
DROP CONSTRAINT miner_v2deadlines_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v0deadlines
DROP CONSTRAINT miner_v0dls_height_state_root_cid_miner_actor_id_v0state_fkey;

ALTER TABLE filecoin.miner_v0deadlines
DROP CONSTRAINT miner_v0deadlines_height_exp_epochs_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v0deadlines
DROP CONSTRAINT miner_v0deadlines_height_partitions_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v0deadlines
DROP CONSTRAINT miner_v0deadlines_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_vesting_funds
DROP CONSTRAINT vesting_funds_height_state_root_cid_miner_actor_id_v0state_fkey;

ALTER TABLE filecoin.miner_vesting_funds
DROP CONSTRAINT vesting_funds_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v2infos
DROP CONSTRAINT miner_v2infos_height_state_root_cid_miner_actor_id_v2state_fkey;

ALTER TABLE filecoin.miner_v2infos
DROP CONSTRAINT miner_v2infos_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_v0infos
DROP CONSTRAINT miner_v0infos_height_state_root_cid_miner_actor_id_v0state_fkey;

ALTER TABLE filecoin.miner_v0infos
DROP CONSTRAINT miner_v0infos_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_actor_v2state
DROP CONSTRAINT miner_v2state_height_state_root_cid_miner_actor_id_actors_fkey;

ALTER TABLE filecoin.miner_actor_v2state
DROP CONSTRAINT miner_v2state_height_deadlines_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_actor_v2state
DROP CONSTRAINT miner_v2state_height_sectors_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_actor_v2state
DROP CONSTRAINT miner_v2state_height_allocated_sectors_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_actor_v2state
DROP CONSTRAINT miner_v2state_height_pre_com_sec_exp_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_actor_v2state
DROP CONSTRAINT miner_v2state_height_pre_com_sec_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_actor_v2state
DROP CONSTRAINT miner_v2state_height_vesting_funds_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_actor_v2state
DROP CONSTRAINT miner_v2state_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_actor_v0state
DROP CONSTRAINT miner_v0state_height_state_root_cid_miner_actor_id_actors_fkey;

ALTER TABLE filecoin.miner_actor_v0state
DROP CONSTRAINT miner_v0state_height_deadlines_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_actor_v0state
DROP CONSTRAINT miner_v0state_height_sectors_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_actor_v0state
DROP CONSTRAINT miner_v0state_height_allocated_sectors_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_actor_v0state
DROP CONSTRAINT miner_v0state_height_pre_com_sec_exp_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_actor_v0state
DROP CONSTRAINT miner_v0state_height_pre_com_sec_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_actor_v0state
DROP CONSTRAINT miner_v0state_height_vesting_funds_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.miner_actor_v0state
DROP CONSTRAINT miner_v0state_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_deal_ops_at_epoch
DROP CONSTRAINT ops_height_state_root_cid_storage_actor_id_epoch_deal_bkts_fkey;

ALTER TABLE filecoin.storage_actor_deal_ops_at_epoch
DROP CONSTRAINT ops_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_deal_ops_buckets
DROP CONSTRAINT deal_bkts_height_state_root_cid_storage_actor_id_storage_fkey;

ALTER TABLE filecoin.storage_actor_deal_ops_buckets
DROP CONSTRAINT deal_buckets_height_deals_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_deal_ops_buckets
DROP CONSTRAINT deal_buckets_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_locked_tokens
DROP CONSTRAINT locked_tkns_height_state_root_cid_storage_actor_id_storage_fkey;

ALTER TABLE filecoin.storage_actor_locked_tokens
DROP CONSTRAINT locked_tokens_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_escrows
DROP CONSTRAINT escrows_height_state_root_cid_storage_actor_id_storage_fkey;

ALTER TABLE filecoin.storage_actor_escrows
DROP CONSTRAINT escrows_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_pending_proposals
DROP CONSTRAINT pnd_props_height_state_root_cid_storage_actor_id_storage_fkey;

ALTER TABLE filecoin.storage_actor_pending_proposals
DROP CONSTRAINT pending_props_height_piece_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_pending_proposals
DROP CONSTRAINT pending_props_height_deal_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_pending_proposals
DROP CONSTRAINT pending_props_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_deal_states
DROP CONSTRAINT deal_states_height_state_root_cid_storage_actor_id_storage_fkey;

ALTER TABLE filecoin.storage_actor_deal_states
DROP CONSTRAINT deal_states_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_deal_proposals
DROP CONSTRAINT deal_props_height_state_root_cid_storage_actor_id_storage_fkey;

ALTER TABLE filecoin.storage_actor_deal_proposals
DROP CONSTRAINT deal_props_height_piece_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_deal_proposals
DROP CONSTRAINT deal_props_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_state
DROP CONSTRAINT storage_height_state_root_cid_storage_actor_id_actors_fkey;

ALTER TABLE filecoin.storage_actor_state
DROP CONSTRAINT storage_height_deal_ops_by_epoch_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_state
DROP CONSTRAINT storage_height_locked_tokens_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_state
DROP CONSTRAINT storage_height_escrows_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_state
DROP CONSTRAINT storage_height_pending_proposals_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_state
DROP CONSTRAINT storage_height_deal_states_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_state
DROP CONSTRAINT storage_height_proposals_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.storage_actor_state
DROP CONSTRAINT storage_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.reward_actor_v2state
    DROP CONSTRAINT reward_v2state_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.reward_actor_v0state
    DROP CONSTRAINT rwrd_v0state_height_state_root_cid_reward_actor_id_actors_fkey;

ALTER TABLE filecoin.account_actor_addresses
DROP CONSTRAINT addresses_height_state_root_cid_account_actor_id_actors_fkey;

ALTER TABLE filecoin.account_actor_addresses
DROP CONSTRAINT addresses_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.reward_actor_v2state
DROP CONSTRAINT rwrd_v2state_height_state_root_cid_reward_actor_id_actors_fkey;

ALTER TABLE filecoin.reward_actor_v2state
DROP CONSTRAINT reward_v2state_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.reward_actor_v0state
DROP CONSTRAINT rwrd_v0state_height_state_root_cid_reward_actor_id_actors_fkey;

ALTER TABLE filecoin.reward_actor_v0state
DROP CONSTRAINT reward_v0state_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.cron_actor_method_receivers
DROP CONSTRAINT method_rcvrs_height_state_root_cid_cron_actor_id_actors_fkey;

ALTER TABLE filecoin.cron_actor_method_receivers
DROP CONSTRAINT method_receivers_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.init_actor_id_addresses
DROP CONSTRAINT id_addresses_height_state_root_cid_init_actor_id_actors_fkey;

ALTER TABLE filecoin.init_actor_id_addresses
DROP CONSTRAINT id_addresses_height_state_root_cid_ipld_blocks_fkey;

-- actor tables
ALTER TABLE filecoin.actor_events
DROP CONSTRAINT actor_events_height_block_cid_message_cid_block_messages_fkey;

ALTER TABLE filecoin.actor_events
DROP CONSTRAINT actor_events_height_message_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.actor_events
DROP CONSTRAINT actor_events_height_block_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.actor_states
DROP CONSTRAINT actor_states_height_state_root_cid_id_actors_fkey;

ALTER TABLE filecoin.actor_states
DROP CONSTRAINT actor_states_height_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.actors
DROP CONSTRAINT actors_height_state_root_cid_tip_sets_fkey;

ALTER TABLE filecoin.actors
DROP CONSTRAINT actors_height_head_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.actors
DROP CONSTRAINT actors_height_state_root_cid_ipld_blocks_fkey;

-- drand table
ALTER TABLE filecoin.drand_block_entries
DROP CONSTRAINT drand_height_block_cid_block_headers_fkey;

ALTER TABLE filecoin.drand_block_entries
DROP CONSTRAINT drand_height_block_cid_ipld_blocks_fkey;

-- receipts table
ALTER TABLE filecoin.receipts
DROP CONSTRAINT receipts_height_block_cid_message_cid_block_messages_fkey;

ALTER TABLE filecoin.receipts
DROP CONSTRAINT receipts_height_message_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.receipts
DROP CONSTRAINT receipts_height_block_cid_ipld_blocks_fkey;

-- messages tables
ALTER TABLE filecoin.vm_messages
DROP CONSTRAINT vm_msgs_height_block_cid_message_cid_block_messages_fkey;

ALTER TABLE filecoin.vm_messages
DROP CONSTRAINT vm_messages_height_message_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.vm_messages
DROP CONSTRAINT vm_messages_height_block_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.internal_parsed_messages
DROP CONSTRAINT int_parsed_messages_height_block_cid_message_cid_messages_fkey;

ALTER TABLE filecoin.internal_parsed_messages
DROP CONSTRAINT int_parsed_messages_height_message_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.internal_parsed_messages
DROP CONSTRAINT int_parsed_messages_height_block_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.internal_messages
DROP CONSTRAINT internal_msgs_height_block_cid_message_cid_block_messages_fkey;

ALTER TABLE filecoin.internal_messages
DROP CONSTRAINT internal_messages_height_message_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.internal_messages
DROP CONSTRAINT internal_messages_height_block_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.parsed_messages
DROP CONSTRAINT parsed_messages_height_block_cid_message_cid_messages_fkey;

ALTER TABLE filecoin.parsed_messages
DROP CONSTRAINT parsed_messages_height_message_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.parsed_messages
DROP CONSTRAINT parsed_messages_height_block_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.messages
DROP CONSTRAINT messages_height_block_cid_message_cid_block_messages_fkey;

ALTER TABLE filecoin.messages
DROP CONSTRAINT messages_height_message_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.messages
DROP CONSTRAINT messages_height_block_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.block_messages
DROP CONSTRAINT block_messages_height_block_cid_headers_fkey;

ALTER TABLE filecoin.block_messages
DROP CONSTRAINT block_messages_height_message_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.block_messages
DROP CONSTRAINT block_messages_height_block_cid_ipld_blocks_fkey;

-- block headers tables
ALTER TABLE filecoin.block_parents
DROP CONSTRAINT parents_height_parent_cid_block_headers_fkey;

ALTER TABLE filecoin.block_parents
DROP CONSTRAINT parents_height_block_cid_block_headers_fkey;

ALTER TABLE filecoin.block_parents
DROP CONSTRAINT parents_height_parent_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.block_parents
DROP CONSTRAINT parents_height_block_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.block_headers
DROP CONSTRAINT headers_height_parent_tip_set_key_cid_tip_sets_fkey;

ALTER TABLE filecoin.block_headers
DROP CONSTRAINT headers_height_messages_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.block_headers
DROP CONSTRAINT headers_height_parent_message_rcts_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.block_headers
DROP CONSTRAINT headers_height_parent_tip_set_key_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.block_headers
DROP CONSTRAINT headers_height_parent_state_root_cid_ipld_blocks_fkey;

-- tip set tables
ALTER TABLE filecoin.tip_set_members
DROP CONSTRAINT tip_set_members_height_parent_tip_set_key_cid_tip_sets_fkey;

ALTER TABLE filecoin.tip_set_members
DROP CONSTRAINT tip_set_members_height_block_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.tip_set_members
DROP CONSTRAINT tip_set_members_height_parent_tip_set_key_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.tip_sets
DROP CONSTRAINT tip_sets_height_parent_state_root_cid_ipld_blocks_fkey;

ALTER TABLE filecoin.tip_sets
DROP CONSTRAINT tip_sets_height_parent_tip_set_key_cid_ipld_blocks_fkey;

-- ipld blockstore table
ALTER TABLE ipld.blocks
DROP CONSTRAINT blocks_key_filecoin_cids_fkey;

