-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.cids (
    id  BIGSERIAL,
    cid TEXT NOT NULL,
    PRIMARY KEY (id)
);

-- +goose Down
DROP TABLE filecoin.cids;
