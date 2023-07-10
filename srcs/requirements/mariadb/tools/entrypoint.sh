#!/bin/sh
set -e

# check if database exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "hoge"
  ## Set mariadb data directory
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
  # --userはmysqldを実行するユーザーを指定するオプション
  # --datadirはMariaDBのデータディレクトリへのパス

fi