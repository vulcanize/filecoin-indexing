-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.receipts (
    height          BIGINT NOT NULL,
    block_cid       BIGINT NOT NULL, -- this might make more sense as parent_state_root_cid (it references a parent block)
    message_cid     BIGINT NOT NULL,
    index           INT NOT NULL,
    exit_code       BIGINT NOT NULL,
    gas_used        BIGINT NOT NULL,
    return          BYTEA,
    selector_suffix INT[] NOT NULL,
    PRIMARY KEY (height, block_cid, message_cid)
);

-- +goose Down
DROP TABLE filecoin.receipts;
