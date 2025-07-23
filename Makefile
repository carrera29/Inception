SERVICES = nginx wordpwp-php mariadb

DOCKER_COMPOSE = srcs/docker-compose.yml


all: up

up:
	@echo "\033[1;32mstarting containers in detached mode...\033[0m"
	docker-compose -f $(DOCKER_COMPOSE) up -d

down:
	@echo "\033[1;32mstopping and removing containers...\033[0m"
	docker-compose -f $(DOCKER_COMPOSE) down

stop:
	@echo "\033[1;32mstopping containers...\033[0m"
	@docker-compose -f $(DOCKER_COMPOSE) stop

destroy:
	@echo "\033[1;32mstopping and removing containers, volumes, and networks...\033[0m"
	docker-compose -f $(DOCKER_COMPOSE) down --volumes --remove-orphans

ps:
	@echo "\033[1;32mshowing containers...\033[0m"
	docker-compose -f $(DOCKER_COMPOSE) ps

logs:
	@echo "\033[1;32mshowing logs of containers...\033[0m"
	docker-compose -f $(DOCKER_COMPOSE) logs

exec_nginx:
	@echo "\033[1;32mexecuting bash in Nginx container...\033[0m"
	docker-compose -f $(DOCKER_COMPOSE) exec nginx bash

exec_wp:
	@echo "\033[1;32mexecuting bash in WordPress PHP container...\033[0m"
	docker-compose -f $(DOCKER_COMPOSE) exec wordpress bash

exec_mariadb:
	@echo "\033[1;32mexecuting bash in MariaDB container...\033[0m"
	docker-compose -f $(DOCKER_COMPOSE) exec mariadb bash

clean:
	@echo "\033[1;32mcleaning up all containers and images...\033[0m"
	docker-compose -f $(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans

prune_volumes:
	@echo "\033[1;32mremoving all persistent volumes...\033[0m"
	docker volume prune -f

restart:
	@echo "\033[1;32mrestarting containers...\033[0m"
	docker-compose -f $(DOCKER_COMPOSE) down
	docker-compose -f $(DOCKER_COMPOSE) up -d

help:
	@echo "\033[1;34mMakefile options for managing Docker containers:"
	@echo ""
	@echo "  make up            Start containers in detached mode"
	@echo "  make down          Stops and removes containers"
	@echo "  make stop          Stops containers without removing them"
	@echo "  make destroy       Stops and removes containers, volumes, and networks"
	@echo "  make ps            Show containers"
	@echo "  make logs          Show logs of containers"
	@echo "  make exec_nginx    Execute bash in Nginx container"
	@echo "  make exec_wp       Execute bash in WordPress PHP container"
	@echo "  make exec_mariadb  Execute bash in MariaDB container"
	@echo "  make clean         Clean up all containers and images"
	@echo "  make prune_volumes Remove all persistent volumes"
	@echo "  make restart       Restart containers"
	@echo "\033[0m"

