-- +goose Up
CREATE TABLE IF NOT EXISTS filecoin.block_headers (
    height                           BIGINT NOT NULL, -- part of reference to tipsets
    block_cid                        BIGINT NOT NULL,
    parent_weight                    TEXT NOT NULL,
    parent_state_root_cid            BIGINT NOT NULL, -- part of reference to tipsets / CID pointing to StateRoot struct IPLD (which contains Version info and link to ActorsHAMT IPLD)
    parent_tip_set_key_cid           BIGINT NOT NULL, -- part of reference to tipsets
    parent_message_receipts_root_cid BIGINT NOT NULL, -- CID pointing to MessageReceiptAMT IPLD
    messages_root_cid                BIGINT NOT NULL, -- CID pointing to TxMeta struct IPLD (which contains link to MessageLinkAMT or SignedMessageLinkAMT IPLD)
    bls_aggregate                    TEXT NOT NULL,
    miner                            TEXT NOT NULL,
    block_sig                        TEXT NOT NULL,
    "timestamp"                      BIGINT NOT NULL,
    win_count                        BIGINT,
    parent_base_fee                  TEXT NOT NULL,
    fork_signaling                   BIGINT NOT NULL,
    PRIMARY KEY (height, block_cid, parent_state_root_cid)
);

-- +goose Down
DROP TABLE filecoin.block_headers;
