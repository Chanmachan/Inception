#!/bin/bash

set -e

# 環境変数をテンプレートに反映して、設定ファイルを生成
envsubst '$$DOMAIN_NAME' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

exec "$@"