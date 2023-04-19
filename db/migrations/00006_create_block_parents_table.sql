-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.block_parents (
    height     BIGINT NOT NULL,
    block_cid  BIGINT NOT NULL,
    parent_cid BIGINT NOT NULL,
    PRIMARY KEY (height, block_cid, parent_cid),
    FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks (height, key),
    FOREIGN KEY (height, parent_cid) REFERENCES ipld.blocks (height, key),
    FOREIGN KEY (height, block_cid) REFERENCES filecoin.block_headers (height, block_cid),
    FOREIGN KEY (height, parent_cid) REFERENCES filecoin.block_headers (height, block_cid)
);

-- +goose Down
DROP TABLE filecoin.block_parents;
