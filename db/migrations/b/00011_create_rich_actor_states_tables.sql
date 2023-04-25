-- +goose Up
-- maps m-to-1 to an actors entry
CREATE TABLE IF NOT EXISTS filecoin.init_actor_id_addresses (
    height          BIGINT NOT NULL,
    state_root_cid  TEXT NOT NULL,
    init_actor_id   TEXT NOT NULL,
    address         TEXT NOT NULL,
    id              TEXT NOT NULL,
    selector_suffix INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, init_actor_id, address)
);

-- maps m-to-1 to an actors entry
CREATE TABLE IF NOT EXISTS filecoin.cron_actor_method_receivers (
    height          BIGINT NOT NULL,
    state_root_cid  TEXT NOT NULL,
    cron_actor_id   TEXT NOT NULL,
    index           INT NOT NULL,
    receiver        TEXT NOT NULL,
    method_num      INT NOT NULL,
    PRIMARY KEY (height, state_root_cid, cron_actor_id, receiver, index)
);

-- maps 1-to-1 to an actors entry
CREATE TABLE IF NOT EXISTS filecoin.reward_actor_v0state (
    height                    BIGINT NOT NULL,
    state_root_cid            TEXT NOT NULL,
    reward_actor_id           TEXT NOT NULL,
    cumsum_baseline           NUMERIC NOT NULL,
    cumsum_realized           NUMERIC NOT NULL,
    effective_network_time    BIGINT NOT NULL,
    effective_baseline_power  NUMERIC NOT NULL,
    this_epoch_reward         NUMERIC NOT NULL,
    position_estimate         NUMERIC,
    velocity_estimate         NUMERIC,
    this_epoch_baseline_power NUMERIC NOT NULL,
    total_mined               NUMERIC NOT NULL,
    PRIMARY KEY (height, state_root_cid, reward_actor_id)
);

-- maps 1-to-1 to an actors entry
CREATE TABLE IF NOT EXISTS filecoin.reward_actor_v2state (
    height                     BIGINT NOT NULL,
    state_root_cid             TEXT NOT NULL,
    reward_actor_id            TEXT NOT NULL,
    cumsum_baseline            NUMERIC NOT NULL,
    cumsum_realized            NUMERIC NOT NULL,
    effective_network_time     BIGINT NOT NULL,
    effective_baseline_power   NUMERIC NOT NULL,
    this_epoch_reward          NUMERIC NOT NULL,
    position_estimate          NUMERIC,
    velocity_estimate          NUMERIC,
    this_epoch_baseline_power  NUMERIC NOT NULL,
    total_storage_power_reward NUMERIC NOT NULL,
    simple_total               NUMERIC NOT NULL,
    baseline_total             NUMERIC NOT NULL,
    PRIMARY KEY (height, state_root_cid, reward_actor_id)
);

-- maps 1-to-1 to an actors entry
CREATE TABLE IF NOT EXISTS filecoin.account_actor_addresses (
    height           BIGINT NOT NULL,
    state_root_cid   TEXT NOT NULL,
    account_actor_id TEXT NOT NULL,
    address          TEXT NOT NULL,
    PRIMARY KEY (height, state_root_cid, account_actor_id)
);

-- maps 1-to-1 to an actors entry
-- TODO: are there multiple storage market actors or is there only one?
-- determines whether or not child tables need to include storage_actor_id to reference this table
CREATE TABLE IF NOT EXISTS filecoin.storage_actor_state (
    height                           BIGINT NOT NULL,
    state_root_cid                   TEXT NOT NULL,
    storage_actor_id                 TEXT NOT NULL,
    proposals_root_cid               TEXT NOT NULL,
    deal_states_root_cid             TEXT NOT NULL,
    pending_proposals_root_cid       TEXT NOT NULL,
    escrows_root_cid                 TEXT NOT NULL,
    locked_tokens_root_cid           TEXT NOT NULL,
    next_deal_id                     BIGINT NOT NULL,
    deal_ops_by_epoch_root_cid       TEXT NOT NULL,
    last_cron                        BIGINT NOT NULL,
    total_client_locked_collateral   NUMERIC NOT NULL,
    total_provider_locked_collateral NUMERIC NOT NULL,
    total_client_storage_fee         NUMERIC NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_actor_id)
);

-- maps m-to-1 to a storage_actor_state entry
CREATE TABLE IF NOT EXISTS filecoin.storage_actor_deal_proposals (
    height                  BIGINT NOT NULL,
    state_root_cid          TEXT NOT NULL,
    storage_actor_id        TEXT NOT NULL,
    deal_id                 BIGINT NOT NULL,
    piece_cid               TEXT NOT NULL,
    padded_piece_size       BIGINT NOT NULL,
    unpadded_piece_size     BIGINT NOT NULL,
    is_verified             BOOLEAN NOT NULL,
    client_id               TEXT NOT NULL,
    provider_id             TEXT NOT NULL,
    start_epoch             BIGINT NOT NULL,
    end_epoch               BIGINT NOT NULL,
    storage_price_per_epoch NUMERIC NOT NULL,
    provider_collateral     NUMERIC NOT NULL,
    client_collateral       NUMERIC NOT NULL,
    label                   TEXT,
    selector_suffix         INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_actor_id, deal_id)
);

-- maps m-to-1 to a storage_actor_state entry
CREATE TABLE IF NOT EXISTS filecoin.storage_actor_deal_states (
    height                  BIGINT NOT NULL,
    state_root_cid          TEXT NOT NULL,
    storage_actor_id        TEXT NOT NULL,
    deal_id                 BIGINT NOT NULL,
    sector_start_epoch      NUMERIC NOT NULL, -- -1 if not yet included
    last_updated_epoch      NUMERIC NOT NULL, -- -1 if never updated
    slash_epoch             NUMERIC NOT NULL, -- -1 if never slashed
    selector_suffix         INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_actor_id, deal_id)
);

-- maps m-to-1 to a storage_actor_state entry
CREATE TABLE IF NOT EXISTS filecoin.storage_actor_pending_proposals (
    height                  BIGINT NOT NULL,
    state_root_cid          TEXT NOT NULL,
    storage_actor_id        TEXT NOT NULL,
    deal_cid                TEXT NOT NULL,
    piece_cid               TEXT NOT NULL,
    padded_piece_size       BIGINT NOT NULL,
    unpadded_piece_size     BIGINT NOT NULL,
    is_verified             BOOLEAN NOT NULL,
    client_id               TEXT NOT NULL,
    provider_id             TEXT NOT NULL,
    start_epoch             BIGINT NOT NULL,
    end_epoch               BIGINT NOT NULL,
    storage_price_per_epoch NUMERIC NOT NULL,
    provider_collateral     NUMERIC NOT NULL,
    client_collateral       NUMERIC NOT NULL,
    label                   TEXT,
    selector_suffix         INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_actor_id, deal_cid)
);

-- maps m-to-1 to a storage_actor_state entry
CREATE TABLE IF NOT EXISTS filecoin.storage_actor_escrows (
    height                  BIGINT NOT NULL,
    state_root_cid          TEXT NOT NULL,
    storage_actor_id        TEXT NOT NULL,
    address                 TEXT NOT NULL,
    value                   NUMERIC NOT NULL,
    selector_suffix         INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_actor_id, address)
);

-- maps m-to-1 to a storage_actor_state entry
CREATE TABLE IF NOT EXISTS filecoin.storage_actor_locked_tokens (
    height                  BIGINT NOT NULL,
    state_root_cid          TEXT NOT NULL,
    storage_actor_id        TEXT NOT NULL,
    address                 TEXT NOT NULL,
    value                   NUMERIC NOT NULL,
    selector_suffix         INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_actor_id, address)
);

-- maps m-to-1 to a storage_actor_state entry
CREATE TABLE IF NOT EXISTS filecoin.storage_actor_deal_ops_buckets (
    height                  BIGINT NOT NULL,
    state_root_cid          TEXT NOT NULL,
    storage_actor_id        TEXT NOT NULL,
    epoch                   BIGINT NOT NULL,
    deals_root_cid          TEXT NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_actor_id, epoch)
);

-- maps m-to-1 to a storage_actor_deal_ops_buckets entry
CREATE TABLE IF NOT EXISTS filecoin.storage_actor_deal_ops_at_epoch (
    height                  BIGINT NOT NULL,
    state_root_cid          TEXT NOT NULL,
    storage_actor_id        TEXT NOT NULL,
    epoch                   BIGINT NOT NULL,
    deal_id                 BIGINT NOT NULL,
    selector_suffix         INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_actor_id, epoch, deal_id)
);

-- maps to 1-to-1 to an actors entry
CREATE TABLE IF NOT EXISTS filecoin.miner_actor_v0state (
   height                                 BIGINT NOT NULL,
   state_root_cid                         TEXT NOT NULL,
   miner_actor_id                         TEXT NOT NULL,
   pre_commit_deposits                    NUMERIC NOT NULL,
   locked_funds                           NUMERIC NOT NULL,
   vesting_funds_cid                      TEXT NOT NULL,
   initial_pledge                         NUMERIC NOT NULL,
   pre_committed_sectors_root_cid         TEXT NOT NULL,
   pre_committed_sectors_expiry_root_cid  TEXT NOT NULL,
   allocated_sectors_cid                  TEXT NOT NULL,
   sectors_root_cid                       TEXT NOT NULL,
   proving_period_start                   NUMERIC NOT NULL,
   current_deadline                       BIGINT NOT NULL,
   deadlines_cid                          TEXT NOT NULL,
   early_terminations                     BYTEA NOT NULL,
   PRIMARY KEY (height, state_root_cid, miner_actor_id)
);

-- maps to 1-to-1 to an actors entry
CREATE TABLE IF NOT EXISTS filecoin.miner_actor_v2state (
    height                                 BIGINT NOT NULL,
    state_root_cid                         TEXT NOT NULL,
    miner_actor_id                         TEXT NOT NULL,
    pre_commit_deposits                    NUMERIC NOT NULL,
    locked_funds                           NUMERIC NOT NULL,
    vesting_funds_cid                      TEXT NOT NULL,
    initial_pledge                         NUMERIC NOT NULL,
    pre_committed_sectors_root_cid         TEXT NOT NULL,
    pre_committed_sectors_expiry_root_cid  TEXT NOT NULL,
    allocated_sectors_cid                  TEXT NOT NULL,
    sectors_root_cid                       TEXT NOT NULL,
    proving_period_start                   NUMERIC NOT NULL,
    current_deadline                       BIGINT NOT NULL,
    deadlines_cid                          TEXT NOT NULL,
    early_terminations                     BYTEA NOT NULL,
    PRIMARY KEY (height, state_root_cid, miner_actor_id)
);

-- maps 1-to-1 to a miner_actor_v0state entry
-- keeping this separate for now as we might just drop this table and rely only on the CID link in miner_actor_v0state
CREATE TABLE IF NOT EXISTS filecoin.miner_v0infos (
    height                    BIGINT NOT NULL,
    state_root_cid            TEXT NOT NULL,
    miner_actor_id            TEXT NOT NULL,
    owner_id                  TEXT NOT NULL,
    worker_id                 TEXT NOT NULL,
    peer_id                   TEXT,
    control_addresses         JSONB,
    new_worker                TEXT,
    new_worker_start_epoch    BIGINT,
    multi_addresses           JSONB,
    seal_proof_type           INT NOT NULL,
    sector_size               BIGINT NOT NULL,
    PRIMARY KEY (height, state_root_cid, miner_actor_id)
);

-- maps 1-to-1 to a miner_actor_v2state entry
CREATE TABLE IF NOT EXISTS filecoin.miner_v2infos (
    height                    BIGINT NOT NULL,
    state_root_cid            TEXT NOT NULL,
    miner_actor_id            TEXT NOT NULL,
    owner_id                  TEXT NOT NULL,
    worker_id                 TEXT NOT NULL,
    peer_id                   TEXT,
    control_addresses         JSONB,
    new_worker                TEXT,
    new_worker_start_epoch    BIGINT,
    multi_addresses           JSONB,
    seal_proof_type           INT NOT NULL,
    sector_size               BIGINT NOT NULL,
    consensus_faulted_elapsed BIGINT NOT NULL,
    pending_owner             TEXT,
    PRIMARY KEY (height, state_root_cid, miner_actor_id)
);

-- maps m-to-1 to a miner_actor_v0state or miner_actor_v2state
CREATE TABLE IF NOT EXISTS filecoin.miner_vesting_funds (
    height                    BIGINT NOT NULL,
    state_root_cid            TEXT NOT NULL,
    miner_actor_id            TEXT NOT NULL,
    vests_at                  BIGINT NOT NULL,
    amount                    NUMERIC NOT NULL,
    PRIMARY KEY (height, state_root_cid, miner_actor_id, vests_at)
);

-- maps m-to-1 to a miner_actor_v0state entry
CREATE TABLE IF NOT EXISTS filecoin.miner_v0deadlines (
    height                     BIGINT NOT NULL,
    state_root_cid             TEXT NOT NULL,
    miner_actor_id             TEXT NOT NULL,
    index                      INT NOT NULL,
    partitions_root_cid        TEXT NOT NULL,
    expiration_epochs_root_cid TEXT NOT NULL,
    post_submissions           BYTEA NOT NULL,
    early_terminations         BYTEA NOT NULL,
    live_sectors               BIGINT NOT NULL,
    total_sectors              BIGINT NOT NULL,
    faulty_power_pair_raw      NUMERIC NOT NULL,
    faulty_power_pair_qa       NUMERIC NOT NULL,
    PRIMARY KEY (height, state_root_cid, miner_actor_id, index)
);

-- maps m-to-1 to a miner_actor_v2state entry
-- might be able to combine this with the above table, since the only difference is that the paritions are different
-- we can have the two different parition tables reference a single table for deadlines
-- if you are starting at a position in the DAG above this table you already know whether or not it is v0 or v2
CREATE TABLE IF NOT EXISTS filecoin.miner_v2deadlines (
    height                     BIGINT NOT NULL,
    state_root_cid             TEXT NOT NULL,
    miner_actor_id             TEXT NOT NULL,
    index                      INT NOT NULL,
    partitions_root_cid        TEXT NOT NULL,
    expiration_epochs_root_cid TEXT NOT NULL,
    post_submissions           BYTEA NOT NULL,
    early_terminations         BYTEA NOT NULL,
    live_sectors               BIGINT NOT NULL,
    total_sectors              BIGINT NOT NULL,
    faulty_power_pair_raw      NUMERIC NOT NULL,
    faulty_power_pair_qa       NUMERIC NOT NULL,
    PRIMARY KEY (height, state_root_cid, miner_actor_id, index)
);

-- maps m-to-1 to a miner_actor_v0state or miner_actor_v2state entry
CREATE TABLE IF NOT EXISTS filecoin.miner_pre_committed_sector_infos (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    miner_actor_id                  TEXT NOT NULL,
    sector_number                   BIGINT NOT NULL,
    pre_commit_deposit              NUMERIC NOT NULL,
    pre_commit_epoch                BIGINT NOT NULL,
    deal_weight                     NUMERIC NOT NULL,
    verified_deal_weight            NUMERIC NOT NULL,
    seal_proof                      BIGINT NOT NULL,
    sealed_cid                      TEXT NOT NULL,
    seal_rand_epoch                 BIGINT NOT NULL,
    deal_ids                        BIGINT[] NOT NULL,
    expiration_epoch                BIGINT NOT NULL,
    replace_capacity                BOOLEAN NOT NULL,
    replace_sector_deadline         BIGINT NOT NULL,
    replace_sector_partition_number BIGINT NOT NULL,
    replace_sector_number           BIGINT NOT NULL,
    selector_suffix                 INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, miner_actor_id, sector_number)
);

-- maps m-to-1 to a miner_actor_v0state entry
CREATE TABLE IF NOT EXISTS filecoin.miner_v0sector_infos (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    miner_actor_id                  TEXT NOT NULL,
    sector_number                   BIGINT NOT NULL,
    registered_seal_proof           BIGINT NOT NULL,
    sealed_cid                      TEXT NOT NULL,
    deal_ids                        BIGINT[] NOT NULL,
    activation_epoch                BIGINT NOT NULL,
    expiration_epoch                BIGINT NOT NULL,
    deal_weight                     NUMERIC NOT NULL,
    verified_deal_weight            NUMERIC NOT NULL,
    initial_pledge                  NUMERIC NOT NULL,
    expected_day_reward             NUMERIC NOT NULL,
    expected_storage_pledge         NUMERIC NOT NULL,
    selector_suffix                 INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, miner_actor_id, sector_number)
);

-- maps m-to-1 to a miner_actor_v2state entry
CREATE TABLE IF NOT EXISTS filecoin.miner_v2sector_infos (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    miner_actor_id                  TEXT NOT NULL,
    sector_number                   BIGINT NOT NULL,
    registered_seal_proof           BIGINT NOT NULL,
    sealed_cid                      TEXT NOT NULL,
    deal_ids                        BIGINT[] NOT NULL,
    activation_epoch                BIGINT NOT NULL,
    expiration_epoch                BIGINT NOT NULL,
    deal_weight                     NUMERIC NOT NULL,
    verified_deal_weight            NUMERIC NOT NULL,
    initial_pledge                  NUMERIC NOT NULL,
    expected_day_reward             NUMERIC NOT NULL,
    expected_storage_pledge         NUMERIC NOT NULL,
    replaced_sector_age             BIGINT NOT NULL,
    replaced_day_reward             NUMERIC NOT NULL,
    selector_suffix                 INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, miner_actor_id, sector_number)
);

-- maps m-to-1 to a miner_v0deadlines entry
CREATE TABLE IF NOT EXISTS filecoin.miner_v0partitions (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    miner_actor_id                  TEXT NOT NULL,
    deadline_index                  INT NOT NULL,
    partition_number                INT NOT NULL,
    sectors                         BYTEA NOT NULL,
    faults                          BYTEA NOT NULL,
    recoveries                      BYTEA NOT NULL,
    terminated                      BYTEA NOT NULL,
    expiration_epochs_root_cid      TEXT NOT NULL,
    early_terminated_root_cid       TEXT NOT NULL,
    live_power_pair_raw             NUMERIC NOT NULL,
    live_power_pair_qa              NUMERIC NOT NULL,
    faulty_power_pair_raw           NUMERIC NOT NULL,
    faulty_power_pair_qa            NUMERIC NOT NULL,
    recovering_power_pair_raw       NUMERIC NOT NULL,
    recovering_power_pair_qa        NUMERIC NOT NULL,
    selector_suffix                 INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, miner_actor_id, deadline_index, partition_number)
);

-- maps m-to-1 to a miner_v2deadlines entry
CREATE TABLE IF NOT EXISTS filecoin.miner_v2partitions (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    miner_actor_id                  TEXT NOT NULL,
    deadline_index                  INT NOT NULL,
    partition_number                INT NOT NULL,
    sectors                         BYTEA NOT NULL,
    faults                          BYTEA NOT NULL,
    unproven                        BYTEA NOT NULL,
    recoveries                      BYTEA NOT NULL,
    terminated                      BYTEA NOT NULL,
    expiration_epochs_root_cid      TEXT NOT NULL,
    early_terminated_root_cid       TEXT NOT NULL,
    live_power_pair_raw             NUMERIC NOT NULL,
    live_power_pair_qa              NUMERIC NOT NULL,
    unproven_power_pair_raw         NUMERIC NOT NULL,
    unproven_power_pair_qa          NUMERIC NOT NULL,
    faulty_power_pair_raw           NUMERIC NOT NULL,
    faulty_power_pair_qa            NUMERIC NOT NULL,
    recovering_power_pair_raw       NUMERIC NOT NULL,
    recovering_power_pair_qa        NUMERIC NOT NULL,
    selector_suffix                 INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, miner_actor_id, deadline_index, partition_number)
);

-- maps m-to-1 to a miner_v0partitions or miner_v2partitions entry
CREATE TABLE IF NOT EXISTS filecoin.miner_partition_expirations (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    miner_actor_id                  TEXT NOT NULL,
    deadline_index                  INT NOT NULL,
    partition_number                INT NOT NULL,
    epoch                           BIGINT NOT NULL,
    on_time_sectors                 BYTEA NOT NULL,
    early_sectors                   BYTEA NOT NULL,
    on_time_pledge                  NUMERIC NOT NULL,
    active_power_pair_raw           NUMERIC NOT NULL,
    active_power_pair_qa            NUMERIC NOT NULL,
    faulty_power_pair_raw           NUMERIC NOT NULL,
    faulty_power_pair_qa            NUMERIC NOT NULL,
    selector_suffix                 INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, miner_actor_id, deadline_index, partition_number, epoch)
);

-- maps 1-to-1 to an actors entry
CREATE TABLE IF NOT EXISTS filecoin.multisig_actor_state (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    multisig_actor_id               TEXT NOT NULL,
    signers                         TEXT[] NOT NULL,
    num_approvals_threshold         BIGINT NOT NULL,
    next_tx_id                      BIGINT NOT NULL,
    initial_balance                 NUMERIC NOT NULL,
    start_epoch                     BIGINT NOT NULL,
    unlock_duration                 BIGINT NOT NULL,
    pending_txs_root_cid            TEXT NOT NULL,
    PRIMARY KEY (height, state_root_cid, multisig_actor_id)
);

-- maps m-to-1 to a multisig_actor_state entry
CREATE TABLE IF NOT EXISTS filecoin.multisig_pending_txs (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    multisig_actor_id               TEXT NOT NULL,
    transaction_id                  BIGINT NOT NULL,
    "to"                            TEXT NOT NULL,
    value                           NUMERIC NOT NULL,
    params                          BYTEA NOT NULL,
    approved                        TEXT[] NOT NULL,
    selector_suffix                 INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, multisig_actor_id, transaction_id)
);

-- maps 1-to-1 to an actors entry
CREATE TABLE IF NOT EXISTS filecoin.payment_channel_actor_state (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    payment_channel_actor_id        TEXT NOT NULL,
    "from"                          TEXT NOT NULL,
    "to"                            TEXT NOT NULL,
    to_send                         NUMERIC NOT NULL,
    settling_at_epoch               BIGINT NOT NULL,
    min_settle_height               BIGINT NOT NULL,
    lane_states_root_cid            TEXT NOT NULL,
    PRIMARY KEY (height, state_root_cid, payment_channel_actor_id)
);

-- maps m-to-1 to a payment_channel_actor_state entry
CREATE TABLE IF NOT EXISTS filecoin.payment_channel_lane_states (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    payment_channel_actor_id        TEXT NOT NULL,
    lane_id                         INT NOT NULL,
    redeemed                        NUMERIC NOT NULL,
    nonce                           BIGINT NOT NULL,
    selector_suffix                 INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, payment_channel_actor_id, lane_id)
);

-- maps 1-to-1 to an actors entry
CREATE TABLE IF NOT EXISTS filecoin.storage_power_actor_v0state (
    height                           BIGINT NOT NULL,
    state_root_cid                   TEXT NOT NULL,
    storage_power_actor_id           TEXT NOT NULL,
    total_raw_byte_power             NUMERIC NOT NULL,
    total_bytes_committed            NUMERIC NOT NULL,
    total_quality_adj_power          NUMERIC NOT NULL,
    total_qa_bytes_committed         NUMERIC NOT NULL,
    total_pledge_collateral          NUMERIC NOT NULL,
    this_epoch_raw_byte_power        NUMERIC NOT NULL,
    this_epoch_quality_adj_power     NUMERIC NOT NULL,
    this_epoch_pledge_collateral     NUMERIC NOT NULL,
    this_epoch_qa_power_smoothed_pos NUMERIC,
    this_epoch_qa_power_smoothed_vel NUMERIC,
    miner_count                      INT NOT NULL,
    miner_above_min_number_count     INT NOT NULL,
    cron_event_queue_root_cid        TEXT NOT NULL,
    first_cron_epoch                 BIGINT NOT NULL,
    last_processed_cron_epoch        BIGINT NOT NULL,
    claims_root_cid                  TEXT NOT NULL,
    proof_validation_batch_root_cid  TEXT NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_power_actor_id)
);

-- maps 1-to-1 to an actors entry
CREATE TABLE IF NOT EXISTS filecoin.storage_power_actor_v2state (
    height                           BIGINT NOT NULL,
    state_root_cid                   TEXT NOT NULL,
    storage_power_actor_id           TEXT NOT NULL,
    total_raw_byte_power             NUMERIC NOT NULL,
    total_bytes_committed            NUMERIC NOT NULL,
    total_quality_adj_power          NUMERIC NOT NULL,
    total_qa_bytes_committed         NUMERIC NOT NULL,
    total_pledge_collateral          NUMERIC NOT NULL,
    this_epoch_raw_byte_power        NUMERIC NOT NULL,
    this_epoch_quality_adj_power     NUMERIC NOT NULL,
    this_epoch_pledge_collateral     NUMERIC NOT NULL,
    this_epoch_qa_power_smoothed_pos NUMERIC,
    this_epoch_qa_power_smoothed_vel NUMERIC,
    miner_count                      INT NOT NULL,
    miner_above_min_number_count     INT NOT NULL,
    cron_event_queue_root_cid        TEXT NOT NULL,
    first_cron_epoch                 BIGINT NOT NULL,
    claims_root_cid                  TEXT NOT NULL,
    proof_validation_batch_root_cid  TEXT,
    PRIMARY KEY (height, state_root_cid, storage_power_actor_id)
);

-- maps m-to-1 to a storage_power_actor_v0state or storage_power_actor_v2state entry
CREATE TABLE IF NOT EXISTS filecoin.storage_power_cron_event_buckets (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    storage_power_actor_id          TEXT NOT NULL,
    epoch                           BIGINT NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_power_actor_id, epoch)
);

-- maps m-to-1 to a storage_power_cron_event_buckets entry
CREATE TABLE IF NOT EXISTS filecoin.storage_power_cron_events (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    storage_power_actor_id          TEXT NOT NULL,
    epoch                           BIGINT NOT NULL,
    index                           INT NOT NULL,
    miner_address                   TEXT NOT NULL,
    callback_payload                BYTEA NOT NULL,
    selector_suffix                 INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_power_actor_id, epoch, index)
);

-- maps m-to-1 to a storage_power_actor_v0state entry
CREATE TABLE IF NOT EXISTS filecoin.storage_power_v0claims (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    storage_power_actor_id          TEXT NOT NULL,
    address                         TEXT NOT NULL,
    raw_byte_power                  NUMERIC NOT NULL,
    quality_adj_power               NUMERIC NOT NULL,
    selector_suffix                 INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_power_actor_id, address)
);

-- maps m-to-1 to a storage_power_actor_v2state entry
CREATE TABLE IF NOT EXISTS filecoin.storage_power_v2claims (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    storage_power_actor_id          TEXT NOT NULL,
    address                         TEXT NOT NULL,
    seal_proof_type                 INT NOT NULL,
    raw_byte_power                  NUMERIC NOT NULL,
    quality_adj_power               NUMERIC NOT NULL,
    selector_suffix                 INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_power_actor_id, address)
);

-- maps m-to-1 to a storage_power_actor_v0state or storage_power_actor_v2state entry
CREATE TABLE IF NOT EXISTS filecoin.storage_power_proof_validation_buckets (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    storage_power_actor_id          TEXT NOT NULL,
    address                         TEXT NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_power_actor_id, address)
);

-- maps m-to-1 to a storage_power_proof_validation_buckets entry
CREATE TABLE IF NOT EXISTS filecoin.storage_power_proof_seal_verify_infos (
    height                          BIGINT NOT NULL,
    state_root_cid                  TEXT NOT NULL,
    storage_power_actor_id          TEXT NOT NULL,
    address                         TEXT NOT NULL,
    index                           BIGINT NOT NULL,
    seal_proof                      BIGINT NOT NULL,
    sector_id                       BIGINT NOT NULL,
    deal_ids                        BIGINT[] NOT NULL,
    randomness                      BYTEA NOT NULL,
    interactive_randomness          BYTEA NOT NULL,
    proof                           BYTEA NOT NULL,
    sealed_cid                      TEXT NOT NULL,
    unsealed_cid                    TEXT NOT NULL,
    selector_suffix                 INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, storage_power_actor_id, address, index)
);

-- maps 1-to-1 to an actors entry
CREATE TABLE IF NOT EXISTS filecoin.verified_registry_actor_state (
    height                           BIGINT NOT NULL,
    state_root_cid                   TEXT NOT NULL,
    verified_registry_actor_id       TEXT NOT NULL,
    root_address                     TEXT NOT NULL,
    verifiers_root_cid               TEXT NOT NULL,
    verified_clients_root_cid        TEXT NOT NULL,
    PRIMARY KEY (height, state_root_cid, verified_registry_actor_id)
);

-- maps m-to-1 to a verified_registry_actor_state entry
CREATE TABLE IF NOT EXISTS filecoin.verified_registry_verifiers (
    height                           BIGINT NOT NULL,
    state_root_cid                   TEXT NOT NULL,
    verified_registry_actor_id       TEXT NOT NULL,
    address                          TEXT NOT NULL,
    data_cap                         NUMERIC NOT NULL,
    selector_suffix                  INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, verified_registry_actor_id, address)
);

-- maps m-to-1 to a verified_registry_actor_state entry
CREATE TABLE IF NOT EXISTS filecoin.verified_registry_clients (
    height                           BIGINT NOT NULL,
    state_root_cid                   TEXT NOT NULL,
    verified_registry_actor_id       TEXT NOT NULL,
    address                          TEXT NOT NULL,
    data_cap                         NUMERIC NOT NULL,
    selector_suffix                  INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, verified_registry_actor_id, address)
);

-- +goose Down
DROP TABLE filecoin.verified_registry_clients;
DROP TABLE filecoin.verified_registry_verifiers;
DROP TABLE filecoin.verified_registry_actor_state;
DROP TABLE filecoin.storage_power_proof_seal_verify_infos;
DROP TABLE filecoin.storage_power_proof_validation_buckets;
DROP TABLE filecoin.storage_power_v2claims;
DROP TABLE filecoin.storage_power_v0claims;
DROP TABLE filecoin.storage_power_cron_events;
DROP TABLE filecoin.storage_power_cron_event_buckets;
DROP TABLE filecoin.storage_power_actor_v2state;
DROP TABLE filecoin.storage_power_actor_v0state;
DROP TABLE filecoin.payment_channel_lane_states;
DROP TABLE filecoin.payment_channel_actor_state;
DROP TABLE filecoin.multisig_pending_txs;
DROP TABLE filecoin.multisig_actor_state;
DROP TABLE filecoin.miner_partition_expirations;
DROP TABLE filecoin.miner_v2partitions;
DROP TABLE filecoin.miner_v0partitions;
DROP TABLE filecoin.miner_v2sector_infos;
DROP TABLE filecoin.miner_v0sector_infos;
DROP TABLE filecoin.miner_pre_committed_sector_infos;
DROP TABLE filecoin.miner_v2deadlines;
DROP TABLE filecoin.miner_v0deadlines;
DROP TABLE filecoin.miner_vesting_funds;
DROP TABLE filecoin.miner_v2infos;
DROP TABLE filecoin.miner_v0infos;
DROP TABLE filecoin.miner_actor_v2state;
DROP TABLE filecoin.miner_actor_v0state;
DROP TABLE filecoin.storage_actor_locked_tokens;
DROP TABLE filecoin.storage_actor_deal_ops_at_epoch;
DROP TABLE filecoin.storage_actor_deal_ops_buckets;
DROP TABLE filecoin.storage_actor_locked_tokens;
DROP TABLE filecoin.storage_actor_escrows;
DROP TABLE filecoin.storage_actor_pending_proposals;
DROP TABLE filecoin.storage_actor_deal_states;
DROP TABLE filecoin.storage_actor_deal_proposals;
DROP TABLE filecoin.storage_actor_state;
DROP TABLE filecoin.account_actor_addresses;
DROP TABLE filecoin.reward_actor_v2state;
DROP TABLE filecoin.reward_actor_v0state;
DROP TABLE filecoin.cron_actor_method_receivers;
DROP TABLE filecoin.init_actor_id_addresses;
