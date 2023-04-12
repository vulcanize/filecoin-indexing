-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.block_headers (
    height BIGINT NOT NULL,           -- references tipsets
    block_cid TEXT NOT NULL,
    parent_weight TEXT NOT NULL,
    parent_state_root TEXT NOT NULL,  -- references tipsets
    parent_tip_set_key TEXT NOT NULL, -- references tipsets
    parent_message_receipts_root TEXT NOT NULL,
    messages_root TEXT NOT NULL,
    bls_aggregate TEXT NOT NULL,
    miner TEXT NOT NULL,
    block_sig TEXT NOT NULL,
    "timestamp" BIGINT NOT NULL,
    win_count BIGINT,
    parent_base_fee TEXT NOT NULL,
    fork_signaling BIGINT NOT NULL,
    PRIMARY KEY (height, block_cid)
);

-- +goose Down
DROP TABLE filecoin.block_headers;
