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

whoami

ls -ldh /myFolder/db_backup 

# echo "Start cron"
# cron
# echo "cron started"

# echo "" >> /etc/cron.d/crontab 

# chmod 0644 /etc/cron.d/crontab 
# /usr/bin/crontab /etc/cron.d/crontab 
# cron

### cron jobs 
# printenv | grep -E "^POSTGRES_" > /etc/cron.d/crontab
# echo "" >> /etc/cron.d/crontab
# echo "${cron_time} echo 'HELLO WORLD ...' > /proc/1/fd/1 2>/proc/1/fd/2" >> /etc/cron.d/crontab

# chmod 0644 /etc/cron.d/crontab 
# /usr/bin/crontab /etc/cron.d/crontab 
# cron -f


exec "$@"


