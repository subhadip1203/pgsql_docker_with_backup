#!/bin/bash
export PGPASSWORD=MyPassword
echo "Cron service start..."

whoami
ls -ldh /myFolder/test_folder
ls -ldh /var/lib/postgresql/data
pg_dump -Fc -U myuser -h localhost -d my_pg_db > /myFolder/test_folder/dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

