-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.actors (
    height          BIGINT NOT NULL,
    state_root_cid  BIGINT NOT NULL,
    id              TEXT NOT NULL,
    code            TEXT NOT NULL,
    head_cid        BIGINT NOT NULL,
    nonce           BIGINT NOT NULL,
    balance         TEXT NOT NULL,
    selector_suffix INT[] NOT NULL,
    PRIMARY KEY (height, state_root_cid, id),
    FOREIGN KEY (state_root_cid) REFERENCES ipld.blocks (key),
    FOREIGN KEY (head_cid) REFERENCES ipld.blocks (key),
    FOREIGN KEY (height, state_root_cid) REFERENCES filecoin.tip_sets (height, parent_state_root_cid)
);

-- NOTE: catchall for any actor state not represented with its own rich tables(s)
CREATE TABLE IF NOT EXISTS filecoin.actor_states (
   height         BIGINT NOT NULL,
   state_root_cid BIGINT NOT NULL,
   id             TEXT NOT NULL,
   state          JSONB NOT NULL,
   PRIMARY KEY (height, state_root_cid, id),
   FOREIGN KEY (state_root_cid) REFERENCES ipld.blocks (key),
   FOREIGN KEY (height, state_root_cid, id) REFERENCES filecoin.actors (height, state_root_cid, id)
);

CREATE TABLE IF NOT EXISTS filecoin.actor_events (
    height 			BIGINT 	NOT NULL,
    state_root_cid  BIGINT 	NOT NULL,
    message_cid 	BIGINT	NOT NULL,
    event_index 	BIGINT 	NOT NULL,
    emitter 		TEXT	NOT NULL,
    flags 			BYTEA	NOT NULL,
    codec			BIGINT 	NOT NULL,
    key 			TEXT 	NOT NULL,
    value			BYTEA	NOT NULL,
    PRIMARY KEY (height, state_root_cid, message_cid, event_index),
    FOREIGN KEY (state_root_cid) REFERENCES ipld.blocks (key),
    FOREIGN KEY (message_cid) REFERENCES ipld.blocks (key),
    FOREIGN KEY (height, state_root_cid, message_cid) REFERENCES filecoin.block_messages (height, state_root_cid, message_cid)
);

-- +goose Down
DROP TABLE filecoin.actor_events;
DROP TABLE filecoin.actor_states;
DROP TABLE filecoin.actors;
