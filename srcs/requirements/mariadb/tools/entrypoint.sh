#!/bin/bash

set -e

mysqld &
wait_server_start() {
  timeout=30
  while ! mysqladmin ping -u root --silent; do
  sleep 1
  timeout=$((timeout-1))
  if ["$timeout" -le 0]; then
    echo "server could not start"
    exit 1
  fi
  echo "server started successfully"
  done
}

chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /var/run/mysqld
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "setting mariadb for the first time..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo "done setting mariadb"
else
    echo "mariadb is already installed"
fi

# サーバーをバックグラウンドで実行
mysqld &
# サーバーが起動するまで待つ
echo "waiting for server to start..."
wait_server_start
mysqladmin shutdown

echo "done settings"

exec "$@"