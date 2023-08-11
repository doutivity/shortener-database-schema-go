-- +goose Up
-- +goose StatementBegin
CREATE TABLE users
(
    id         BIGINT PRIMARY KEY,
    created_at TIMESTAMP NOT NULL,
    created_by BIGINT    NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    updated_by BIGINT    NOT NULL
);

CREATE TABLE urls
(
    id              BIGINT PRIMARY KEY,
    short_url       VARCHAR   NOT NULL,
    destination_url VARCHAR   NOT NULL,
    title           VARCHAR   NOT NULL,
    description     VARCHAR   NOT NULL,
    created_at      TIMESTAMP NOT NULL,
    created_by      BIGINT    NOT NULL,
    updated_at      TIMESTAMP NOT NULL,
    updated_by      BIGINT    NOT NULL
);

-- @TODO
-- 1 history of destination_url change
-- 2 clicks stats include destination_url_id
-- 3 locations where placed short URL or QR Code
-- 4 custom labels created by user

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE urls;
DROP TABLE users;
-- +goose StatementEnd
