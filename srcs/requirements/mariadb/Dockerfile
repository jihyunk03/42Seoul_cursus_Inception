# choose base OS
FROM alpine:3.19

# install mariadb
RUN apk upgrade --no-cache && \
    apk add --no-cache mariadb \
                       mariadb-client && \
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

# change work directory
WORKDIR /var/lib/mysql

# copy conf-file for setting
COPY --chmod=644 ./conf/my.cnf /etc/my.cnf
COPY --chmod=644 ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY --chmod=755 ./tools/init_db.sh /

# set entrypoint
ENTRYPOINT [ "/init_db.sh" ]

# start db
CMD [ "mariadb-safe" ]

# signal
STOPSIGNAL SIGQUIT
