-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.tip_sets (
    height                  BIGINT NOT NULL,
    parent_state_root_cid	TEXT NOT NULL,
    parent_tip_set_key_cid  TEXT NOT NULL,
    PRIMARY KEY (height, parent_state_root_cid, parent_tip_set_key_cid)
);

CREATE TABLE IF NOT EXISTS filecoin.tip_set_members (
    height           BIGINT NOT NULL,
    tip_set_key_cid  TEXT NOT NULL,
    index            INT NOT NULL,
    block_cid        TEXT NOT NULL,
    PRIMARY KEY (height, tip_set_key_cid, index)
);

-- +goose Down
DROP TABLE filecoin.tip_set_members;
DROP TABLE filecoin.tip_sets;
