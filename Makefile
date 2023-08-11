POSTGRES_URI=postgresql://pg1_user:pg1_password@localhost:5432/pg1_database?sslmode=disable

env-up:
	docker-compose up -d

env-down:
	docker-compose down --remove-orphans -v

test:
	docker exec shortener-database-schema-go-app go test ./... -v -count=1

bench:
	docker exec shortener-database-schema-go-app go test ./... -v -run=$$^ -bench=. -benchmem -benchtime=1000x

go-test-run:
	docker exec shortener-database-schema-go-app go run main.go

postgres-test-run:
	docker exec shortener-database-schema-go-postgres-1 psql -U pg1_user -d pg1_database -c "SELECT VERSION();"
	docker exec shortener-database-schema-go-postgres-1 psql -U pg1_user -d pg1_database -c "SELECT * FROM user_online;"

init-test: env-up go-test-run postgres-test-run test env-down

generate-sqlc:
	# go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
	sqlc generate
	# alternative
	# docker run --rm -v $(shell pwd):/src -w /src kjconroy/sqlc generate

# Creates new migration file with the current timestamp
# Example: make create-new-migration-file NAME=<name>
create-new-migration-file:
	$(eval NAME ?= noname)
	mkdir -p ./internal/storage/postgres/schema/
	goose -dir ./internal/storage/postgres/schema/ create $(NAME) sql

migrate-up:
	goose -dir ./internal/storage/postgres/schema/ -table schema_migrations postgres $(POSTGRES_URI) up
migrate-redo:
	goose -dir ./internal/storage/postgres/schema/ -table schema_migrations postgres $(POSTGRES_URI) redo
migrate-down:
	goose -dir ./internal/storage/postgres/schema/ -table schema_migrations postgres $(POSTGRES_URI) down
migrate-reset:
	goose -dir ./internal/storage/postgres/schema/ -table schema_migrations postgres $(POSTGRES_URI) reset
migrate-status:
	goose -dir ./internal/storage/postgres/schema/ -table schema_migrations postgres $(POSTGRES_URI) status
