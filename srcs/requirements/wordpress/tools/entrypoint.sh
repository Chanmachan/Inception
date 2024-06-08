#!/bin/bash

# mariadbコンテナが起動したか確認
timeout=30
while ! mariadb -h$MYSQL_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_USER_PASSWORD 2>/dev/null; do
  echo "waiting for mariadb to start..."
  sleep 1
  timeout=$((timeout-1))
  if [ "$timeout" -le 0 ]; then
    echo "timeout"
    exit 1
  fi
done


if [ -e /var/www/html/wordpress/wp-config.php ]; then
    echo "wordpress is already installed"
else
    echo "setting wordpress..."
    # wp-cliを使ってwordpressをインストールする
    wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    chmod +x /usr/local/bin/wp
    wp core download --allow-root --path=/var/www/html/wordpress
    echo "creating wp-config.php ..."
    wp config create --allow-root \
                    --path=/var/www/html/wordpress \
                    --dbname=$WORDPRESS_DB_NAME \
                    --dbuser=$WORDPRESS_DB_USER \
                    --dbpass=$WORDPRESS_DB_USER_PASSWORD \
                    --dbhost=$MYSQL_HOST
    echo "installing wordpress..."
    wp core install --allow-root \
                    --path=/var/www/html/wordpress \
                    --url=$DOMAIN_NAME \
                    --title=$WORDPRESS_TITLE \
                    --admin_user=$WORDPRESS_ADMIN_USER \
                    --admin_password=$WORDPRESS_ADMIN_PASSWORD \
                    --admin_email=$WORDPRESS_ADMIN_EMAIL
    echo "creating general user..."
    wp user create  --allow-root \
                      $WORDPRESS_USER \
                      $WORDPRESS_USER_EMAIL \
                    --role=$WORDPRESS_USER_ROLE \
                    --user_pass=$WORDPRESS_USER_PASSWORD


    chown -R www-data:www-data /var/www/html/wordpress
    # TODO: 本番環境では削除
#    chmod 755 /var/www/html/wordpress/test.php
fi

exec "$@"