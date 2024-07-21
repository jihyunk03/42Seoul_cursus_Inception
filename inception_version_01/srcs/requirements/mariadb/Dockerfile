# choosed base OS
FROM debian:bullseye

# get env values at build-time
ARG MYSQL_HOSTNAME
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

# install required-packages and optimize images
RUN apt-get update && \
    apt-get install -y mariadb-server \
                       dumb-init && \
    rm -rf /var/lib/apt/lists/*

# copy init-db for setting mariadb
COPY ./tools/init-db.sh /var/www/init-db.sh

# run init shell-script
RUN chmod +x /var/www/init-db.sh && \
    /var/www/init-db.sh

# set entrypoint for pid 1 and execute next process(sh)
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# execute mariadb
CMD [ "mysqld", "--bind-address=0.0.0.0" ]
