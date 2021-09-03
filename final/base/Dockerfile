FROM ubuntu:20.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata cron nano\
    && apt-get update \
    && apt-get install -y postgresql postgresql-contrib \
    && apt-get -y --purge autoremove \
    && apt-get clean\     
    && apt-get update 


#   docker build  -t pgsql-ubuntu:1.0.0 .