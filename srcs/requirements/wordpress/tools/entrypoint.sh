# wordpressをインストールして起動する
echo "Downloading WordPress..."
wget https://wordpress.org/latest.tar.gz
echo "Extracting WordPress..."
tar -xvf latest.tar.gz -C /var/www/html
echo "WordPress setup complete."

# PHP-FPMをフォアグラウンドで実行するため
if pgrep php-fpm7.3 > /dev/null; then
    echo "php-fpm7.3 is already running"
else
    echo "Starting php-fpm7.3..."
    exec php-fpm7.3 -F
fi
# execコマンドはPID1で実行するため、UNIXシグナル(終了シグナル)を受け取りコンテナを適切に扱える
# php-fpm7.3はFastCGI Process Manager (FPM) を実行するコマンド