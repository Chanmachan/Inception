FROM debian:buster

RUN apt-get update && apt-get install -y \
    mariadb-server \
    emacs \
    procps \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql
# 所有権を変更user:group
# 他のユーザーがデータベースを操作できないようにするため
# ファイル名の順に読み込まれるからmvでファイル名を変更して順番を間接的に指定する
# chownコマンドはファイルやディレクトリの所有者を変更する -Rオプションはディレクトリ内のファイルの所有者も変更する

EXPOSE 3306

COPY ./conf/my.cnf /etc/mysql/my.cnf
#COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["mysqld"]