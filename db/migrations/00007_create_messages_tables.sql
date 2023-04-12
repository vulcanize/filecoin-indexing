-- +goose Up
-- TODO: how to best consolidate these, there appears to be a lot of redundancy
CREATE TABLE filecoin.messages (
    height BIGINT NOT NULL,
    block_cid TEXT NOT NULL,
    message_cid TEXT NOT NULL,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    size_bytes BIGINT NOT NULL,
    nonce BIGINT NOT NULL,
    value NUMERIC NOT NULL,
    gas_fee_cap NUMERIC NOT NULL,
    gas_premium NUMERIC NOT NULL,
    gas_limit BIGINT NOT NULL,
    method BIGINT,
    PRIMARY KEY (height, block_cid, message_cid)
);

CREATE TABLE filecoin.parsed_messages (
    height BIGINT NOT NULL,
    block_cid TEXT NOT NULL,
    message_cid TEXT NOT NULL,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    value NUMERIC NOT NULL,
    method TEXT NOT NULL,
    params JSONB,
    PRIMARY KEY (height, block_cid, message_cid)
);

CREATE TABLE filecoin.vm_messages (
    height BIGINT NOT NULL,
    message_cid TEXT NOT NULL,
    block_cid TEXT NOT NULL,
    source TEXT,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    value NUMERIC NOT NULL,
    method BIGINT NOT NULL,
    actor_code TEXT NOT NULL,
    exit_code BIGINT NOT NULL,
    gas_used BIGINT NOT NULL,
    params JSONB,
    returns JSONB,
    PRIMARY KEY (height, block_cid, message_cid, source)
);

CREATE TABLE filecoin.internal_parsed_messages (
    height BIGINT NOT NULL,
    block_cid TEXT NOT NULL,
    message_cid TEXT NOT NULL,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    value NUMERIC NOT NULL,
    method TEXT NOT NULL,
    params JSONB,
    PRIMARY KEY (height, block_cid, message_cid)
);

CREATE TABLE filecoin.internal_messages (
    height BIGINT NOT NULL,
    block_cid TEXT NOT NULL,
    message_cid TEXT NOT NULL,
    source TEXT,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    value NUMERIC NOT NULL,
    method BIGINT NOT NULL,
    actor_name TEXT NOT NULL,
    actor_family TEXT NOT NULL,
    exit_code BIGINT NOT NULL,
    gas_used BIGINT NOT NULL,
    PRIMARY KEY (height, block_cid, message_cid, source)
);

-- +goose Down
DROP TABLE filecoin.internal_messages;
DROP TABLE filecoin.internal_parsed_messages;
DROP TABLE filecoin.vm_messages;
DROP TABLE filecoin.parsed_messages;
DROP TABLE filecoin.messages;
