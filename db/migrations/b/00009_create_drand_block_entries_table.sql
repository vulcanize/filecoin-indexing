-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.drand_block_entries (
    height             TEXT NOT NULL, -- this table is small, only one entry per epoch, but lets partition by height anyways to improve data locality
    block_cid          TEXT NOT NULL,
    round              BIGINT NOT NULL,
    signature          TEXT NOT NULL,
    previous_signature TEXT NOT NULL,
    PRIMARY KEY (height, block_cid, round),
    FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks (height, key),
    FOREIGN KEY (height, block_cid) REFERENCES filecoin.block_headers (height, block_cid)
);

-- +goose Down
DROP TABLE filecoin.drand_block_entries;
