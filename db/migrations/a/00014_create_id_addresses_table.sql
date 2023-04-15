-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.id_addresses (
    height    BIGINT NOT NULL,
    block_cid BIGINT NOT NULL,
    id        TEXT NOT NULL,
    address   TEXT NOT NULL,
    PRIMARY KEY (height, block_cid, id, address)
);

-- +goose Down
DROP TABLE filecoin.id_addresses;
