# FROM ubuntu:20.04

# WORKDIR /myFolder
# COPY ./start.sh /myFolder/start.sh

# RUN apt-get update \
#     && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata gnupg wget  ca-certificates \
#     && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -\
#     && echo "deb http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list \    
#     && apt-get update \
#     && apt-get install -y postgresql postgresql-contrib \
#     && apt-get -y --purge autoremove \
#     && apt-get clean\     
#     && apt-get update \ 
#     && chmod +x /myFolder/start.sh



# https://docs.docker.com/samples/postgresql_service/
# docker build  -t ubuntu_pgsql12:1 .
# docker run -d ubuntu_pgsql12:1 -e USER_ENV=U1




FROM ubuntu:20.04

WORKDIR /myFolder
COPY ./start.sh /myFolder/start.sh

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata cron\
    && apt-get update \
    && apt-get install -y postgresql postgresql-contrib \
    && apt-get -y --purge autoremove \
    && apt-get clean\     
    && apt-get update \ 
    && chmod +x /myFolder/start.sh 
   

USER postgres
 
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

ENTRYPOINT ["/myFolder/start.sh"]

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/12/bin/postgres", "-D", "/var/lib/postgresql/12/main", "-c", "config_file=/etc/postgresql/12/main/postgresql.conf"]

