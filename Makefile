POSTGRES_URI=postgresql://pg1_user:pg1_password@localhost:5432/pg1_database?sslmode=disable

env-up:
	docker-compose up -d

env-down:
	docker-compose down --remove-orphans -v

test:
	docker exec shortener-database-schema-go-app go test ./... -v -count=1

bench:
	docker exec shortener-database-schema-go-app go test ./... -v -run=$$^ -bench=. -benchmem -benchtime=1000x

docker-go-test:
	docker exec shortener-database-schema-go-app go version
	docker exec shortener-database-schema-go-app go run main.go

docker-pg-test:
	docker exec shortener-database-schema-go-postgres psql -U pg1_user -d pg1_database -c "SELECT VERSION();"

init-test: env-up docker-go-test docker-pg-test test env-down

generate-sqlc:
	sqlc generate

# Creates new migration file with the current timestamp
# Example: make create-new-migration-file NAME=<name>
create-new-migration-file:
	$(eval NAME ?= noname)
	mkdir -p ./migrations/
	goose -dir ./migrations/ create $(NAME) sql

migrate-up:
	goose -dir ./migrations/ -table schema_migrations postgres $(POSTGRES_URI) up
migrate-redo:
	goose -dir ./migrations/ -table schema_migrations postgres $(POSTGRES_URI) redo
migrate-down:
	goose -dir ./migrations/ -table schema_migrations postgres $(POSTGRES_URI) down
migrate-reset:
	goose -dir ./migrations/ -table schema_migrations postgres $(POSTGRES_URI) reset
migrate-status:
	goose -dir ./migrations/ -table schema_migrations postgres $(POSTGRES_URI) status

install:
	go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
	go install github.com/pressly/goose/v3/cmd/goose@latest
