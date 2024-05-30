FROM debian:buster

RUN apt-get update && apt-get install -y \
    php7.3-fpm \
    php7.3-mysql \
    mariadb-client \
    wget \
    unzip \
    emacs \
    vim
# php7.3-fpm 管理するツール \
# php7.3-mysqlはPHPからMySQLデータベースに接続するために必要

# 起動時必要
RUN mkdir -p /run/php/
RUN mkdir -p /var/www/html

WORKDIR /var/www/html/wordpress

# testファイル
# TODO: 本番環境では削除する
#COPY test.php /var/www/html/wordpress/test.php

COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY ./conf /etc/php/7.3/fpm/
# 結局CMDと変わらないがENTRYPOINTで実装

ENTRYPOINT ["bash", "/usr/local/bin/entrypoint.sh"]

# php-fpm7.3 -F でフォアグラウンドで実行
# php-fpm7.3はFastCGI Process Manager (FPM) を実行するコマンド
CMD ["php-fpm7.3", "-F"]