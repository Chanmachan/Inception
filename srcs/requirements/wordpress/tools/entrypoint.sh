#!/bin/bash

if [ -d /var/www/html/wordpress/wp-config.php ]; then
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
    wp config create --allow-root --path=/var/www/html/wordpress --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST
    echo "installing wordpress..."
    wp core install --allow-root --path=/var/www/html/wordpress --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL
fi

# PHP-FPMをフォアグラウンドで実行するため
if pgrep php-fpm7.3 > /dev/null; then
    echo "php-fpm7.3 is already running"
else
    echo "Starting php-fpm7.3..."
    # -FはPHP-FPMをフォアグラウンドで実行するため
    exec php-fpm7.3 -F
    # execはPID1で実行するため、UNIXシグナル(終了シグナル)を受け取りコンテナを適切に扱える
    # php-fpm7.3はFastCGI Process Manager (FPM) を実行するコマンド
fi