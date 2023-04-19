-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.tip_sets (
    height                  BIGINT NOT NULL,
    parent_tip_set_key_cid	TEXT NOT NULL,
    parent_state_root_cid   TEXT NOT NULL,
    PRIMARY KEY (height, parent_tip_set_key_cid),
    UNIQUE (height, parent_state_root_cid),
    FOREIGN KEY (height, parent_tip_set_key_cid) REFERENCES ipld.blocks (height, key),
    FOREIGN KEY (height, parent_state_root_cid) REFERENCES ipld.blocks (height, key)
);

CREATE TABLE IF NOT EXISTS filecoin.tip_set_members (
    height                  BIGINT NOT NULL,
    parent_tip_set_key_cid  TEXT NOT NULL,
    index                   INT NOT NULL,
    block_cid               TEXT NOT NULL,
    PRIMARY KEY (height, parent_tip_set_key_cid, index),
    FOREIGN KEY (height, parent_tip_set_key_cid) REFERENCES ipld.blocks (height, key),
    FOREIGN KEY (height, block_cid) REFERENCES ipld.blocks (height, key),
    FOREIGN KEY (height, parent_tip_set_key_cid) REFERENCES filecoin.tip_sets (height, parent_tip_set_key_cid)
);

-- +goose Down
DROP TABLE filecoin.tip_set_members;
DROP TABLE filecoin.tip_sets;
