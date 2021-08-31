FROM ubuntu:20.04

WORKDIR /myFolder
COPY ./start.sh /myFolder/start.sh

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata gnupg wget  ca-certificates \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -\
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list \    
    && apt-get update \
    && apt-get install -y postgresql postgresql-contrib \
    && apt-get -y --purge autoremove \
    && apt-get clean\     
    && apt-get update \ 
    && chmod +x /myFolder/start.sh

USER postgres

EXPOSE 5432

CMD ["/myFolder/start.sh"]


# https://docs.docker.com/samples/postgresql_service/
# docker build  -t ubuntu_pgsql12:1 .
# docker run -d ubuntu_pgsql12:1 -e USER_ENV=U1




# FROM ubuntu:20.04

# RUN apt-get update \
#     && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata cron\
#     && apt-get update \
#     && apt-get install -y postgresql postgresql-contrib \
#     && psql --version
# && sh -c "echo \"deb http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main\" > /etc/apt/sources.list.d/pgdg.list" \
# USER postgres

# CMD ["psql -V"]


