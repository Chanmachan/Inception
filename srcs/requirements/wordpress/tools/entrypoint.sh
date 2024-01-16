# PHP-FPMをフォアグラウンドで実行するため
exec php-fpm7.3 -F
# execコマンドはPID1で実行するため、UNIXシグナル(終了シグナル)を受け取りコンテナを適切に扱える
# php-fpm7.3はFastCGI Process Manager (FPM) を実行するコマンド