FROM python:3.8

# set work directory
WORKDIR /myFolder

COPY ./app/ /myFolder/app/
COPY ./start.sh /myFolder/start.sh
COPY ./dbBackup.sh /myFolder/dbBackup.sh
COPY ./crontab /myFolder/crontab

RUN  apt-get update && apt-get -y install cron nano && chmod +x /myFolder/start.sh

CMD ["/myFolder/start.sh"]