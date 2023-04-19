-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.cids (
    cid TEXT NOT NULL,
    id  BIGSERIAL,
    PRIMARY KEY (cid),
    FOREIGN KEY (id) REFERENCES ipld.blocks (key)
);

-- +goose Down
DROP TABLE filecoin.cids;
