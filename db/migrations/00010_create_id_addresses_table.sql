-- +goose Up
CREATE TABLE filecoin.id_addresses (
    height BIGINT NOT NULL,
    block_cid TEXT NOT NULL,
    id TEXT NOT NULL,
    address TEXT NOT NULL,
    PRIMARY KEY (height, block_cid, id, address)
);

-- +goose Down
DROP TABLE filecoin.id_addresses;
