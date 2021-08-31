#!/bin/bash
set -e
set -o pipefail

db_user="$(printenv | grep -E "^POSTGRES_USER" | cut -d "=" -f 2)"
db_password="$(printenv | grep -E "^POSTGRES_PASSWORD" | cut -d "=" -f 2)"
db_name="$(printenv | grep -E "^POSTGRES_DB" | cut -d "=" -f 2)"

psql -V

psql --command "CREATE USER ${db_user} WITH SUPERUSER PASSWORD '${db_password}';"

createdb -O ${db_user} ${db_name}

/etc/init.d/postgresql start