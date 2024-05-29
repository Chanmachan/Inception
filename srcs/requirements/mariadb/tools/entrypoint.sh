#!/bin/bash

set -e

chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /var/run/mysqld
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "setting mariadb for the first time..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo "done setting mariadb"
else
    echo "mariadb is already installed"
fi

timeout=30
mysqld &
wait_server_start() {
  while ! mysqladmin ping -u root --silent; do
  sleep 1
  timeout=$((timeout-1))
  if [ "$timeout" -le 0 ]; then
    echo "timeout"
    exit 1
  fi
  echo "server started successfully"
  done
}

wait_server_start

mysqladmin shutdown

echo "done settings"

exec "$@"