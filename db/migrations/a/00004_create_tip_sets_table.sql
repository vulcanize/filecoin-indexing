-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.tip_sets (
    height                  BIGINT NOT NULL,
    parent_state_root_cid	BIGINT NOT NULL,
    parent_tip_set_key_cid  BIGINT NOT NULL,
    PRIMARY KEY (height, parent_state_root_cid, parent_tip_set_key_cid)
);

-- +goose Down
DROP TABLE filecoin.tip_sets;
