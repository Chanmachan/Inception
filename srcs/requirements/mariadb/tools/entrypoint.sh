#!/bin/bash

set -e

# mysqlのデータベースがない場合、初期設定
if [ -d /var/lib/mysql/mysql ]; then
    echo "mariadb is already installed"
else
    echo "setting mariadb for the first time..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    cat <<EOF > /tmp/input.txt
USE mysql;
FLUSH PRIVILEGES;
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost';

CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};
CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
      # bootstrapで初期設定
    mysqld --user=mysql --bootstrap < /tmp/input.txt

    rm /tmp/input.txt

    echo "done setting mariadb"
fi

exec "$@"