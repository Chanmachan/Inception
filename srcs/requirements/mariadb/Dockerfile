FROM debian:buster

RUN apt update && apt install -y \
    mariadb-server \
    emacs \
    procps \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld
RUN mkdir -p /var/lib/mysqld
#RUN mv /etc/mysql/conf.d/mysql.cnf /etc/mysql/conf.d/00_mysql.cnf
#RUN mv /etc/mysql/conf.d/mysqldump.cnf /etc/mysql/conf.d/01_mysqldump.cnf
#RUN mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/00_mysqld.cnf
#RUN mv /etc/mysql/mysql.conf.d/mysqld_safe_syslog.cnf /etc/mysql/mysql.conf.d/01_mysqld_safe_syslog.cnf
# ファイル名の順に読み込まれるからmvでファイル名を変更して順番を間接的に指定する
# chownコマンドはファイルやディレクトリの所有者を変更する -Rオプションはディレクトリ内のファイルの所有者も変更する

EXPOSE 3306

COPY ./conf/my.cnf /etc/mysql/my.cnf
#COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["mysqld"]