-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.tip_sets (
    height                  BIGINT NOT NULL,
    parent_state_root_cid	TEXT NOT NULL,
    parent_tip_set_key_cid  TEXT NOT NULL,
    PRIMARY KEY (height, parent_state_root_cid, parent_tip_set_key_cid)
);

-- +goose Down
DROP TABLE filecoin.tip_sets;
