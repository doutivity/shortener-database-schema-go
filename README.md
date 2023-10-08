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
    id              BIGSERIAL NOT NULL PRIMARY KEY,
    short_code      VARCHAR   NOT NULL UNIQUE,
    destination_url VARCHAR   NOT NULL,
    title           VARCHAR   NOT NULL,
    description     VARCHAR   NOT NULL,
    created_at      TIMESTAMP NOT NULL,
    created_by      BIGINT    NOT NULL,
    updated_at      TIMESTAMP NOT NULL,
    updated_by      BIGINT    NOT NULL
);
```

# Examples
* [Polr](https://drawsql.app/templates/polr)
