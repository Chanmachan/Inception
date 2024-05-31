FROM debian:buster

# opensslは明示的に書かなくてもいいかも
# gettextはnginxの設定ファイルで環境変数を使うために必要
RUN apt-get update && apt-get install -y nginx openssl gettext procps netcat

## nginxの設定
# ランタイム中に使用される一時的なファイルの保存先
RUN mkdir -p /run/nginx
# nginxの設定ファイルのテンプレートをコピー
COPY conf/template-nginx.conf /etc/nginx/template-nginx.conf

EXPOSE 443

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# nginxをフォアグラウンドプロセスで実行しないとコンテナが終了してしまう
CMD ["nginx", "-g", "daemon off;"]