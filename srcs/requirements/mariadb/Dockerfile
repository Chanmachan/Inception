FROM debian:buster

RUN apt update && apt install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && usermod -d /var/lib/mysql/ mysql \
    && mv /etc/mysql/conf.d/mysql.cnf /etc/mysql/conf.d/00_mysql.cnf \
    && mv /etc/mysql/conf.d/mysqldump.cnf /etc/mysql/conf.d/01_mysqldump.cnf \
    && mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/00_mysqld.cnf \
    && mv /etc/mysql/mysql.conf.d/mysqld_safe_syslog.cnf /etc/mysql/mysql.conf.d/01_mysqld_safe_syslog.cnf
# ファイル名の順に読み込まれるからmvでファイル名を変更して順番を間接的に指定する

EXPOSE 3306

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY ./tools/wordpress.sql /opt/wordpress.sql
RUN chmod +x /opt/wordpress.sql

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]