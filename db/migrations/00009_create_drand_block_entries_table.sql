-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.drand_block_entries (
    height    BIGINT NOT NULL, -- this table is small, only one entry per epoch, but lets partition by height anyways to improve data locality
    round     BIGINT NOT NULL,
    block_cid TEXT NOT NULL,
    PRIMARY KEY (height, round, block_cid)
);

-- +goose Down
DROP TABLE filecoin.drand_block_entries;
