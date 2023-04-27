--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6
-- Dumped by pg_dump version 14.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: timescaledb; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS timescaledb WITH SCHEMA public;


--
-- Name: EXTENSION timescaledb; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION timescaledb IS 'Enables scalable inserts and complex queries for time-series data';


--
-- Name: filecoin; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA filecoin;


--
-- Name: ipld; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA ipld;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_actor_addresses; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.account_actor_addresses (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    account_actor_id text NOT NULL,
    address text NOT NULL
);


--
-- Name: actor_events; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.actor_events (
    height bigint NOT NULL,
    block_cid bigint NOT NULL,
    message_cid bigint NOT NULL,
    event_index bigint NOT NULL,
    emitter text NOT NULL,
    flags bytea NOT NULL,
    codec bigint NOT NULL,
    key text NOT NULL,
    value bytea NOT NULL
);


--
-- Name: actor_states; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.actor_states (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    id text NOT NULL,
    state jsonb NOT NULL
);


--
-- Name: actors; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.actors (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    id text NOT NULL,
    code text NOT NULL,
    head_cid bigint NOT NULL,
    nonce bigint NOT NULL,
    balance text NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: block_headers; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.block_headers (
    height bigint NOT NULL,
    block_cid bigint NOT NULL,
    parent_weight numeric NOT NULL,
    parent_state_root_cid bigint NOT NULL,
    parent_tip_set_key_cid bigint NOT NULL,
    parent_message_receipts_root_cid bigint NOT NULL,
    messages_root_cid bigint NOT NULL,
    bls_aggregate text NOT NULL,
    miner text NOT NULL,
    block_sig text NOT NULL,
    "timestamp" bigint NOT NULL,
    win_count bigint,
    parent_base_fee text NOT NULL,
    fork_signaling bigint NOT NULL
);


--
-- Name: block_messages; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.block_messages (
    height bigint NOT NULL,
    block_cid bigint NOT NULL,
    message_cid bigint NOT NULL
);


--
-- Name: block_parents; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.block_parents (
    height bigint NOT NULL,
    block_cid bigint NOT NULL,
    parent_cid bigint NOT NULL
);


--
-- Name: cids; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.cids (
    id bigint NOT NULL,
    cid text NOT NULL
);


--
-- Name: cids_id_seq; Type: SEQUENCE; Schema: filecoin; Owner: -
--

CREATE SEQUENCE filecoin.cids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cids_id_seq; Type: SEQUENCE OWNED BY; Schema: filecoin; Owner: -
--

ALTER SEQUENCE filecoin.cids_id_seq OWNED BY filecoin.cids.id;


--
-- Name: cron_actor_method_receivers; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.cron_actor_method_receivers (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    cron_actor_id text NOT NULL,
    index integer NOT NULL,
    receiver text NOT NULL,
    method_num integer NOT NULL
);


--
-- Name: drand_block_entries; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.drand_block_entries (
    height bigint NOT NULL,
    block_cid bigint NOT NULL,
    round bigint NOT NULL,
    signature text NOT NULL,
    previous_signature text NOT NULL
);


--
-- Name: fevm_actor_state; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.fevm_actor_state (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    state_account_id text NOT NULL,
    byte_code bytea,
    storage_root_cid bigint,
    logs_root_cid bigint,
    diff boolean NOT NULL,
    removed boolean NOT NULL
);


--
-- Name: fevm_actor_storage; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.fevm_actor_storage (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    state_account_id text NOT NULL,
    storage_id text NOT NULL,
    val bytea,
    diff boolean NOT NULL,
    removed boolean NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: init_actor_id_addresses; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.init_actor_id_addresses (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    init_actor_id text NOT NULL,
    address text NOT NULL,
    id text NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: internal_messages; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.internal_messages (
    height bigint NOT NULL,
    block_cid bigint NOT NULL,
    message_cid bigint NOT NULL,
    source text NOT NULL,
    "from" text NOT NULL,
    "to" text NOT NULL,
    value numeric NOT NULL,
    method bigint NOT NULL,
    actor_name text NOT NULL,
    actor_family text NOT NULL,
    exit_code bigint NOT NULL,
    gas_used bigint NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: internal_parsed_messages; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.internal_parsed_messages (
    height bigint NOT NULL,
    block_cid bigint NOT NULL,
    message_cid bigint NOT NULL,
    source text NOT NULL,
    params jsonb
);


--
-- Name: messages; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.messages (
    height bigint NOT NULL,
    block_cid bigint NOT NULL,
    message_cid bigint NOT NULL,
    "from" text NOT NULL,
    "to" text NOT NULL,
    size_bytes bigint NOT NULL,
    nonce bigint NOT NULL,
    value numeric NOT NULL,
    gas_fee_cap numeric NOT NULL,
    gas_premium numeric NOT NULL,
    gas_limit bigint NOT NULL,
    method bigint,
    selector_suffix integer[] NOT NULL
);


--
-- Name: miner_actor_state; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.miner_actor_state (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    miner_actor_id text NOT NULL,
    pre_commit_deposits numeric NOT NULL,
    locked_funds numeric NOT NULL,
    vesting_funds_cid bigint NOT NULL,
    initial_pledge numeric NOT NULL,
    pre_committed_sectors_root_cid bigint NOT NULL,
    pre_committed_sectors_expiry_root_cid bigint NOT NULL,
    allocated_sectors_cid bigint NOT NULL,
    sectors_root_cid bigint NOT NULL,
    proving_period_start numeric NOT NULL,
    current_deadline bigint NOT NULL,
    deadlines_cid bigint NOT NULL,
    early_terminations bytea NOT NULL
);


--
-- Name: miner_deadlines; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.miner_deadlines (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    miner_actor_id text NOT NULL,
    index integer NOT NULL,
    partitions_root_cid bigint NOT NULL,
    expiration_epochs_root_cid bigint NOT NULL,
    post_submissions bytea NOT NULL,
    early_terminations bytea NOT NULL,
    live_sectors bigint NOT NULL,
    total_sectors bigint NOT NULL,
    faulty_power_pair_raw numeric NOT NULL,
    faulty_power_pair_qa numeric NOT NULL
);


--
-- Name: miner_infos; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.miner_infos (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    miner_actor_id text NOT NULL,
    owner_id text NOT NULL,
    worker_id text NOT NULL,
    peer_id text,
    control_addresses jsonb,
    new_worker text,
    new_worker_start_epoch bigint,
    multi_addresses jsonb,
    seal_proof_type integer NOT NULL,
    sector_size bigint NOT NULL,
    consensus_faulted_elapsed bigint,
    pending_owner text
);


--
-- Name: miner_partition_expirations; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.miner_partition_expirations (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    miner_actor_id text NOT NULL,
    deadline_index integer NOT NULL,
    partition_number integer NOT NULL,
    epoch bigint NOT NULL,
    on_time_sectors bytea NOT NULL,
    early_sectors bytea NOT NULL,
    on_time_pledge numeric NOT NULL,
    active_power_pair_raw numeric NOT NULL,
    active_power_pair_qa numeric NOT NULL,
    faulty_power_pair_raw numeric NOT NULL,
    faulty_power_pair_qa numeric NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: miner_partitions; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.miner_partitions (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    miner_actor_id text NOT NULL,
    deadline_index integer NOT NULL,
    partition_number integer NOT NULL,
    sectors bytea NOT NULL,
    faults bytea NOT NULL,
    unproven bytea,
    recoveries bytea NOT NULL,
    terminated bytea NOT NULL,
    expiration_epochs_root_cid bigint NOT NULL,
    early_terminated_root_cid bigint NOT NULL,
    live_power_pair_raw numeric NOT NULL,
    live_power_pair_qa numeric NOT NULL,
    unproven_power_pair_raw numeric,
    unproven_power_pair_qa numeric,
    faulty_power_pair_raw numeric NOT NULL,
    faulty_power_pair_qa numeric NOT NULL,
    recovering_power_pair_raw numeric NOT NULL,
    recovering_power_pair_qa numeric NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: miner_pre_committed_sector_infos; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.miner_pre_committed_sector_infos (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    miner_actor_id text NOT NULL,
    sector_number bigint NOT NULL,
    pre_commit_deposit numeric NOT NULL,
    pre_commit_epoch bigint NOT NULL,
    deal_weight numeric NOT NULL,
    verified_deal_weight numeric NOT NULL,
    seal_proof bigint NOT NULL,
    sealed_cid bigint NOT NULL,
    seal_rand_epoch bigint NOT NULL,
    deal_ids bigint[] NOT NULL,
    expiration_epoch bigint NOT NULL,
    replace_capacity boolean NOT NULL,
    replace_sector_deadline bigint NOT NULL,
    replace_sector_partition_number bigint NOT NULL,
    replace_sector_number bigint NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: miner_sector_infos; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.miner_sector_infos (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    miner_actor_id text NOT NULL,
    sector_number bigint NOT NULL,
    registered_seal_proof bigint NOT NULL,
    sealed_cid bigint NOT NULL,
    deal_ids bigint[] NOT NULL,
    activation_epoch bigint NOT NULL,
    expiration_epoch bigint NOT NULL,
    deal_weight numeric NOT NULL,
    verified_deal_weight numeric NOT NULL,
    initial_pledge numeric NOT NULL,
    expected_day_reward numeric NOT NULL,
    expected_storage_pledge numeric NOT NULL,
    replaced_sector_age bigint,
    replaced_day_reward numeric,
    selector_suffix integer[] NOT NULL
);


--
-- Name: miner_vesting_funds; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.miner_vesting_funds (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    miner_actor_id text NOT NULL,
    vests_at bigint NOT NULL,
    amount numeric NOT NULL
);


--
-- Name: multisig_actor_state; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.multisig_actor_state (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    multisig_actor_id text NOT NULL,
    signers text[] NOT NULL,
    num_approvals_threshold bigint NOT NULL,
    next_tx_id bigint NOT NULL,
    initial_balance numeric NOT NULL,
    start_epoch bigint NOT NULL,
    unlock_duration bigint NOT NULL,
    pending_txs_root_cid bigint NOT NULL
);


--
-- Name: multisig_pending_txs; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.multisig_pending_txs (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    multisig_actor_id text NOT NULL,
    transaction_id bigint NOT NULL,
    "to" text NOT NULL,
    value numeric NOT NULL,
    params bytea NOT NULL,
    approved text[] NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: parsed_messages; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.parsed_messages (
    height bigint NOT NULL,
    block_cid bigint NOT NULL,
    message_cid bigint NOT NULL,
    params jsonb
);


--
-- Name: payment_channel_actor_state; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.payment_channel_actor_state (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    payment_channel_actor_id text NOT NULL,
    "from" text NOT NULL,
    "to" text NOT NULL,
    to_send numeric NOT NULL,
    settling_at_epoch bigint NOT NULL,
    min_settle_height bigint NOT NULL,
    lane_states_root_cid bigint NOT NULL
);


--
-- Name: payment_channel_lane_states; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.payment_channel_lane_states (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    payment_channel_actor_id text NOT NULL,
    lane_id integer NOT NULL,
    redeemed numeric NOT NULL,
    nonce bigint NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: receipts; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.receipts (
    height bigint NOT NULL,
    block_cid bigint NOT NULL,
    message_cid bigint NOT NULL,
    idx bigint NOT NULL,
    exit_code bigint NOT NULL,
    gas_used bigint NOT NULL,
    return bytea,
    selector_suffix integer[] NOT NULL
);


--
-- Name: reward_actor_state; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.reward_actor_state (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    reward_actor_id text NOT NULL,
    cumsum_baseline numeric NOT NULL,
    cumsum_realized numeric NOT NULL,
    effective_network_time bigint NOT NULL,
    effective_baseline_power numeric NOT NULL,
    this_epoch_reward numeric NOT NULL,
    position_estimate numeric,
    velocity_estimate numeric,
    this_epoch_baseline_power numeric NOT NULL,
    total_mined numeric,
    total_storage_power_reward numeric,
    simple_total numeric,
    baseline_total numeric
);


--
-- Name: storage_actor_deal_ops_at_epoch; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.storage_actor_deal_ops_at_epoch (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    storage_actor_id text NOT NULL,
    epoch bigint NOT NULL,
    deal_id bigint NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: storage_actor_deal_ops_buckets; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.storage_actor_deal_ops_buckets (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    storage_actor_id text NOT NULL,
    epoch bigint NOT NULL,
    deals_root_cid bigint NOT NULL
);


--
-- Name: storage_actor_deal_proposals; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.storage_actor_deal_proposals (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    storage_actor_id text NOT NULL,
    deal_id bigint NOT NULL,
    piece_cid bigint NOT NULL,
    padded_piece_size bigint NOT NULL,
    unpadded_piece_size bigint NOT NULL,
    is_verified boolean NOT NULL,
    client_id text NOT NULL,
    provider_id text NOT NULL,
    start_epoch bigint NOT NULL,
    end_epoch bigint NOT NULL,
    storage_price_per_epoch numeric NOT NULL,
    provider_collateral numeric NOT NULL,
    client_collateral numeric NOT NULL,
    label text,
    selector_suffix integer[] NOT NULL
);


--
-- Name: storage_actor_deal_states; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.storage_actor_deal_states (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    storage_actor_id text NOT NULL,
    deal_id bigint NOT NULL,
    sector_start_epoch numeric NOT NULL,
    last_updated_epoch numeric NOT NULL,
    slash_epoch numeric NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: storage_actor_escrows; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.storage_actor_escrows (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    storage_actor_id text NOT NULL,
    address text NOT NULL,
    value numeric NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: storage_actor_locked_tokens; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.storage_actor_locked_tokens (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    storage_actor_id text NOT NULL,
    address text NOT NULL,
    value numeric NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: storage_actor_pending_proposals; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.storage_actor_pending_proposals (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    storage_actor_id text NOT NULL,
    deal_cid bigint NOT NULL,
    piece_cid bigint NOT NULL,
    padded_piece_size bigint NOT NULL,
    unpadded_piece_size bigint NOT NULL,
    is_verified boolean NOT NULL,
    client_id text NOT NULL,
    provider_id text NOT NULL,
    start_epoch bigint NOT NULL,
    end_epoch bigint NOT NULL,
    storage_price_per_epoch numeric NOT NULL,
    provider_collateral numeric NOT NULL,
    client_collateral numeric NOT NULL,
    label text,
    selector_suffix integer[] NOT NULL
);


--
-- Name: storage_actor_state; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.storage_actor_state (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    storage_actor_id text NOT NULL,
    proposals_root_cid bigint NOT NULL,
    deal_states_root_cid bigint NOT NULL,
    pending_proposals_root_cid bigint NOT NULL,
    escrows_root_cid bigint NOT NULL,
    locked_tokens_root_cid bigint NOT NULL,
    next_deal_id bigint NOT NULL,
    deal_ops_by_epoch_root_cid bigint NOT NULL,
    last_cron bigint NOT NULL,
    total_client_locked_collateral numeric NOT NULL,
    total_provider_locked_collateral numeric NOT NULL,
    total_client_storage_fee numeric NOT NULL
);


--
-- Name: storage_power_actor_state; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.storage_power_actor_state (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    storage_power_actor_id text NOT NULL,
    total_raw_byte_power numeric NOT NULL,
    total_bytes_committed numeric NOT NULL,
    total_quality_adj_power numeric NOT NULL,
    total_qa_bytes_committed numeric NOT NULL,
    total_pledge_collateral numeric NOT NULL,
    this_epoch_raw_byte_power numeric NOT NULL,
    this_epoch_quality_adj_power numeric NOT NULL,
    this_epoch_pledge_collateral numeric NOT NULL,
    this_epoch_qa_power_smoothed_pos numeric,
    this_epoch_qa_power_smoothed_vel numeric,
    miner_count integer NOT NULL,
    miner_above_min_number_count integer NOT NULL,
    cron_event_queue_root_cid bigint NOT NULL,
    first_cron_epoch bigint NOT NULL,
    claims_root_cid bigint NOT NULL,
    last_processed_cron_epoch bigint,
    proof_validation_batch_root_cid bigint
);


--
-- Name: storage_power_claims; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.storage_power_claims (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    storage_power_actor_id text NOT NULL,
    address text NOT NULL,
    seal_proof_type integer,
    raw_byte_power numeric NOT NULL,
    quality_adj_power numeric NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: storage_power_cron_event_buckets; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.storage_power_cron_event_buckets (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    storage_power_actor_id text NOT NULL,
    epoch bigint NOT NULL
);


--
-- Name: storage_power_cron_events; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.storage_power_cron_events (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    storage_power_actor_id text NOT NULL,
    epoch bigint NOT NULL,
    index integer NOT NULL,
    miner_address text NOT NULL,
    callback_payload bytea NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: storage_power_proof_seal_verify_infos; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.storage_power_proof_seal_verify_infos (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    storage_power_actor_id text NOT NULL,
    address text NOT NULL,
    index bigint NOT NULL,
    seal_proof bigint NOT NULL,
    sector_id bigint NOT NULL,
    deal_ids bigint[] NOT NULL,
    randomness bytea NOT NULL,
    interactive_randomness bytea NOT NULL,
    proof bytea NOT NULL,
    sealed_cid bigint NOT NULL,
    unsealed_cid bigint NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: storage_power_proof_validation_buckets; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.storage_power_proof_validation_buckets (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    storage_power_actor_id text NOT NULL,
    address text NOT NULL
);


--
-- Name: tip_set_members; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.tip_set_members (
    height bigint NOT NULL,
    parent_tip_set_key_cid bigint NOT NULL,
    index integer NOT NULL,
    block_cid bigint NOT NULL
);


--
-- Name: tip_sets; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.tip_sets (
    height bigint NOT NULL,
    parent_tip_set_key_cid bigint NOT NULL,
    parent_state_root_cid bigint NOT NULL
);


--
-- Name: verified_registry_actor_state; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.verified_registry_actor_state (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    verified_registry_actor_id text NOT NULL,
    root_address text NOT NULL,
    verifiers_root_cid bigint NOT NULL,
    verified_clients_root_cid bigint NOT NULL
);


--
-- Name: verified_registry_clients; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.verified_registry_clients (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    verified_registry_actor_id text NOT NULL,
    address text NOT NULL,
    data_cap numeric NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: verified_registry_verifiers; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.verified_registry_verifiers (
    height bigint NOT NULL,
    state_root_cid bigint NOT NULL,
    verified_registry_actor_id text NOT NULL,
    address text NOT NULL,
    data_cap numeric NOT NULL,
    selector_suffix integer[] NOT NULL
);


--
-- Name: vm_messages; Type: TABLE; Schema: filecoin; Owner: -
--

CREATE TABLE filecoin.vm_messages (
    height bigint NOT NULL,
    block_cid bigint NOT NULL,
    message_cid bigint NOT NULL,
    source text NOT NULL,
    actor_code text NOT NULL,
    params jsonb,
    returns jsonb
);


--
-- Name: blocks; Type: TABLE; Schema: ipld; Owner: -
--

CREATE TABLE ipld.blocks (
    height bigint NOT NULL,
    key bigint NOT NULL,
    data bytea NOT NULL
);


--
-- Name: db_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.db_version (
    singleton boolean DEFAULT true NOT NULL,
    version text NOT NULL,
    tstamp timestamp without time zone DEFAULT now(),
    CONSTRAINT db_version_singleton_check CHECK (singleton)
);


--
-- Name: goose_db_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.goose_db_version (
    id integer NOT NULL,
    version_id bigint NOT NULL,
    is_applied boolean NOT NULL,
    tstamp timestamp without time zone DEFAULT now()
);


--
-- Name: goose_db_version_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.goose_db_version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: goose_db_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.goose_db_version_id_seq OWNED BY public.goose_db_version.id;


--
-- Name: cids id; Type: DEFAULT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.cids ALTER COLUMN id SET DEFAULT nextval('filecoin.cids_id_seq'::regclass);


--
-- Name: goose_db_version id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goose_db_version ALTER COLUMN id SET DEFAULT nextval('public.goose_db_version_id_seq'::regclass);


--
-- Name: account_actor_addresses account_actor_addresses_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.account_actor_addresses
    ADD CONSTRAINT account_actor_addresses_pkey PRIMARY KEY (height, state_root_cid, account_actor_id);


--
-- Name: actor_events actor_events_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.actor_events
    ADD CONSTRAINT actor_events_pkey PRIMARY KEY (height, block_cid, message_cid, event_index);


--
-- Name: actor_states actor_states_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.actor_states
    ADD CONSTRAINT actor_states_pkey PRIMARY KEY (height, state_root_cid, id);


--
-- Name: actors actors_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.actors
    ADD CONSTRAINT actors_pkey PRIMARY KEY (height, state_root_cid, id);


--
-- Name: block_headers block_headers_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_headers
    ADD CONSTRAINT block_headers_pkey PRIMARY KEY (height, block_cid);


--
-- Name: block_messages block_messages_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_messages
    ADD CONSTRAINT block_messages_pkey PRIMARY KEY (height, block_cid, message_cid);


--
-- Name: block_parents block_parents_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_parents
    ADD CONSTRAINT block_parents_pkey PRIMARY KEY (height, block_cid, parent_cid);


--
-- Name: cids cids_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.cids
    ADD CONSTRAINT cids_pkey PRIMARY KEY (id);


--
-- Name: cron_actor_method_receivers cron_actor_method_receivers_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.cron_actor_method_receivers
    ADD CONSTRAINT cron_actor_method_receivers_pkey PRIMARY KEY (height, state_root_cid, cron_actor_id, receiver, index);


--
-- Name: drand_block_entries drand_block_entries_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.drand_block_entries
    ADD CONSTRAINT drand_block_entries_pkey PRIMARY KEY (height, block_cid, round);


--
-- Name: fevm_actor_state fevm_actor_state_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.fevm_actor_state
    ADD CONSTRAINT fevm_actor_state_pkey PRIMARY KEY (height, state_root_cid, state_account_id);


--
-- Name: fevm_actor_storage fevm_actor_storage_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.fevm_actor_storage
    ADD CONSTRAINT fevm_actor_storage_pkey PRIMARY KEY (height, state_root_cid, state_account_id, storage_id);


--
-- Name: init_actor_id_addresses init_actor_id_addresses_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.init_actor_id_addresses
    ADD CONSTRAINT init_actor_id_addresses_pkey PRIMARY KEY (height, state_root_cid, init_actor_id, address);


--
-- Name: internal_messages internal_messages_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.internal_messages
    ADD CONSTRAINT internal_messages_pkey PRIMARY KEY (height, block_cid, message_cid, source);


--
-- Name: internal_parsed_messages internal_parsed_messages_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.internal_parsed_messages
    ADD CONSTRAINT internal_parsed_messages_pkey PRIMARY KEY (height, block_cid, message_cid, source);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (height, block_cid, message_cid);


--
-- Name: miner_actor_state miner_actor_state_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_actor_state
    ADD CONSTRAINT miner_actor_state_pkey PRIMARY KEY (height, state_root_cid, miner_actor_id);


--
-- Name: miner_deadlines miner_deadlines_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_deadlines
    ADD CONSTRAINT miner_deadlines_pkey PRIMARY KEY (height, state_root_cid, miner_actor_id, index);


--
-- Name: miner_infos miner_infos_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_infos
    ADD CONSTRAINT miner_infos_pkey PRIMARY KEY (height, state_root_cid, miner_actor_id);


--
-- Name: miner_partition_expirations miner_partition_expirations_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_partition_expirations
    ADD CONSTRAINT miner_partition_expirations_pkey PRIMARY KEY (height, state_root_cid, miner_actor_id, deadline_index, partition_number, epoch);


--
-- Name: miner_partitions miner_partitions_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_partitions
    ADD CONSTRAINT miner_partitions_pkey PRIMARY KEY (height, state_root_cid, miner_actor_id, deadline_index, partition_number);


--
-- Name: miner_pre_committed_sector_infos miner_pre_committed_sector_infos_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_pre_committed_sector_infos
    ADD CONSTRAINT miner_pre_committed_sector_infos_pkey PRIMARY KEY (height, state_root_cid, miner_actor_id, sector_number);


--
-- Name: miner_sector_infos miner_sector_infos_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_sector_infos
    ADD CONSTRAINT miner_sector_infos_pkey PRIMARY KEY (height, state_root_cid, miner_actor_id, sector_number);


--
-- Name: miner_vesting_funds miner_vesting_funds_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_vesting_funds
    ADD CONSTRAINT miner_vesting_funds_pkey PRIMARY KEY (height, state_root_cid, miner_actor_id, vests_at);


--
-- Name: multisig_actor_state multisig_actor_state_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.multisig_actor_state
    ADD CONSTRAINT multisig_actor_state_pkey PRIMARY KEY (height, state_root_cid, multisig_actor_id);


--
-- Name: multisig_pending_txs multisig_pending_txs_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.multisig_pending_txs
    ADD CONSTRAINT multisig_pending_txs_pkey PRIMARY KEY (height, state_root_cid, multisig_actor_id, transaction_id);


--
-- Name: parsed_messages parsed_messages_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.parsed_messages
    ADD CONSTRAINT parsed_messages_pkey PRIMARY KEY (height, block_cid, message_cid);


--
-- Name: payment_channel_actor_state payment_channel_actor_state_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.payment_channel_actor_state
    ADD CONSTRAINT payment_channel_actor_state_pkey PRIMARY KEY (height, state_root_cid, payment_channel_actor_id);


--
-- Name: payment_channel_lane_states payment_channel_lane_states_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.payment_channel_lane_states
    ADD CONSTRAINT payment_channel_lane_states_pkey PRIMARY KEY (height, state_root_cid, payment_channel_actor_id, lane_id);


--
-- Name: receipts receipts_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.receipts
    ADD CONSTRAINT receipts_pkey PRIMARY KEY (height, block_cid, message_cid);


--
-- Name: reward_actor_state reward_actor_state_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.reward_actor_state
    ADD CONSTRAINT reward_actor_state_pkey PRIMARY KEY (height, state_root_cid, reward_actor_id);


--
-- Name: storage_actor_deal_ops_at_epoch storage_actor_deal_ops_at_epoch_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_deal_ops_at_epoch
    ADD CONSTRAINT storage_actor_deal_ops_at_epoch_pkey PRIMARY KEY (height, state_root_cid, storage_actor_id, epoch, deal_id);


--
-- Name: storage_actor_deal_ops_buckets storage_actor_deal_ops_buckets_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_deal_ops_buckets
    ADD CONSTRAINT storage_actor_deal_ops_buckets_pkey PRIMARY KEY (height, state_root_cid, storage_actor_id, epoch);


--
-- Name: storage_actor_deal_proposals storage_actor_deal_proposals_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_deal_proposals
    ADD CONSTRAINT storage_actor_deal_proposals_pkey PRIMARY KEY (height, state_root_cid, storage_actor_id, deal_id);


--
-- Name: storage_actor_deal_states storage_actor_deal_states_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_deal_states
    ADD CONSTRAINT storage_actor_deal_states_pkey PRIMARY KEY (height, state_root_cid, storage_actor_id, deal_id);


--
-- Name: storage_actor_escrows storage_actor_escrows_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_escrows
    ADD CONSTRAINT storage_actor_escrows_pkey PRIMARY KEY (height, state_root_cid, storage_actor_id, address);


--
-- Name: storage_actor_locked_tokens storage_actor_locked_tokens_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_locked_tokens
    ADD CONSTRAINT storage_actor_locked_tokens_pkey PRIMARY KEY (height, state_root_cid, storage_actor_id, address);


--
-- Name: storage_actor_pending_proposals storage_actor_pending_proposals_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_pending_proposals
    ADD CONSTRAINT storage_actor_pending_proposals_pkey PRIMARY KEY (height, state_root_cid, storage_actor_id, deal_cid);


--
-- Name: storage_actor_state storage_actor_state_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_state
    ADD CONSTRAINT storage_actor_state_pkey PRIMARY KEY (height, state_root_cid, storage_actor_id);


--
-- Name: storage_power_actor_state storage_power_actor_state_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_actor_state
    ADD CONSTRAINT storage_power_actor_state_pkey PRIMARY KEY (height, state_root_cid, storage_power_actor_id);


--
-- Name: storage_power_claims storage_power_claims_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_claims
    ADD CONSTRAINT storage_power_claims_pkey PRIMARY KEY (height, state_root_cid, storage_power_actor_id, address);


--
-- Name: storage_power_cron_event_buckets storage_power_cron_event_buckets_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_cron_event_buckets
    ADD CONSTRAINT storage_power_cron_event_buckets_pkey PRIMARY KEY (height, state_root_cid, storage_power_actor_id, epoch);


--
-- Name: storage_power_cron_events storage_power_cron_events_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_cron_events
    ADD CONSTRAINT storage_power_cron_events_pkey PRIMARY KEY (height, state_root_cid, storage_power_actor_id, epoch, index);


--
-- Name: storage_power_proof_seal_verify_infos storage_power_proof_seal_verify_infos_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_proof_seal_verify_infos
    ADD CONSTRAINT storage_power_proof_seal_verify_infos_pkey PRIMARY KEY (height, state_root_cid, storage_power_actor_id, address, index);


--
-- Name: storage_power_proof_validation_buckets storage_power_proof_validation_buckets_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_proof_validation_buckets
    ADD CONSTRAINT storage_power_proof_validation_buckets_pkey PRIMARY KEY (height, state_root_cid, storage_power_actor_id, address);


--
-- Name: tip_set_members tip_set_members_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.tip_set_members
    ADD CONSTRAINT tip_set_members_pkey PRIMARY KEY (height, parent_tip_set_key_cid, index);


--
-- Name: tip_sets tip_sets_height_parent_state_root_cid_key; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.tip_sets
    ADD CONSTRAINT tip_sets_height_parent_state_root_cid_key UNIQUE (height, parent_state_root_cid);


--
-- Name: tip_sets tip_sets_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.tip_sets
    ADD CONSTRAINT tip_sets_pkey PRIMARY KEY (height, parent_tip_set_key_cid);


--
-- Name: verified_registry_actor_state verified_registry_actor_state_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.verified_registry_actor_state
    ADD CONSTRAINT verified_registry_actor_state_pkey PRIMARY KEY (height, state_root_cid, verified_registry_actor_id);


--
-- Name: verified_registry_clients verified_registry_clients_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.verified_registry_clients
    ADD CONSTRAINT verified_registry_clients_pkey PRIMARY KEY (height, state_root_cid, verified_registry_actor_id, address);


--
-- Name: verified_registry_verifiers verified_registry_verifiers_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.verified_registry_verifiers
    ADD CONSTRAINT verified_registry_verifiers_pkey PRIMARY KEY (height, state_root_cid, verified_registry_actor_id, address);


--
-- Name: vm_messages vm_messages_pkey; Type: CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.vm_messages
    ADD CONSTRAINT vm_messages_pkey PRIMARY KEY (height, block_cid, message_cid, source);


--
-- Name: blocks blocks_pkey; Type: CONSTRAINT; Schema: ipld; Owner: -
--

ALTER TABLE ONLY ipld.blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (height, key);


--
-- Name: db_version db_version_singleton_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.db_version
    ADD CONSTRAINT db_version_singleton_key UNIQUE (singleton);


--
-- Name: goose_db_version goose_db_version_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goose_db_version
    ADD CONSTRAINT goose_db_version_pkey PRIMARY KEY (id);


--
-- Name: actor_events actor_events_height_block_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.actor_events
    ADD CONSTRAINT actor_events_height_block_cid_ipld_blocks_fkey FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: actor_events actor_events_height_block_cid_message_cid_block_messages_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.actor_events
    ADD CONSTRAINT actor_events_height_block_cid_message_cid_block_messages_fkey FOREIGN KEY (height, block_cid, message_cid) REFERENCES filecoin.block_messages(height, block_cid, message_cid);


--
-- Name: actor_events actor_events_height_message_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.actor_events
    ADD CONSTRAINT actor_events_height_message_cid_ipld_blocks_fkey FOREIGN KEY (height, message_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: actor_states actor_states_height_state_root_cid_id_actors_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.actor_states
    ADD CONSTRAINT actor_states_height_state_root_cid_id_actors_fkey FOREIGN KEY (height, state_root_cid, id) REFERENCES filecoin.actors(height, state_root_cid, id);


--
-- Name: actor_states actor_states_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.actor_states
    ADD CONSTRAINT actor_states_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: actors actors_height_head_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.actors
    ADD CONSTRAINT actors_height_head_cid_ipld_blocks_fkey FOREIGN KEY (height, head_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: actors actors_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.actors
    ADD CONSTRAINT actors_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: actors actors_height_state_root_cid_tip_sets_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.actors
    ADD CONSTRAINT actors_height_state_root_cid_tip_sets_fkey FOREIGN KEY (height, state_root_cid) REFERENCES filecoin.tip_sets(height, parent_state_root_cid);


--
-- Name: account_actor_addresses addresses_height_state_root_cid_account_actor_id_actors_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.account_actor_addresses
    ADD CONSTRAINT addresses_height_state_root_cid_account_actor_id_actors_fkey FOREIGN KEY (height, state_root_cid, account_actor_id) REFERENCES filecoin.actors(height, state_root_cid, id);


--
-- Name: account_actor_addresses addresses_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.account_actor_addresses
    ADD CONSTRAINT addresses_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: block_messages block_messages_height_block_cid_headers_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_messages
    ADD CONSTRAINT block_messages_height_block_cid_headers_fkey FOREIGN KEY (height, block_cid) REFERENCES filecoin.block_headers(height, block_cid);


--
-- Name: block_messages block_messages_height_block_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_messages
    ADD CONSTRAINT block_messages_height_block_cid_ipld_blocks_fkey FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: block_messages block_messages_height_message_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_messages
    ADD CONSTRAINT block_messages_height_message_cid_ipld_blocks_fkey FOREIGN KEY (height, message_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_power_cron_event_buckets cron_bs_height_state_root_cid_s_pow_actor_id_pow_state_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_cron_event_buckets
    ADD CONSTRAINT cron_bs_height_state_root_cid_s_pow_actor_id_pow_state_fkey FOREIGN KEY (height, state_root_cid, storage_power_actor_id) REFERENCES filecoin.storage_power_actor_state(height, state_root_cid, storage_power_actor_id);


--
-- Name: storage_power_cron_event_buckets cron_buckets_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_cron_event_buckets
    ADD CONSTRAINT cron_buckets_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_power_cron_events cron_es_height_state_root_cid_s_pow_actor_id_epoch_cron_bs_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_cron_events
    ADD CONSTRAINT cron_es_height_state_root_cid_s_pow_actor_id_epoch_cron_bs_fkey FOREIGN KEY (height, state_root_cid, storage_power_actor_id, epoch) REFERENCES filecoin.storage_power_cron_event_buckets(height, state_root_cid, storage_power_actor_id, epoch);


--
-- Name: storage_power_cron_events cron_events_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_cron_events
    ADD CONSTRAINT cron_events_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_deal_ops_buckets deal_bkts_height_state_root_cid_storage_actor_id_storage_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_deal_ops_buckets
    ADD CONSTRAINT deal_bkts_height_state_root_cid_storage_actor_id_storage_fkey FOREIGN KEY (height, state_root_cid, storage_actor_id) REFERENCES filecoin.storage_actor_state(height, state_root_cid, storage_actor_id);


--
-- Name: storage_actor_deal_ops_buckets deal_buckets_height_deals_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_deal_ops_buckets
    ADD CONSTRAINT deal_buckets_height_deals_root_cid_ipld_blocks_fkey FOREIGN KEY (height, deals_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_deal_ops_buckets deal_buckets_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_deal_ops_buckets
    ADD CONSTRAINT deal_buckets_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_deal_proposals deal_props_height_piece_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_deal_proposals
    ADD CONSTRAINT deal_props_height_piece_cid_ipld_blocks_fkey FOREIGN KEY (height, piece_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_deal_proposals deal_props_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_deal_proposals
    ADD CONSTRAINT deal_props_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_deal_proposals deal_props_height_state_root_cid_storage_actor_id_storage_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_deal_proposals
    ADD CONSTRAINT deal_props_height_state_root_cid_storage_actor_id_storage_fkey FOREIGN KEY (height, state_root_cid, storage_actor_id) REFERENCES filecoin.storage_actor_state(height, state_root_cid, storage_actor_id);


--
-- Name: storage_actor_deal_states deal_states_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_deal_states
    ADD CONSTRAINT deal_states_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_deal_states deal_states_height_state_root_cid_storage_actor_id_storage_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_deal_states
    ADD CONSTRAINT deal_states_height_state_root_cid_storage_actor_id_storage_fkey FOREIGN KEY (height, state_root_cid, storage_actor_id) REFERENCES filecoin.storage_actor_state(height, state_root_cid, storage_actor_id);


--
-- Name: drand_block_entries drand_height_block_cid_block_headers_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.drand_block_entries
    ADD CONSTRAINT drand_height_block_cid_block_headers_fkey FOREIGN KEY (height, block_cid) REFERENCES filecoin.block_headers(height, block_cid);


--
-- Name: drand_block_entries drand_height_block_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.drand_block_entries
    ADD CONSTRAINT drand_height_block_cid_ipld_blocks_fkey FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_escrows escrows_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_escrows
    ADD CONSTRAINT escrows_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_escrows escrows_height_state_root_cid_storage_actor_id_storage_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_escrows
    ADD CONSTRAINT escrows_height_state_root_cid_storage_actor_id_storage_fkey FOREIGN KEY (height, state_root_cid, storage_actor_id) REFERENCES filecoin.storage_actor_state(height, state_root_cid, storage_actor_id);


--
-- Name: miner_partition_expirations exps_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_partition_expirations
    ADD CONSTRAINT exps_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_partition_expirations exps_height_state_root_cid_m_actor_id_dl_index_p_num_ps_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_partition_expirations
    ADD CONSTRAINT exps_height_state_root_cid_m_actor_id_dl_index_p_num_ps_fkey FOREIGN KEY (height, state_root_cid, miner_actor_id, deadline_index, partition_number) REFERENCES filecoin.miner_partitions(height, state_root_cid, miner_actor_id, deadline_index, partition_number);


--
-- Name: fevm_actor_storage fevm_a_stor_height_sta_root_cid_sta_acct_id_fevm_a_sta_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.fevm_actor_storage
    ADD CONSTRAINT fevm_a_stor_height_sta_root_cid_sta_acct_id_fevm_a_sta_fkey FOREIGN KEY (height, state_root_cid, state_account_id) REFERENCES filecoin.fevm_actor_state(height, state_root_cid, state_account_id);


--
-- Name: fevm_actor_state fevm_act_state_height_state_root_cid_state_acct_id_actors_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.fevm_actor_state
    ADD CONSTRAINT fevm_act_state_height_state_root_cid_state_acct_id_actors_fkey FOREIGN KEY (height, state_root_cid, state_account_id) REFERENCES filecoin.actors(height, state_root_cid, id);


--
-- Name: fevm_actor_state fevm_actor_state_height_logs_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.fevm_actor_state
    ADD CONSTRAINT fevm_actor_state_height_logs_root_cid_ipld_blocks_fkey FOREIGN KEY (height, logs_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: fevm_actor_state fevm_actor_state_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.fevm_actor_state
    ADD CONSTRAINT fevm_actor_state_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: fevm_actor_state fevm_actor_state_height_storage_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.fevm_actor_state
    ADD CONSTRAINT fevm_actor_state_height_storage_root_cid_ipld_blocks_fkey FOREIGN KEY (height, storage_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: fevm_actor_storage fevm_actor_storage_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.fevm_actor_storage
    ADD CONSTRAINT fevm_actor_storage_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: block_headers headers_height_messages_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_headers
    ADD CONSTRAINT headers_height_messages_root_cid_ipld_blocks_fkey FOREIGN KEY (height, parent_state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: block_headers headers_height_parent_message_rcts_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_headers
    ADD CONSTRAINT headers_height_parent_message_rcts_root_cid_ipld_blocks_fkey FOREIGN KEY (height, parent_state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: block_headers headers_height_parent_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_headers
    ADD CONSTRAINT headers_height_parent_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, parent_state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: block_headers headers_height_parent_tip_set_key_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_headers
    ADD CONSTRAINT headers_height_parent_tip_set_key_cid_ipld_blocks_fkey FOREIGN KEY (height, parent_tip_set_key_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: block_headers headers_height_parent_tip_set_key_cid_tip_sets_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_headers
    ADD CONSTRAINT headers_height_parent_tip_set_key_cid_tip_sets_fkey FOREIGN KEY (height, parent_state_root_cid) REFERENCES filecoin.tip_sets(height, parent_tip_set_key_cid);


--
-- Name: init_actor_id_addresses id_addresses_height_state_root_cid_init_actor_id_actors_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.init_actor_id_addresses
    ADD CONSTRAINT id_addresses_height_state_root_cid_init_actor_id_actors_fkey FOREIGN KEY (height, state_root_cid, init_actor_id) REFERENCES filecoin.actors(height, state_root_cid, id);


--
-- Name: init_actor_id_addresses id_addresses_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.init_actor_id_addresses
    ADD CONSTRAINT id_addresses_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: internal_parsed_messages int_parsed_msgs_height_block_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.internal_parsed_messages
    ADD CONSTRAINT int_parsed_msgs_height_block_cid_ipld_blocks_fkey FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: internal_parsed_messages int_parsed_msgs_height_block_cid_msg_cid_src_msgs_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.internal_parsed_messages
    ADD CONSTRAINT int_parsed_msgs_height_block_cid_msg_cid_src_msgs_fkey FOREIGN KEY (height, block_cid, message_cid, source) REFERENCES filecoin.internal_messages(height, block_cid, message_cid, source);


--
-- Name: internal_parsed_messages int_parsed_msgs_height_msg_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.internal_parsed_messages
    ADD CONSTRAINT int_parsed_msgs_height_msg_cid_ipld_blocks_fkey FOREIGN KEY (height, message_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: internal_messages internal_messages_height_block_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.internal_messages
    ADD CONSTRAINT internal_messages_height_block_cid_ipld_blocks_fkey FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: internal_messages internal_messages_height_message_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.internal_messages
    ADD CONSTRAINT internal_messages_height_message_cid_ipld_blocks_fkey FOREIGN KEY (height, message_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: internal_messages internal_msgs_height_block_cid_message_cid_block_messages_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.internal_messages
    ADD CONSTRAINT internal_msgs_height_block_cid_message_cid_block_messages_fkey FOREIGN KEY (height, block_cid, message_cid) REFERENCES filecoin.block_messages(height, block_cid, message_cid);


--
-- Name: storage_actor_locked_tokens locked_tkns_height_state_root_cid_storage_actor_id_storage_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_locked_tokens
    ADD CONSTRAINT locked_tkns_height_state_root_cid_storage_actor_id_storage_fkey FOREIGN KEY (height, state_root_cid, storage_actor_id) REFERENCES filecoin.storage_actor_state(height, state_root_cid, storage_actor_id);


--
-- Name: storage_actor_locked_tokens locked_tokens_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_locked_tokens
    ADD CONSTRAINT locked_tokens_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_partitions m_parts_height_state_root_cid_m_actor_id_dl_index_dls_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_partitions
    ADD CONSTRAINT m_parts_height_state_root_cid_m_actor_id_dl_index_dls_fkey FOREIGN KEY (height, state_root_cid, miner_actor_id, deadline_index) REFERENCES filecoin.miner_deadlines(height, state_root_cid, miner_actor_id, index);


--
-- Name: miner_sector_infos m_sec_infos_height_sealed_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_sector_infos
    ADD CONSTRAINT m_sec_infos_height_sealed_cid_ipld_blocks_fkey FOREIGN KEY (height, sealed_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_sector_infos m_sec_infos_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_sector_infos
    ADD CONSTRAINT m_sec_infos_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_sector_infos m_sec_infos_height_state_root_cid_miner_actor_id_state_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_sector_infos
    ADD CONSTRAINT m_sec_infos_height_state_root_cid_miner_actor_id_state_fkey FOREIGN KEY (height, state_root_cid, miner_actor_id) REFERENCES filecoin.miner_actor_state(height, state_root_cid, miner_actor_id);


--
-- Name: messages messages_height_block_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.messages
    ADD CONSTRAINT messages_height_block_cid_ipld_blocks_fkey FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: messages messages_height_block_cid_message_cid_block_messages_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.messages
    ADD CONSTRAINT messages_height_block_cid_message_cid_block_messages_fkey FOREIGN KEY (height, block_cid, message_cid) REFERENCES filecoin.block_messages(height, block_cid, message_cid);


--
-- Name: messages messages_height_message_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.messages
    ADD CONSTRAINT messages_height_message_cid_ipld_blocks_fkey FOREIGN KEY (height, message_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: cron_actor_method_receivers method_rcvrs_height_state_root_cid_cron_actor_id_actors_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.cron_actor_method_receivers
    ADD CONSTRAINT method_rcvrs_height_state_root_cid_cron_actor_id_actors_fkey FOREIGN KEY (height, state_root_cid, cron_actor_id) REFERENCES filecoin.actors(height, state_root_cid, id);


--
-- Name: cron_actor_method_receivers method_receivers_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.cron_actor_method_receivers
    ADD CONSTRAINT method_receivers_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_deadlines miner_deadlines_height_exp_epochs_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_deadlines
    ADD CONSTRAINT miner_deadlines_height_exp_epochs_root_cid_ipld_blocks_fkey FOREIGN KEY (height, expiration_epochs_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_deadlines miner_deadlines_height_partitions_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_deadlines
    ADD CONSTRAINT miner_deadlines_height_partitions_root_cid_ipld_blocks_fkey FOREIGN KEY (height, partitions_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_deadlines miner_deadlines_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_deadlines
    ADD CONSTRAINT miner_deadlines_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_deadlines miner_dls_height_state_root_cid_miner_actor_id_state_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_deadlines
    ADD CONSTRAINT miner_dls_height_state_root_cid_miner_actor_id_state_fkey FOREIGN KEY (height, state_root_cid, miner_actor_id) REFERENCES filecoin.miner_actor_state(height, state_root_cid, miner_actor_id);


--
-- Name: miner_infos miner_infos_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_infos
    ADD CONSTRAINT miner_infos_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_infos miner_infos_height_state_root_cid_miner_actor_id_state_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_infos
    ADD CONSTRAINT miner_infos_height_state_root_cid_miner_actor_id_state_fkey FOREIGN KEY (height, state_root_cid, miner_actor_id) REFERENCES filecoin.miner_actor_state(height, state_root_cid, miner_actor_id);


--
-- Name: miner_partitions miner_parts_height_early_term_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_partitions
    ADD CONSTRAINT miner_parts_height_early_term_root_cid_ipld_blocks_fkey FOREIGN KEY (height, early_terminated_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_partitions miner_parts_height_exp_epochs_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_partitions
    ADD CONSTRAINT miner_parts_height_exp_epochs_root_cid_ipld_blocks_fkey FOREIGN KEY (height, expiration_epochs_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_partitions miner_parts_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_partitions
    ADD CONSTRAINT miner_parts_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_actor_state miner_state_height_allocated_sectors_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_actor_state
    ADD CONSTRAINT miner_state_height_allocated_sectors_cid_ipld_blocks_fkey FOREIGN KEY (height, allocated_sectors_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_actor_state miner_state_height_deadlines_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_actor_state
    ADD CONSTRAINT miner_state_height_deadlines_cid_ipld_blocks_fkey FOREIGN KEY (height, deadlines_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_actor_state miner_state_height_pre_com_sec_exp_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_actor_state
    ADD CONSTRAINT miner_state_height_pre_com_sec_exp_root_cid_ipld_blocks_fkey FOREIGN KEY (height, pre_committed_sectors_expiry_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_actor_state miner_state_height_pre_com_sec_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_actor_state
    ADD CONSTRAINT miner_state_height_pre_com_sec_root_cid_ipld_blocks_fkey FOREIGN KEY (height, pre_committed_sectors_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_actor_state miner_state_height_sectors_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_actor_state
    ADD CONSTRAINT miner_state_height_sectors_root_cid_ipld_blocks_fkey FOREIGN KEY (height, sectors_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_actor_state miner_state_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_actor_state
    ADD CONSTRAINT miner_state_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_actor_state miner_state_height_state_root_cid_miner_actor_id_actors_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_actor_state
    ADD CONSTRAINT miner_state_height_state_root_cid_miner_actor_id_actors_fkey FOREIGN KEY (height, state_root_cid, miner_actor_id) REFERENCES filecoin.actors(height, state_root_cid, id);


--
-- Name: miner_actor_state miner_state_height_vesting_funds_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_actor_state
    ADD CONSTRAINT miner_state_height_vesting_funds_cid_ipld_blocks_fkey FOREIGN KEY (height, vesting_funds_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: multisig_pending_txs msig_p_txs_height_state_root_cid_msig_actor_id_msig_state_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.multisig_pending_txs
    ADD CONSTRAINT msig_p_txs_height_state_root_cid_msig_actor_id_msig_state_fkey FOREIGN KEY (height, state_root_cid, multisig_actor_id) REFERENCES filecoin.multisig_actor_state(height, state_root_cid, multisig_actor_id);


--
-- Name: multisig_pending_txs msig_pending_txs_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.multisig_pending_txs
    ADD CONSTRAINT msig_pending_txs_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: multisig_actor_state msig_state_height_pending_txs_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.multisig_actor_state
    ADD CONSTRAINT msig_state_height_pending_txs_root_cid_ipld_blocks_fkey FOREIGN KEY (height, pending_txs_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: multisig_actor_state msig_state_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.multisig_actor_state
    ADD CONSTRAINT msig_state_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: multisig_actor_state msig_state_height_state_root_cid_msig_actor_id_actors_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.multisig_actor_state
    ADD CONSTRAINT msig_state_height_state_root_cid_msig_actor_id_actors_fkey FOREIGN KEY (height, state_root_cid, multisig_actor_id) REFERENCES filecoin.actors(height, state_root_cid, id);


--
-- Name: storage_actor_deal_ops_at_epoch ops_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_deal_ops_at_epoch
    ADD CONSTRAINT ops_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_deal_ops_at_epoch ops_height_state_root_cid_storage_actor_id_epoch_deal_bkts_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_deal_ops_at_epoch
    ADD CONSTRAINT ops_height_state_root_cid_storage_actor_id_epoch_deal_bkts_fkey FOREIGN KEY (height, state_root_cid, storage_actor_id, epoch) REFERENCES filecoin.storage_actor_deal_ops_buckets(height, state_root_cid, storage_actor_id, epoch);


--
-- Name: block_parents parents_height_block_cid_block_headers_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_parents
    ADD CONSTRAINT parents_height_block_cid_block_headers_fkey FOREIGN KEY (height, block_cid) REFERENCES filecoin.block_headers(height, block_cid);


--
-- Name: block_parents parents_height_block_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_parents
    ADD CONSTRAINT parents_height_block_cid_ipld_blocks_fkey FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: block_parents parents_height_parent_cid_block_headers_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_parents
    ADD CONSTRAINT parents_height_parent_cid_block_headers_fkey FOREIGN KEY (height, parent_cid) REFERENCES filecoin.block_headers(height, block_cid);


--
-- Name: block_parents parents_height_parent_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.block_parents
    ADD CONSTRAINT parents_height_parent_cid_ipld_blocks_fkey FOREIGN KEY (height, parent_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: parsed_messages parsed_messages_height_block_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.parsed_messages
    ADD CONSTRAINT parsed_messages_height_block_cid_ipld_blocks_fkey FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: parsed_messages parsed_messages_height_block_cid_message_cid_messages_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.parsed_messages
    ADD CONSTRAINT parsed_messages_height_block_cid_message_cid_messages_fkey FOREIGN KEY (height, block_cid, message_cid) REFERENCES filecoin.messages(height, block_cid, message_cid);


--
-- Name: parsed_messages parsed_messages_height_message_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.parsed_messages
    ADD CONSTRAINT parsed_messages_height_message_cid_ipld_blocks_fkey FOREIGN KEY (height, message_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: payment_channel_actor_state pay_chan_height_lane_states_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.payment_channel_actor_state
    ADD CONSTRAINT pay_chan_height_lane_states_root_cid_ipld_blocks_fkey FOREIGN KEY (height, lane_states_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: payment_channel_actor_state pay_chan_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.payment_channel_actor_state
    ADD CONSTRAINT pay_chan_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: payment_channel_actor_state pay_chan_height_state_root_cid_pay_chan_actor_id_actors_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.payment_channel_actor_state
    ADD CONSTRAINT pay_chan_height_state_root_cid_pay_chan_actor_id_actors_fkey FOREIGN KEY (height, state_root_cid, payment_channel_actor_id) REFERENCES filecoin.actors(height, state_root_cid, id);


--
-- Name: payment_channel_lane_states pay_lanes_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.payment_channel_lane_states
    ADD CONSTRAINT pay_lanes_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: payment_channel_lane_states pay_lanes_height_state_root_cid_pay_chan_actor_id_pay_chan_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.payment_channel_lane_states
    ADD CONSTRAINT pay_lanes_height_state_root_cid_pay_chan_actor_id_pay_chan_fkey FOREIGN KEY (height, state_root_cid, payment_channel_actor_id) REFERENCES filecoin.payment_channel_actor_state(height, state_root_cid, payment_channel_actor_id);


--
-- Name: storage_actor_pending_proposals pending_props_height_deal_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_pending_proposals
    ADD CONSTRAINT pending_props_height_deal_cid_ipld_blocks_fkey FOREIGN KEY (height, deal_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_pending_proposals pending_props_height_piece_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_pending_proposals
    ADD CONSTRAINT pending_props_height_piece_cid_ipld_blocks_fkey FOREIGN KEY (height, piece_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_pending_proposals pending_props_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_pending_proposals
    ADD CONSTRAINT pending_props_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_pending_proposals pnd_props_height_state_root_cid_storage_actor_id_storage_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_pending_proposals
    ADD CONSTRAINT pnd_props_height_state_root_cid_storage_actor_id_storage_fkey FOREIGN KEY (height, state_root_cid, storage_actor_id) REFERENCES filecoin.storage_actor_state(height, state_root_cid, storage_actor_id);


--
-- Name: storage_power_claims pow_claims_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_claims
    ADD CONSTRAINT pow_claims_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_power_claims pow_cs_height_state_root_cid_s_pow_actor_id_pow_state_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_claims
    ADD CONSTRAINT pow_cs_height_state_root_cid_s_pow_actor_id_pow_state_fkey FOREIGN KEY (height, state_root_cid, storage_power_actor_id) REFERENCES filecoin.storage_power_actor_state(height, state_root_cid, storage_power_actor_id);


--
-- Name: storage_power_actor_state power_state_height_claims_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_actor_state
    ADD CONSTRAINT power_state_height_claims_root_cid_ipld_blocks_fkey FOREIGN KEY (height, claims_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_power_actor_state power_state_height_cron_event_queue_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_actor_state
    ADD CONSTRAINT power_state_height_cron_event_queue_root_cid_ipld_blocks_fkey FOREIGN KEY (height, cron_event_queue_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_power_actor_state power_state_height_proof_val_batch_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_actor_state
    ADD CONSTRAINT power_state_height_proof_val_batch_root_cid_ipld_blocks_fkey FOREIGN KEY (height, proof_validation_batch_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_power_actor_state power_state_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_actor_state
    ADD CONSTRAINT power_state_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_power_actor_state power_state_height_state_root_cid_s_pow_actor_id_actors_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_actor_state
    ADD CONSTRAINT power_state_height_state_root_cid_s_pow_actor_id_actors_fkey FOREIGN KEY (height, state_root_cid, storage_power_actor_id) REFERENCES filecoin.actors(height, state_root_cid, id);


--
-- Name: miner_pre_committed_sector_infos pre_sec_infos_height_sealed_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_pre_committed_sector_infos
    ADD CONSTRAINT pre_sec_infos_height_sealed_cid_ipld_blocks_fkey FOREIGN KEY (height, sealed_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_pre_committed_sector_infos pre_sec_infos_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_pre_committed_sector_infos
    ADD CONSTRAINT pre_sec_infos_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_pre_committed_sector_infos pre_sec_infos_height_state_root_cid_miner_actor_id_state_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_pre_committed_sector_infos
    ADD CONSTRAINT pre_sec_infos_height_state_root_cid_miner_actor_id_state_fkey FOREIGN KEY (height, state_root_cid, miner_actor_id) REFERENCES filecoin.miner_actor_state(height, state_root_cid, miner_actor_id);


--
-- Name: storage_power_proof_validation_buckets proof_bs_height_state_root_cid_s_pow_actor_id_pow_state_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_proof_validation_buckets
    ADD CONSTRAINT proof_bs_height_state_root_cid_s_pow_actor_id_pow_state_fkey FOREIGN KEY (height, state_root_cid, storage_power_actor_id) REFERENCES filecoin.storage_power_actor_state(height, state_root_cid, storage_power_actor_id);


--
-- Name: storage_power_proof_validation_buckets proof_buckets_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_proof_validation_buckets
    ADD CONSTRAINT proof_buckets_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_power_proof_seal_verify_infos proofs_height_sealed_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_proof_seal_verify_infos
    ADD CONSTRAINT proofs_height_sealed_cid_ipld_blocks_fkey FOREIGN KEY (height, sealed_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_power_proof_seal_verify_infos proofs_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_proof_seal_verify_infos
    ADD CONSTRAINT proofs_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_power_proof_seal_verify_infos proofs_height_state_root_cid_s_pow_actor_id_addr_proof_bs_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_proof_seal_verify_infos
    ADD CONSTRAINT proofs_height_state_root_cid_s_pow_actor_id_addr_proof_bs_fkey FOREIGN KEY (height, state_root_cid, storage_power_actor_id, address) REFERENCES filecoin.storage_power_proof_validation_buckets(height, state_root_cid, storage_power_actor_id, address);


--
-- Name: storage_power_proof_seal_verify_infos proofs_height_unsealed_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_power_proof_seal_verify_infos
    ADD CONSTRAINT proofs_height_unsealed_cid_ipld_blocks_fkey FOREIGN KEY (height, unsealed_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: receipts receipts_height_block_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.receipts
    ADD CONSTRAINT receipts_height_block_cid_ipld_blocks_fkey FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: receipts receipts_height_block_cid_message_cid_block_messages_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.receipts
    ADD CONSTRAINT receipts_height_block_cid_message_cid_block_messages_fkey FOREIGN KEY (height, block_cid, message_cid) REFERENCES filecoin.block_messages(height, block_cid, message_cid);


--
-- Name: receipts receipts_height_message_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.receipts
    ADD CONSTRAINT receipts_height_message_cid_ipld_blocks_fkey FOREIGN KEY (height, message_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: verified_registry_clients reg_clients_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.verified_registry_clients
    ADD CONSTRAINT reg_clients_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: verified_registry_clients reg_clients_height_state_root_cid_ver_reg_actor_id_ver_reg_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.verified_registry_clients
    ADD CONSTRAINT reg_clients_height_state_root_cid_ver_reg_actor_id_ver_reg_fkey FOREIGN KEY (height, state_root_cid, verified_registry_actor_id) REFERENCES filecoin.verified_registry_actor_state(height, state_root_cid, verified_registry_actor_id);


--
-- Name: reward_actor_state reward_state_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.reward_actor_state
    ADD CONSTRAINT reward_state_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: reward_actor_state rwrd_state_height_state_root_cid_reward_actor_id_actors_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.reward_actor_state
    ADD CONSTRAINT rwrd_state_height_state_root_cid_reward_actor_id_actors_fkey FOREIGN KEY (height, state_root_cid, reward_actor_id) REFERENCES filecoin.actors(height, state_root_cid, id);


--
-- Name: storage_actor_state storage_height_deal_ops_by_epoch_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_state
    ADD CONSTRAINT storage_height_deal_ops_by_epoch_root_cid_ipld_blocks_fkey FOREIGN KEY (height, deal_ops_by_epoch_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_state storage_height_deal_states_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_state
    ADD CONSTRAINT storage_height_deal_states_root_cid_ipld_blocks_fkey FOREIGN KEY (height, deal_states_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_state storage_height_escrows_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_state
    ADD CONSTRAINT storage_height_escrows_root_cid_ipld_blocks_fkey FOREIGN KEY (height, escrows_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_state storage_height_locked_tokens_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_state
    ADD CONSTRAINT storage_height_locked_tokens_root_cid_ipld_blocks_fkey FOREIGN KEY (height, locked_tokens_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_state storage_height_pending_proposals_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_state
    ADD CONSTRAINT storage_height_pending_proposals_root_cid_ipld_blocks_fkey FOREIGN KEY (height, pending_proposals_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_state storage_height_proposals_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_state
    ADD CONSTRAINT storage_height_proposals_root_cid_ipld_blocks_fkey FOREIGN KEY (height, proposals_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_state storage_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_state
    ADD CONSTRAINT storage_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: storage_actor_state storage_height_state_root_cid_storage_actor_id_actors_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.storage_actor_state
    ADD CONSTRAINT storage_height_state_root_cid_storage_actor_id_actors_fkey FOREIGN KEY (height, state_root_cid, storage_actor_id) REFERENCES filecoin.actors(height, state_root_cid, id);


--
-- Name: tip_set_members tip_set_members_height_block_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.tip_set_members
    ADD CONSTRAINT tip_set_members_height_block_cid_ipld_blocks_fkey FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: tip_set_members tip_set_members_height_parent_tip_set_key_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.tip_set_members
    ADD CONSTRAINT tip_set_members_height_parent_tip_set_key_cid_ipld_blocks_fkey FOREIGN KEY (height, parent_tip_set_key_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: tip_set_members tip_set_members_height_parent_tip_set_key_cid_tip_sets_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.tip_set_members
    ADD CONSTRAINT tip_set_members_height_parent_tip_set_key_cid_tip_sets_fkey FOREIGN KEY (height, parent_tip_set_key_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: tip_sets tip_sets_height_parent_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.tip_sets
    ADD CONSTRAINT tip_sets_height_parent_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, parent_state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: tip_sets tip_sets_height_parent_tip_set_key_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.tip_sets
    ADD CONSTRAINT tip_sets_height_parent_tip_set_key_cid_ipld_blocks_fkey FOREIGN KEY (height, parent_tip_set_key_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: verified_registry_actor_state ver_reg_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.verified_registry_actor_state
    ADD CONSTRAINT ver_reg_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: verified_registry_actor_state ver_reg_height_state_root_cid_ver_reg_actor_id_actors_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.verified_registry_actor_state
    ADD CONSTRAINT ver_reg_height_state_root_cid_ver_reg_actor_id_actors_fkey FOREIGN KEY (height, state_root_cid, verified_registry_actor_id) REFERENCES filecoin.actors(height, state_root_cid, id);


--
-- Name: verified_registry_actor_state ver_reg_height_verified_clients_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.verified_registry_actor_state
    ADD CONSTRAINT ver_reg_height_verified_clients_root_cid_ipld_blocks_fkey FOREIGN KEY (height, verified_clients_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: verified_registry_actor_state ver_reg_height_verifiers_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.verified_registry_actor_state
    ADD CONSTRAINT ver_reg_height_verifiers_root_cid_ipld_blocks_fkey FOREIGN KEY (height, verifiers_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: verified_registry_verifiers verifiers_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.verified_registry_verifiers
    ADD CONSTRAINT verifiers_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: verified_registry_verifiers verifiers_height_state_root_cid_ver_reg_actor_id_ver_reg_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.verified_registry_verifiers
    ADD CONSTRAINT verifiers_height_state_root_cid_ver_reg_actor_id_ver_reg_fkey FOREIGN KEY (height, state_root_cid, verified_registry_actor_id) REFERENCES filecoin.verified_registry_actor_state(height, state_root_cid, verified_registry_actor_id);


--
-- Name: miner_vesting_funds vesting_funds_height_state_root_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_vesting_funds
    ADD CONSTRAINT vesting_funds_height_state_root_cid_ipld_blocks_fkey FOREIGN KEY (height, state_root_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: miner_vesting_funds vesting_funds_height_state_root_cid_miner_actor_id_state_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.miner_vesting_funds
    ADD CONSTRAINT vesting_funds_height_state_root_cid_miner_actor_id_state_fkey FOREIGN KEY (height, state_root_cid, miner_actor_id) REFERENCES filecoin.miner_actor_state(height, state_root_cid, miner_actor_id);


--
-- Name: vm_messages vm_messages_height_block_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.vm_messages
    ADD CONSTRAINT vm_messages_height_block_cid_ipld_blocks_fkey FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: vm_messages vm_messages_height_message_cid_ipld_blocks_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.vm_messages
    ADD CONSTRAINT vm_messages_height_message_cid_ipld_blocks_fkey FOREIGN KEY (height, message_cid) REFERENCES ipld.blocks(height, key);


--
-- Name: vm_messages vm_msgs_height_block_cid_message_cid_block_messages_fkey; Type: FK CONSTRAINT; Schema: filecoin; Owner: -
--

ALTER TABLE ONLY filecoin.vm_messages
    ADD CONSTRAINT vm_msgs_height_block_cid_message_cid_block_messages_fkey FOREIGN KEY (height, block_cid, message_cid) REFERENCES filecoin.block_messages(height, block_cid, message_cid);


--
-- Name: blocks blocks_key_filecoin_cids_fkey; Type: FK CONSTRAINT; Schema: ipld; Owner: -
--

ALTER TABLE ONLY ipld.blocks
    ADD CONSTRAINT blocks_key_filecoin_cids_fkey FOREIGN KEY (key) REFERENCES filecoin.cids(id);


--
-- PostgreSQL database dump complete
--

