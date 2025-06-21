SERVICES = nginx wordpwp-php mariadb

DOCKER_COMPOSE = srcs/docker-compose.yml



all: up

up:
	@echo "Levantando los contenedores..."
	docker-compose -f $(DOCKER_COMPOSE) up -d

down:
	@echo "Deteniendo los contenedores..."
	docker-compose -f $(DOCKER_COMPOSE) down

stop:
	@echo "Deteniendo los contenedores..."
	@docker-compose -f $(DOCKER_COMPOSE) stop

destroy:
	@echo "Eliminando contenedores, volúmenes y huérfanos..."
	docker-compose -f $(DOCKER_COMPOSE) down --volumes --remove-orphans

ps:
	@echo "Mostrando los contenedores..."
	docker-compose -f $(DOCKER_COMPOSE) ps

logs:
	@echo "Mostrando logs de los contenedores..."
	docker-compose -f $(DOCKER_COMPOSE) logs

exec_nginx:
	@echo "Abriendo bash en el contenedor nginx..."
	docker-compose -f $(DOCKER_COMPOSE) exec nginx bash

exec_wp:
	docker-compose -f $(DOCKER_COMPOSE) exec wp-php bash

exec_mariadb:
	docker-compose -f $(DOCKER_COMPOSE) exec mariadb bash

clean:
	@echo "Limpiando imágenes y contenedores..."
	docker-compose -f $(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans
	rm -rf /etc/nginx/ssl/*
	rm -rf ./srcs/web ./srcs/data

prune_volumes:
	@echo "Eliminando volúmenes persistentes..."
	docker volume prune -f

restart:
	@echo "Reiniciando los contenedores..."
	docker-compose -f $(DOCKER_COMPOSE) down
	docker-compose -f $(DOCKER_COMPOSE) up -d

help:
	@echo -e "\033[1;34mMakefile para gestionar los contenedores Docker\033[0m"
	@echo ""
	@echo -e "\033[1;32mUso:\033[0m"
	@echo "  make up            Levanta los contenedores en segundo plano"
	@echo "  make down          Detiene los contenedores"
	@echo "  make destroy       Detiene y elimina contenedores y volúmenes"
	@echo "  make ps          	Muestra los contenedores"
	@echo "  make logs          Muestra los logs de los contenedores"
	@echo "  make exec_nginx    Ejecuta un bash dentro del contenedor nginx"
	@echo "  make clean         Elimina todas las imágenes y contenedores"
	@echo "  make prune_volumes Elimina volúmenes persistentes"
	@echo "  make restart       Reinicia los contenedores"
