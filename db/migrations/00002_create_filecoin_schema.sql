-- +goose Up
CREATE SCHEMA filecoin;

-- +goose Down
DROP SCHEMA filecoin;
