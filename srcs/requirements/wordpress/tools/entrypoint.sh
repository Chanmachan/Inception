if [ -d /var/www/html/wordpress ]; then
    echo "wordpress is already installed"
else
    echo "installing wordpress..."
    wget https://wordpress.org/latest.tar.gz
    tar -xvf latest.tar.gz -C /var/www/html
    rm -rf latest.tar.gz
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