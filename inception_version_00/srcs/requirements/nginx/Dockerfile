# choosed base OS
FROM alpine:3.19

# install nginx openssl
RUN apk upgrade --no-cache && \
    apk add --no-cache openssl \
                       nginx \
                       curl && \
    adduser -u 1000 -D -h /var/www www && \
    chown -R www:www /var/www

# copy conf-file for setting
COPY --chmod=644 conf/nginx.conf /etc/nginx/nginx.conf

# set entrypoint
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]

# signal
STOPSIGNAL SIGQUIT