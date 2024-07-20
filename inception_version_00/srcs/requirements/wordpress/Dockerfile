# choosed base OS
FROM alpine:3.19

# set env value
ENV SERVICE_USER=www

# install for WordPress
RUN apk upgrade --no-cache && \
    apk add --no-cache curl \
                       php81 \
                       php81-curl \
                       php81-phar \
                       php81-fpm \
                       php81-mysqli \
                       php81-iconv \
                       php81-tokenizer \
                       mariadb-client \
                       redis \
                       fcgi && \
    adduser -u 1000 -D -h /var/www ${SERVICE_USER} && \
    chown -R ${SERVICE_USER}:${SERVICE_USER} /var/www

# change work directory
WORKDIR /var/www

# add files to container
ADD --chmod=755 https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

# copy conf-file for setting
COPY --chmod=644 conf/www.conf /etc/php81/php-fpm.d/www.conf
COPY --chmod=755 tools/entrypoint.sh /

# set entrypoint
ENTRYPOINT [ "/entrypoint.sh" ]

# signal
STOPSIGNAL SIGQUIT