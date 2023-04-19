-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.block_messages (
    height      BIGINT NOT NULL,
    block_cid   BIGINT NOT NULL,
    message_cid BIGINT NOT NULL,
    PRIMARY KEY (height, block_cid, message_cid),
    FOREIGN KEY (block_cid) REFERENCES ipld.blocks (key),
    FOREIGN KEY (message_cid) REFERENCES ipld.blocks (key),
    FOREIGN KEY (height, block_cid) REFERENCES filecoin.block_headers (height, block_cid)
);

-- +goose Down
DROP TABLE filecoin.block_messages;
