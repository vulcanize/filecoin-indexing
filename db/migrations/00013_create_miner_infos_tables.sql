-- +goose Up
CREATE TABLE filecoin.miner_infos (
    height BIGINT NOT NULL,
    block_cid TEXT NOT NULL,
    miner_id TEXT NOT NULL,
    owner_id TEXT NOT NULL,
    worker_id TEXT NOT NULL,
    new_worker TEXT,
    worker_change_epoch BIGINT NOT NULL,
    consensus_faulted_elapsed BIGINT NOT NULL,
    peer_id TEXT,
    control_addresses JSONB,
    multi_addresses JSONB,
    sector_size BIGINT NOT NULL,
    PRIMARY KEY (height, block_cid, miner_id)
);

CREATE TABLE filecoin.miner_sector_deals (
    height BIGINT NOT NULL,
    miner_id TEXT NOT NULL,
    sector_id BIGINT NOT NULL,
    deal_id BIGINT NOT NULL,
    PRIMARY KEY (height, miner_id, sector_id, deal_id)
);

CREATE TABLE filecoin.miner_sector_infos (
    height BIGINT NOT NULL,
    block_cid TEXT NOT NULL,
    miner_id TEXT NOT NULL,
    sector_id BIGINT NOT NULL,
    sealed_cid TEXT NOT NULL,
    activation_epoch BIGINT,
    expiration_epoch BIGINT,
    deal_weight NUMERIC NOT NULL,
    verified_deal_weight NUMERIC NOT NULL,
    initial_pledge NUMERIC NOT NULL,
    expected_day_reward NUMERIC NOT NULL,
    expected_storage_pledge NUMERIC NOT NULL,
    PRIMARY KEY (height, block_cid, miner_id, sector_id)
);

CREATE TABLE filecoin.miner_sector_posts (
    height BIGINT NOT NULL,
    block_cid TEXT NOT NULL,
    miner_id TEXT NOT NULL,
    sector_id BIGINT NOT NULL,
    post_message_cid TEXT,
    PRIMARY KEY (height, block_cid, miner_id, sector_id)
);

-- +goose Down
DROP TABLE filecoin.miner_sector_posts;
DROP TABLE filecoin.miner_sector_infos;
DROP TABLE filecoin.miner_sector_deals;
DROP TABLE filecoin.miner_infos;
