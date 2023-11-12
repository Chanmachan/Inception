FROM debian:buster

RUN apt-get update && apt-get install -y \
    php7.3-fpm \
    php7.3-mysql \
    wget \
    unzip \
    emacs \
    vim
# php7.3-fpm 管理するツール \
# php7.3-mysqlはPHPからMySQLデータベースに接続するために必要

COPY ./test.php ./tmp/
COPY ./tools/docker-entrypoint.sh ./
COPY ./conf ./etc/php/7.3/fpm/
CMD ["bash", "docker-entrypoint.sh"]