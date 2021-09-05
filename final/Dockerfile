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




FROM pgsql-ubuntu:1.0.0

WORKDIR /myFolder
COPY ./start.sh /myFolder/start.sh
COPY ./restart.sh /myFolder/restart.sh

RUN usermod -aG root postgres \
    && chown -R postgres:root /myFolder \
    && chmod +x /myFolder/start.sh \   
    && chmod +x /myFolder/restart.sh \  
    # && mkdir /myFolder/db_backup \
    # && chgrp -R common /myFolder/db_backup \
    # && ls -ldh /myFolder/db_backup \
    && echo "* * * * * /myFolder/restart.sh > /proc/1/fd/1 2>&1" >> /etc/cron.d/restart-cron \
    && crontab -u postgres /etc/cron.d/restart-cron \
    && chmod u+s /usr/sbin/cron

USER postgres

RUN mkdir /myFolder/db_backup \
    && ls -ldh /myFolder/db_backup 
 
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql" , "/myFolder/db_backup"]


ENTRYPOINT ["/myFolder/start.sh"]

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/12/bin/postgres", "-D", "/var/lib/postgresql/12/main", "-c", "config_file=/etc/postgresql/12/main/postgresql.conf"]

