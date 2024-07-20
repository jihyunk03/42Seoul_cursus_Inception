#!/bin/sh

# set shell-script
set -e

# set default permission for new file or directory
umask 0002

# change user to 'www' and execute shell-script
su www

# if WordPress php file does not exists, install WordPress and execute next command
if [ ! -e wp-config.php ]; then
    # install WordPress
    wp core download --path=/var/www \
                     --locale=en_US \
                     --version=6.6
    # create php-file from database setting
    wp config create --force \
                     --skip-check \
                     --dbhost=mariadb \
                     --dbuser=$MYSQL_USER_ID \
                     --dbpass=$MYSQL_USER_PASSWORD \
                     --dbname=$MYSQL_DATABASE
fi

# if WordPress does not exists, install WordPress and execute next command
if ! wp core is-installed; then
    # install WordPress
    wp core download --locale=en_US \
                     --url=${DOMAIN} \
                     --title=Inception \
                     --admin_user=${WP_ADMIN_ID} \
                     --admin_email=${WP_ADMIN_EMAIL} \
                     --admin_password=${WP_ADMIN_PASSWORD}
    wp user create ${WP_USER_ID} \
                   ${WP_USER_EMAIL} \
                   --user_pass=${WP_USER_PASSWORD}
    # wp theme install go --activate --allow-root
fi

if ! wp plugin get redis-cache 2> /dev/null; then
    wp config set WP_REDIS_HOST redis
    wp config set WP_REDIS_PORT 6379
    wp config set WP_REDIS_DATABASE 0
    wp config set WP_CACHE true --raw
    wp plugin install redis-cache --activate --path=/var/www
    wp redis enable
fi

wp core update-db
wp plugin update --all
