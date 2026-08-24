include .env

# create:
#       goose -dir $(MIGRATIONS_DIR) create $(filter-out $@,$(MAKECMDGOALS)) sql

# Create with sequence
# # make create schemas
create:
        @if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
                echo "Usage: make create <migration_name>"; \
                exit 1; \
        fi; \
        seq=$$(cat $(SEQ_FILE) 2>/dev/null || echo 0); \
        seq=$$((seq + 10)); \
        echo $$seq > $(SEQ_FILE); \
        filename="2025$$(printf '%010d' $$seq)_$(filter-out $@,$(MAKECMDGOALS))"; \
        fullpath="$(MIGRATIONS_DIR)/$$filename.sql"; \
        echo "Creating migration: $$fullpath"; \
        echo "-- +goose Up" > $$fullpath; \
        echo "-- +goose StatementBegin" >> $$fullpath; \
        echo "" >> $$fullpath; \
        echo "-- +goose StatementEnd" >> $$fullpath; \
        echo "" >> $$fullpath; \
        echo "-- +goose Down" >> $$fullpath; \
        echo "-- +goose StatementBegin" >> $$fullpath; \
        echo "" >> $$fullpath; \
        echo "-- +goose StatementEnd" >> $$fullpath; \
        echo "Migration created successfully with template"

dec-seq:
        @current_seq=$$(cat $(SEQ_FILE) 2>/dev/null || echo 0); \
        echo "Nilai Sebelum: $$current_seq"; \
        new_seq=$$((current_seq - 10)); \
        if [ $$new_seq -lt 0 ]; then \
                new_seq=0; \
                echo "Warning: Sequence tidak boleh negatif, di-set ke 0"; \
        fi; \
        echo $$new_seq > $(SEQ_FILE); \
        echo "Nilai Sesudah: $$new_seq"


migrate:
        goose -dir $(MIGRATIONS_DIR) postgres "user=postgres dbname=$(DB_NAME) sslmode=disable" up

migrate-down:
        goose -dir $(MIGRATIONS_DIR) postgres "user=postgres dbname=$(DB_NAME) sslmode=disable" down

backup-db:
        @echo "-> Running $@";
        ./script_backup

restore-db:
        @echo "-> Running $@";
        ./script_restore

#   ___ __ ____
#  / __|  |_  _)
# ( (_ \)(  )(
#  \___(__)(__)
# make git m="testing make for git"
git-push:
        @git add .
        @git commit -m "$(filter-out $@,$(MAKECMDGOALS))"
        @git push

%:  # Catch-all target untuk menangani argument sebagai parameter
        @:  # Do nothing%
