FROM debian:buster

# opensslは明示的に書かなくてもいいかも
RUN apt-get update && apt-get install -y nginx openssl

# SSL証明書の作成
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42Tokyo/OU=42cursus/CN=hyunosuk.42.fr"
# ここで設定したパスワードは、nginxの設定ファイルで指定する
# req: 証明書要求を行う
# -x509: X.509証明書を作成する(x509は公開鍵証明書の標準フォーマットの名前)
# -nodes: パスワードなしで秘密鍵を作成する、パスの入力要らずでnginxが起動時に秘密鍵を読み込める
# -days: 有効期限を指定する
# -newkey rsa:2048: RSA暗号で2048ビットの新しい鍵を作成する
# -keyout: 秘密鍵の出力先
# -out: 証明書の出力先
# -subj: 証明書の内容を指定する (C: 国名, ST: 州名, L: 市区町村名, O: 組織名, OU: 組織単位名, CN: Common Name(ドメイン名))


## nginxの設定
# ランタイム中に使用される一時的なファイルの保存先
RUN mkdir -p /run/nginx
# nginxの設定ファイルをコピー
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

# nginxをフォアグラウンドプロセスで実行しないとコンテナが終了してしまう
CMD ["nginx", "-g", "daemon off;"]