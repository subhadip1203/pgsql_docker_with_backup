#!/bin/bash
set -e
set -o pipefail

db_user="$(printenv | grep -E "^POSTGRES_USER" | cut -d "=" -f 2)"
db_password="$(printenv | grep -E "^POSTGRES_PASSWORD" | cut -d "=" -f 2)"
db_name="$(printenv | grep -E "^POSTGRES_DB" | cut -d "=" -f 2)"
cron_time="$(printenv | grep -E "^CRON_INTERVAL" | cut -d "=" -f 2)"
echo "time is : ${cron_time}" 

psql -V
/etc/init.d/postgresql start

# creating user if not exists
if [ "$( psql -tAc "SELECT 1 FROM pg_roles WHERE rolname = '${db_user}' " )" = '1' ]
then
    echo "user already exists"
    psql --command "ALTER USER ${db_user} WITH PASSWORD '${db_password}';"
else
    echo "Creating New user"
    psql --command "CREATE USER ${db_user} WITH ENCRYPTED PASSWORD '${db_password}';"
fi

# creating database if not exists
if [ "$( psql -tAc "SELECT 1 FROM pg_database WHERE datname =  '${db_name}'" )" = '1' ]
then
    echo "Database already exists"
    psql --command "grant all privileges on database ${db_name} to ${db_user};"
else
    echo "Creating new Database "
    psql --command "create database ${db_name};"
    psql --command "grant all privileges on database ${db_name} to ${db_user};"
fi

/etc/init.d/postgresql stop

echo "local all  all             trust" >> /etc/postgresql/12/main/pg_hba.conf
echo "listen_addresses='*'" >> /etc/postgresql/12/main/postgresql.conf


# whoami

# ls -ldh /myFolder/test_folder

# echo "Start cron"
cron
# echo "cron started"

exec "$@"