#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 \
--username "$POSTGRES_USER" "$POSTGRES_PASSWRD" \
--dbname "$POSTGRES_DB" <<-EOSQL
EOSQL