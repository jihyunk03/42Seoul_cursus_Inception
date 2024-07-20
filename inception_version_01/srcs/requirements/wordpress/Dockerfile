# choosed base OS
FROM debian:buster

# install required-packages and optimize images
RUN apt-get update && \
    apt-get -y install wget curl bash libfcgi-bin \
                       php php-cgi php-mysql php-fpm php-pdo php-gd php-cli php-mbstring \
                       dumb-init && \
    rm -rf /var/lib/apt/lists/*

# download wp-cli and change directory
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# copy for configuration
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

# make folder to execute php-fpm7.3
RUN mkdir /run/php

# download wordpress
COPY ./tools/init-wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init-wp.sh

# set entrypoint for pid 1 and execute next process(sh)
ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/bin/init-wp.sh"]

# change work directory
WORKDIR /var/www/html/

# execute php-fpm7.3
CMD ["/usr/sbin/php-fpm7.3", "-F"]
