-- +goose Up
CREATE TABLE filecoin.actors (
    height BIGINT NOT NULL,
    block_cid TEXT NOT NULL,
    id TEXT NOT NULL,
    code TEXT NOT NULL,
    head TEXT NOT NULL,
    nonce BIGINT NOT NULL,
    balance TEXT NOT NULL,
    PRIMARY KEY (height, block_cid, id)
);

CREATE TABLE filecoin.actor_states (
   height BIGINT NOT NULL,
   block_cid TEXT NOT NULL,
   id TEXT NOT NULL,
   state JSONB NOT NULL, -- TODO: figure out if there is a good reason why this isn't simply internalized into filecoin.actors in lily, also look into a more rich representation of the individual actor state (for each different type of actor)
   PRIMARY KEY (height, block_cid, id)
);

-- +goose Down
DROP TABLE filecoin.actor_states;
DROP TABLE filecoin.actors;
