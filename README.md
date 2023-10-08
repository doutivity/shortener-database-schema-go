# URL shortener database schema

# Support Ukraine 🇺🇦
- Help Ukraine via [SaveLife fund](https://savelife.in.ua/en/donate-en/)
- Help Ukraine via [Dignitas fund](https://dignitas.fund/donate/)
- Help Ukraine via [National Bank of Ukraine](https://bank.gov.ua/en/news/all/natsionalniy-bank-vidkriv-spetsrahunok-dlya-zboru-koshtiv-na-potrebi-armiyi)
- More info on [war.ukraine.ua](https://war.ukraine.ua/) and [MFA of Ukraine](https://twitter.com/MFA_Ukraine)

# Schema
```sql
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

CREATE TABLE url_destinations
(
    id              BIGSERIAL NOT NULL PRIMARY KEY,
    url_id          BIGINT    NOT NULL,
    destination_url VARCHAR   NOT NULL,
    created_at      TIMESTAMP NOT NULL,
    created_by      BIGINT    NOT NULL
);

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
    url_id             BIGINT    NOT NULL,
    url_destination_id BIGINT    NOT NULL,
    format             INT8      NOT NULL,
    device             INT8      NOT NULL,
    os                 INT8      NOT NULL,
    browser            INT8      NOT NULL,
    ip_address         INET      NOT NULL,
    country            CHAR(2)   NOT NULL,
    city               VARCHAR   NOT NULL,
    languages          CHAR(2)[] NOT NULL,
    referrer           VARCHAR   NOT NULL,
    created_at         TIMESTAMP NOT NULL
);
```

# Examples
* [Polr](https://drawsql.app/templates/polr)
