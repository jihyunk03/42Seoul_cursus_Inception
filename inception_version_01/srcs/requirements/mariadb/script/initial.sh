#!/bin/bash

# Start MySQL service
service mysql start

# Wait for MySQL to be ready
until mysqladmin ping &>/dev/null; do
  echo "Waiting for MySQL to be ready..."
  sleep 2
done

# Prepare the initial SQL script
cat <<EOF > /var/www/initial.sql
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
EOF

# Execute the initial SQL script with the root password
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" < /var/www/initial.sql
