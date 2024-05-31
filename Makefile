HOST_NAME=hyunosuk.42.fr
IP_ADDRESS=127.0.0.1
# TODO: docker compose??

all: setup
	docker-compose -f srcs/docker-compose.yml up

clean:
	docker-compose -f srcs/docker-compose.yml down
	sudo rm -rf /home/hyunosuk/data/db
	sudo rm -rf /home/hyunosuk/data/wordpress

setup:
	@if ! grep -q "${IP_ADDRESS} ${HOST_NAME}" /etc/hosts; then \
		sudo sh -c "echo '${IP_ADDRESS} ${HOST_NAME}' >> /etc/hosts"; \
	else \
		echo "Already exists ${IP_ADDRESS} ${HOST_NAME} in /etc/hosts"; \
	fi
	sudo mkdir -p /home/hyunosuk/data/db
	sudo mkdir -p /home/hyunosuk/data/wordpress

re: clean all