-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.receipts (
    height      BIGINT NOT NULL,
    block_cid   BIGINT NOT NULL,
    message_cid BIGINT NOT NULL,
    idx         BIGINT NOT NULL,
    exit_code   BIGINT NOT NULL,
    gas_used    BIGINT NOT NULL,
    return      BYTEA,
    PRIMARY KEY (height, block_cid, message_cid)
);

-- +goose Down
DROP TABLE filecoin.receipts;
