#!/bin/bash
set -e
set -o pipefail

db_user="$(printenv | grep -E "^POSTGRES_USER" | cut -d "=" -f 2)"
db_password="$(printenv | grep -E "^POSTGRES_PASSWORD" | cut -d "=" -f 2)"
db_name="$(printenv | grep -E "^POSTGRES_DB" | cut -d "=" -f 2)"

echo "" >> /etc/cron.d/crontab2
echo "export PGPASSWORD=${db_password}" >> /etc/cron.d/crontab2

printenv | grep -E "^POSTGRES_" > /myFolder/project_env.sh 

cat /myFolder/project_env.sh  /myFolder/crontab > /etc/cron.d/crontab

# cat /myFolder/crontab >> /etc/cron.d/crontab

chmod 0644 /etc/cron.d/crontab 
/usr/bin/crontab /etc/cron.d/crontab 
cron -f

# /usr/local/bin/python /app/project/run.py