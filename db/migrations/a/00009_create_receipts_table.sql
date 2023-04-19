-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.receipts (
    height          BIGINT NOT NULL,
    block_cid       BIGINT NOT NULL, -- this might make more sense as parent_state_root_cid (it references a parent block)
    message_cid     BIGINT NOT NULL,
    idx             BIGINT NOT NULL,
    exit_code       BIGINT NOT NULL,
    gas_used        BIGINT NOT NULL,
    return          BYTEA,
    selector_suffix INT[] NOT NULL,
    PRIMARY KEY (height, block_cid, message_cid),
    FOREIGN KEY (block_cid) REFERENCES ipld.blocks (key),
    FOREIGN KEY (message_cid) REFERENCES ipld.blocks (key),
    FOREIGN KEY (height, block_cid) REFERENCES filecoin.block_headers (height, block_cid)
);

-- +goose Down
DROP TABLE filecoin.receipts;
