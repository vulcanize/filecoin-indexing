-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.block_messages (
    height      BIGINT NOT NULL,
    block_cid   TEXT NOT NULL,
    message_cid TEXT NOT NULL,
    PRIMARY KEY (height, block_cid, message_cid)
);

-- +goose Down
DROP TABLE filecoin.block_messages;
