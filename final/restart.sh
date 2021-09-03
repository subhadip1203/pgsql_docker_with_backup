#!/bin/bash

echo "Cron service start..."

whoami
ls -ldh /myFolder/db_backup

# ...
pg_dump  -U myuser my_pg_db > /myFolder/db_backup/dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

echo "Cron service end..."
