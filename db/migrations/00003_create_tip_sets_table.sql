-- +goose Up
CREATE TABLE filecoin.tip_sets (
    height 		        BIGINT NOT NULL,
    parent_state_root	TEXT NOT NULL,
    parent_tip_set_key  TEXT NOT NULL,
    PRIMARY KEY (height, parent_state_root, parent_tip_set_key)
);

-- +goose Down
DROP TABLE filecoin.tip_sets;
