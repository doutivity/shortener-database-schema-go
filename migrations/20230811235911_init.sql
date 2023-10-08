-- +goose Up
-- +goose StatementBegin
CREATE TABLE users
(
    id         BIGSERIAL NOT NULL PRIMARY KEY,
    created_at TIMESTAMP NOT NULL,
    created_by BIGINT    NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    updated_by BIGINT    NOT NULL
);

CREATE TABLE urls
(
    id          BIGSERIAL NOT NULL PRIMARY KEY,
    short_code  VARCHAR   NOT NULL UNIQUE,
    title       VARCHAR   NOT NULL,
    description VARCHAR   NOT NULL,
    created_at  TIMESTAMP NOT NULL,
    created_by  BIGINT    NOT NULL,
    updated_at  TIMESTAMP NOT NULL,
    updated_by  BIGINT    NOT NULL
);

-- @TODO Get destination_url by url_id should use some UNIQUE INDEX ~ WHERE url_id = @url_id AND active = TRUE
CREATE TABLE url_destinations
(
    id              BIGSERIAL NOT NULL PRIMARY KEY,
    url_id          BIGINT    NOT NULL, -- @TODO INDEX
    destination_url VARCHAR   NOT NULL,
    created_at      TIMESTAMP NOT NULL,
    created_by      BIGINT    NOT NULL
);

-- @TODO INDEX url_id WHERE deleted_at IS NULL
CREATE TABLE url_locations
(
    id           BIGSERIAL NOT NULL PRIMARY KEY,
    url_id       BIGINT    NOT NULL,
    title        VARCHAR   NOT NULL,
    location_url VARCHAR   NOT NULL,
    created_at   TIMESTAMP NOT NULL,
    created_by   BIGINT    NOT NULL,
    updated_at   TIMESTAMP NOT NULL,
    updated_by   BIGINT    NOT NULL,
    deleted_at   TIMESTAMP NULL,
    deleted_by   BIGINT    NULL
);

CREATE TABLE url_click_raw_stats
(
    id                 BIGSERIAL NOT NULL PRIMARY KEY,
    url_id             BIGINT    NOT NULL, -- REFERENCE urls
    url_destination_id BIGINT    NOT NULL, -- REFERENCE url_destinations
    format             INT8      NOT NULL, -- link, qrcode
    device             INT8      NOT NULL, -- desktop, phone, tablet, tv, ...
    os                 INT8      NOT NULL, -- linux, macos, windows, ...
    browser            INT8      NOT NULL, -- firefox, chrome, safari, opera, ...
    ip_address         INET      NOT NULL,
    country            CHAR(2)   NOT NULL, -- from MaxMind DB
    city               VARCHAR   NOT NULL, -- from MaxMind DB
    languages          CHAR(2)[] NOT NULL, -- alternative VARCHAR[]
    referrer           VARCHAR   NOT NULL,
    created_at         TIMESTAMP NOT NULL
);

-- @TODO
-- 4 custom labels created by user
-- 5 add indexes
-- 6 aggs stats

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE url_click_raw_stats;
DROP TABLE url_locations;
DROP TABLE url_destinations;
DROP TABLE urls;
DROP TABLE users;
-- +goose StatementEnd
