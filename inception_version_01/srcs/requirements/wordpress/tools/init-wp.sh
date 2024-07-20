#!/bin/sh

if [ -f ./wp-config.php ]
then
    # if wp-config existed, print error
    echo "err: wp-config exists"
else
    wget http://wordpress.org/latest.tar.gz
    tar xfz latest.tar.gz
    mv wordpress/* .
    rm -rf latest.tar.gz
    rm -rf wordpress

    sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
    sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
    cp wp-config-sample.php wp-config.php

    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    wp core install --url=$DOMAIN_NAME \
                    --title="Hello~~ Nice to meet you~~" \
                    --admin_user=$WP_ROOT_USERNAME \
                    --admin_password=$WP_ROOT_PASSWORD \
                    --admin_email="ksk2081@naver.com" \
                    --allow-root
    wp user create $WP_USERNAME jihykim2@student.42seoul.kr \
                    --user_pass=$WP_PASSWORD \
                    --allow-root
fi

exec "$@"