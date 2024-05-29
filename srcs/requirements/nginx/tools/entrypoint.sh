#!/bin/bash

set -e

# 環境変数をテンプレートに反映して、設定ファイルを生成
envsubst '$$DOMAIN_NAME' < /etc/nginx/template-nginx.conf > /etc/nginx/nginx.conf

exec "$@"