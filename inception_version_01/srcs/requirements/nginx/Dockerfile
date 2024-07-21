# choosed base OS
FROM debian:bullseye

# install required-packages and optimize images
RUN apt-get update && \
    apt-get install -y nginx \
                       openssl \
                       curl \
                       dumb-init && \
    rm -rf /var/lib/apt/lists/*

# create self-signed certificate
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/jihykim2.crt \
    -keyout /etc/nginx/ssl/jihykim2.key \
    -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=jihykim2/CN=jihykim2/"

# copy for configuration
COPY ./conf/nginx.conf /etc/nginx/conf.d

# make folder to execute nginx
RUN mkdir -p /run/nginx

# set entrypoint for pid 1
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# execute nginx
CMD ["nginx", "-g", "daemon off;"]
