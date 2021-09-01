#!/bin/bash
set -e
set -o pipefail

db_user="$(printenv | grep -E "^POSTGRES_USER" | cut -d "=" -f 2)"
db_password="$(printenv | grep -E "^POSTGRES_PASSWORD" | cut -d "=" -f 2)"
db_name="$(printenv | grep -E "^POSTGRES_DB" | cut -d "=" -f 2)"

psql -V
/etc/init.d/postgresql start

# creating new user and its password
psql --command "CREATE USER ${db_user} WITH ENCRYPTED PASSWORD '${db_password}';"

# creating new database for the user
psql --command "create database ${db_name};"
psql --command "grant all privileges on database ${db_name} to ${db_user};"

/etc/init.d/postgresql stop

exec "$@"


