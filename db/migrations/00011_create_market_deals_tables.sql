-- +goose Up
CREATE TABLE filecoin.market_deal_proposals (
    height BIGINT NOT NULL,
    block_cid TEXT NOT NULL, -- do we need to use parent_state_root instead? Since we are processing finalized proposals and not pending ones, we should have the block_cid (and block_cid will map to a parent_state_root in filecoin.block_headers)
    deal_id BIGINT NOT NULL,
    piece_cid TEXT NOT NULL,
    padded_piece_size BIGINT NOT NULL,
    unpadded_piece_size BIGINT NOT NULL,
    is_verified boolean NOT NULL,
    client_id TEXT NOT NULL,
    provider_id TEXT NOT NULL,
    start_epoch BIGINT NOT NULL,
    end_epoch BIGINT NOT NULL,
    slashed_epoch BIGINT,
    storage_price_per_epoch TEXT NOT NULL,
    provider_collateral TEXT NOT NULL,
    client_collateral TEXT NOT NULL,
    label TEXT,
    PRIMARY KEY (height, block_cid, deal_id)
);

CREATE TABLE filecoin.market_deal_states (
    height BIGINT NOT NULL,
    block_cid TEXT NOT NULL,
    deal_id BIGINT NOT NULL,
    sector_start_epoch BIGINT NOT NULL,
    last_update_epoch BIGINT NOT NULL,
    slash_epoch BIGINT NOT NULL,
    PRIMARY KEY (height, block_cid, deal_id)
);

-- +goose Down
DROP TABLE filecoin.market_deal_states;
DROP TABLE filecoin.market_deal_proposals;
