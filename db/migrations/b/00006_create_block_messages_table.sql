-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.block_messages (
    height      BIGINT NOT NULL,
    block_cid   TEXT NOT NULL,
    message_cid TEXT NOT NULL,
    PRIMARY KEY (height, block_cid, message_cid),
    FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks (height, key),
    FOREIGN KEY (height, message_cid) REFERENCES ipld.blocks (height, key),
    FOREIGN KEY (height, block_cid) REFERENCES filecoin.block_headers (height, block_cid)
);

-- +goose Down
DROP TABLE filecoin.block_messages;
