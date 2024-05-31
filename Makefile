HOST_NAME=hyunosuk.42.fr
IP_ADDRESS=127.0.0.1
TMP_MYSQL_UID=$$(id -u mysql)
TMP_MYSQL_GID=$$(id -g mysql)

all: setup
	export MYSQL_UID=${TMP_MYSQL_UID}  # ホストのmysqlユーザーのUIDを取得
	export MYSQL_GID=${TMP_MYSQL_GID}  # ホストのmysqlユーザーのGIDを取得
	docker-compose -f srcs/docker-compose.yml up

clean:
	docker-compose -f srcs/docker-compose.yml down
	rm -rf /home/hyunosuk/data/db
	rm -rf /home/hyunosuk/data/wordpress

setup:
	@if ! grep -q "${IP_ADDRESS} ${HOST_NAME}" /etc/hosts; then \
		sudo sh -c "echo '${IP_ADDRESS} ${HOST_NAME}' >> /etc/hosts"; \
	else \
		echo "Already exists ${IP_ADDRESS} ${HOST_NAME} in /etc/hosts"; \
	fi
	sudo mkdir -p /home/hyunosuk/data/db
	sudo mkdir -p /home/hyunosuk/data/wordpress
	@sudo id -u mysql >/dev/null 2>&1 || sudo useradd -r -s /bin/false mysql  # mysqlユーザーが存在しない場合に作成
	@sudo getent group mysql >/dev/null || sudo groupadd mysql  # mysqlグループが存在しない場合に作成
	@sudo usermod -a -G mysql mysql  # mysqlユーザーをmysqlグループに追加
	sudo chown -R mysql:mysql /home/hyunosuk/data
#	echo "\nMYSQL_UID=${TMP_MYSQL_UID}" >> srcs/.env
#	echo "MYSQL_GID=${TMP_MYSQL_GID}" >> srcs/.env


re: clean all