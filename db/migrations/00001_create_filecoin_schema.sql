-- +goose Up
CREATE SCHEMA IF NOT EXISTS filecoin;

-- +goose Down
DROP SCHEMA filecoin;
