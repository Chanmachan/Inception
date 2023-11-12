#!/bin/sh
set -e

# check if database exist
if [ -d "/var/lib/mysql/mysql" ]; then
  echo "Database already exist"
else
  echo "Setting up mariadb database for the first time"
  ## Set mariadb data directory
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
  # --userはmysqldを実行するユーザーを指定するオプション
  # --datadirはMariaDBのデータディレクトリへのパス
fi