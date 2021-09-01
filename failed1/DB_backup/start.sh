#!/bin/bash
set -e
set -o pipefail

db_user="$(printenv | grep -E "^POSTGRES_USER" | cut -d "=" -f 2)"
db_password="$(printenv | grep -E "^POSTGRES_PASSWORD" | cut -d "=" -f 2)"
db_name="$(printenv | grep -E "^POSTGRES_DB" | cut -d "=" -f 2)"

echo "" >> /myFolder/dbBackup_part2.sh
echo "export PGPASSWORD=${db_password}" >> /myFolder/dbBackup_part2.sh
echo "export PGPASSWORD=${db_password}" >> /myFolder/dbBackup_part2.sh

pg_dump name_of_database > name_of_backup_file

### cron jobs 
printenv | grep -E "^POSTGRES_" > /myFolder/project_env.sh 
cat /myFolder/project_env.sh  /myFolder/crontab > /etc/cron.d/crontab


chmod 0644 /etc/cron.d/crontab 
/usr/bin/crontab /etc/cron.d/crontab 
cron -f

# /usr/local/bin/python /app/project/run.py