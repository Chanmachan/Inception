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

RUN mkdir -p /run/php/
COPY ./test.php ./var/www/html/

COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY ./conf ./etc/php/7.3/fpm/
CMD ["bash", "/usr/local/bin/entrypoint.sh"]