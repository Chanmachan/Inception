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

WORKDIR /var/www/html

COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY ./conf /etc/php/7.3/fpm/
# 結局CMDと変わらないがENTRYPOINTで実装

ENTRYPOINT ["bash", "/usr/local/bin/entrypoint.sh"]