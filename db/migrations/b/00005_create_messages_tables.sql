-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.messages (
    height      BIGINT NOT NULL,
    block_cid   TEXT NOT NULL,
    message_cid TEXT NOT NULL,
    "from"      TEXT NOT NULL,
    "to"        TEXT NOT NULL,
    size_bytes  BIGINT NOT NULL,
    nonce       BIGINT NOT NULL,
    value       NUMERIC NOT NULL,
    gas_fee_cap NUMERIC NOT NULL,
    gas_premium NUMERIC NOT NULL,
    gas_limit   BIGINT NOT NULL,
    method      BIGINT,
    index       INT NOT NULL,
    selector_suffix INT[] NOT NULL,
    PRIMARY KEY (height, block_cid, message_cid)
);

CREATE TABLE IF NOT EXISTS filecoin.parsed_messages (
    height      BIGINT NOT NULL,
    block_cid   TEXT NOT NULL,
    message_cid TEXT NOT NULL,
    params      JSONB,
    PRIMARY KEY (height, block_cid, message_cid)
);

CREATE TABLE IF NOT EXISTS filecoin.internal_messages (
    height          BIGINT NOT NULL,
    block_cid       TEXT NOT NULL,
    message_cid     TEXT NOT NULL,
    source          TEXT NOT NULL,
    "from"          TEXT NOT NULL,
    "to"            TEXT NOT NULL,
    value           NUMERIC NOT NULL,
    method          BIGINT NOT NULL,
    actor_name      TEXT NOT NULL,
    actor_family    TEXT NOT NULL,
    exit_code       BIGINT NOT NULL,
    gas_used        BIGINT NOT NULL,
    selector_suffix INT[] NOT NULL,
    PRIMARY KEY (height, block_cid, message_cid, source)
);

CREATE TABLE IF NOT EXISTS filecoin.internal_parsed_messages (
    height      BIGINT NOT NULL,
    block_cid   TEXT NOT NULL,
    message_cid TEXT NOT NULL,
    source      TEXT NOT NULL,
    params      JSONB,
    PRIMARY KEY (height, block_cid, message_cid, source)
);

CREATE TABLE IF NOT EXISTS filecoin.vm_messages (
    height      BIGINT NOT NULL,
    block_cid   TEXT NOT NULL,
    message_cid TEXT NOT NULL,
    source      TEXT NOT NULL,
    actor_code  TEXT NOT NULL,
    params      JSONB,
    returns     JSONB,
    PRIMARY KEY (height, block_cid, message_cid, source)
);

-- +goose Down
DROP TABLE filecoin.vm_messages;
DROP TABLE filecoin.internal_parsed_messages;
DROP TABLE filecoin.internal_messages;
DROP TABLE filecoin.parsed_messages;
DROP TABLE filecoin.messages;
