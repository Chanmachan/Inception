HOST_NAME=hyunosuk.42.fr
IP_ADDRESS=127.0.0.1

all: setup
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
	sudo chown -R mysql:mysql /home/hyunosuk/data

re: clean all
