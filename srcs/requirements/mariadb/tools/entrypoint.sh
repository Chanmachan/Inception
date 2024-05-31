#!/bin/bash

######################function######################
timeout=30
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
####################################################

set -e

# mysqlのデータベースがない場合、初期設定
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "setting mariadb for the first time..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo "done setting mariadb"
else
    echo "mariadb is already installed"
fi

# サーバーを起動
mysqld &
wait_server_start
# サーバーが起動している->設定   していない->exit
# rootユーザーのパスワードを設定
# データベース、ユーザー、権限を設定をまとめてしまった
if ! mysql -u root -h"${MYSQL_HOST}" -p"${MYSQL_ROOT_PASSWORD}" -e "USE ${WORDPRESS_DB_NAME}" --silent; then
  # TODO: "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';"はワイルドカードではなくmariadbとかでもいいかも
  mysql -u root << EOF
  CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
  GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
  CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};
  CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_USER_PASSWORD}';
  GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_DB_USER}'@'%';
  FLUSH PRIVILEGES;
EOF
fi
# サーバーを停止
mysqladmin shutdown
echo "done settings"

exec "$@"