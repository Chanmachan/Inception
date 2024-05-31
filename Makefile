# if you want to create your container,
# you have to change LOGIN to your 42 login
# also you have to change .env file in srcs directory
LOGIN=hyunosuk
HOST_NAME=${LOGIN}.42.fr
IP_ADDRESS=127.0.0.1
COMPOSE_FILE=srcs/docker-compose.yml

all: setup up

up:
	docker compose -f ${COMPOSE_FILE} up -d

build:
	docker compose -f ${COMPOSE_FILE} up --build -d

down:
	docker compose -f ${COMPOSE_FILE} down

clean:
	docker compose -f ${COMPOSE_FILE} down
	sudo rm -rf /home/${LOGIN}/data/db
	sudo rm -rf /home/${LOGIN}/data/wordpress

setup:
	@if ! grep -q "${IP_ADDRESS} ${HOST_NAME}" /etc/hosts; then \
		sudo sh -c "echo '${IP_ADDRESS} ${HOST_NAME}' >> /etc/hosts"; \
		echo "Added ${IP_ADDRESS} ${HOST_NAME} in /etc/hosts"; \
	else \
		echo "Already exists ${IP_ADDRESS} ${HOST_NAME} in /etc/hosts"; \
	fi
	sudo mkdir -p /home/${LOGIN}/data/db
	sudo mkdir -p /home/${LOGIN}/data/wordpress

re: clean all

status:
	docker compose -f ${COMPOSE_FILE} ps

.PHONY: all build up down clean setup re status


# for mac
# if you use mac, you have to use this command
# also you have to change VOLUME_PATH in .env file in srcs directory

up_mac: setup_mac
	docker compose -f ${COMPOSE_FILE} up -d

build_mac:
	docker compose -f ${COMPOSE_FILE} up --build -d

down_mac:
	docker compose -f ${COMPOSE_FILE} down

clean_mac:
	docker compose -f ${COMPOSE_FILE} down
	rm -rf ./data/db ./data/wordpress

setup_mac:
	@if ! grep -q "${IP_ADDRESS} ${HOST_NAME}" /etc/hosts; then \
		sudo sh -c "echo '${IP_ADDRESS} ${HOST_NAME}' >> /etc/hosts"; \
		echo "Added ${IP_ADDRESS} ${HOST_NAME} in /etc/hosts"; \
	else \
		echo "Already exists ${IP_ADDRESS} ${HOST_NAME} in /etc/hosts"; \
	fi
	mkdir -p ./data/db
	mkdir -p ./data/wordpress

.PHONY: up_mac build_mac down_mac clean_mac setup_mac