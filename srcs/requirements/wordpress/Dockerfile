FROM debian:buster

RUN apt-get update && apt-get install -y \
    php7.3-fpm \
    php7.3-mysql \
    wget \
    unzip
# php7.3-fpm 管理するツール \
# php7.3-mysqlはPHPからMySQLデータベースに接続するために必要

RUN mkdir /run/php
COPY ./test.php ./tmp/
COPY ./tools/docker-entrypoint.sh ./
CMD ["bash", "docker-entrypoint.sh"]