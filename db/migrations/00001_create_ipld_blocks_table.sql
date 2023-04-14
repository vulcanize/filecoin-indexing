-- +goose Up
CREATE SCHEMA ipld;

CREATE TABLE IF NOT EXISTS ipld.blocks (
    height  BIGINT NOT NULL,
    "key"   TEXT NOT NULL,
    "data"  BYTEA NOT NULL,
    PRIMARY KEY (height, key)
);

-- +goose Down
DROP TABLE ipld.blocks;
DROP SCHEMA ipld;
