-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.block_parents (
    height     BIGINT NOT NULL,
    block_cid  TEXT NOT NULL,
    parent_cid TEXT NOT NULL,
    PRIMARY KEY (height, block_cid, parent_cid)
);

-- +goose Down
DROP TABLE filecoin.block_parents;
