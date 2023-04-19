-- +goose Up
CREATE SCHEMA ipld;

CREATE TABLE IF NOT EXISTS ipld.blocks (
    height  BIGINT NOT NULL,
    "key"   BIGINT NOT NULL,
    "data"  BYTEA NOT NULL,
    PRIMARY KEY (height, key),
    FOREIGN KEY (key) REFERENCES filecoin.cids (id)
);

-- +goose Down
DROP TABLE ipld.blocks;
DROP SCHEMA ipld;
