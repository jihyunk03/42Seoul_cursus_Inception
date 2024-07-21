#!/bin/bash

# start MySQL service
service mariadb start

# wait for MySQL to be ready
until mariadb-admin ping &>/dev/null; do
  echo "Waiting for MariaDB to be ready..."
  sleep 2
done

# prepare the initial SQL script
cat <<EOF > /var/www/initial.sql
  CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
  CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
  GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
  FLUSH PRIVILEGES;
  ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
EOF

# execute the initial SQL script with the root password
mariadb -uroot -p"$MYSQL_ROOT_PASSWORD" < /var/www/initial.sql
