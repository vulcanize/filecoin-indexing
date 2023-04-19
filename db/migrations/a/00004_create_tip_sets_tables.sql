-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.tip_sets (
    height                  BIGINT NOT NULL,
    parent_tip_set_key_cid	BIGINT NOT NULL,
    parent_state_root_cid   BIGINT NOT NULL,
    PRIMARY KEY (height, parent_tip_set_key_cid),
    UNIQUE (height, parent_state_root_cid),
    FOREIGN KEY (parent_tip_set_key_cid) REFERENCES ipld.blocks (key),
    FOREIGN KEY (parent_state_root_cid) REFERENCES ipld.blocks (key)
);

CREATE TABLE IF NOT EXISTS filecoin.tip_set_members (
    height                  BIGINT NOT NULL,
    parent_tip_set_key_cid  BIGINT NOT NULL,
    index                   INT NOT NULL,
    block_cid               BIGINT NOT NULL,
    PRIMARY KEY (height, parent_tip_set_key_cid, index)
);

-- +goose Down
DROP TABLE filecoin.tip_set_members;
DROP TABLE filecoin.tip_sets;
