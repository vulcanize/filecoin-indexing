-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.drand_block_entries ( -- NOTE: since there can be empty epochs... this might not be able to always be anchored to a block or tipset...
    height             BIGINT NOT NULL, -- this table is small, only one entry per epoch, but lets partition by height anyways to improve data locality
    block_cid          BIGINT NOT NULL,
    round              BIGINT NOT NULL,
    signature          BYTEA NOT NULL,
    previous_signature BYTEA NOT NULL,
    PRIMARY KEY (height, block_cid, round)
);

-- +goose Down
DROP TABLE filecoin.drand_block_entries;
