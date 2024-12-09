SERVICES = nginx wordpress mariadb

# Ruta al archivo docker-compose
DOCKER_COMPOSE = srcs/docker-compose.yml

# Comandos básicos
all: up

up:
	@echo "Levantando los contenedores..."
	docker-compose -f $(DOCKER_COMPOSE) up -d

down:
	@echo "Deteniendo los contenedores..."
	docker-compose -f $(DOCKER_COMPOSE) down

stop:
	@echo "Deteniendo los contenedores..."
	@docker-compose -f $(COMPOSE_FILE) stop

destroy:
	@echo "Eliminando contenedores, volúmenes y huérfanos..."
	docker-compose -f $(DOCKER_COMPOSE) down --volumes --remove-orphans

logs:
	@echo "Mostrando logs de los contenedores..."
	docker-compose -f $(DOCKER_COMPOSE) logs

exec_nginx:
	@echo "Abriendo bash en el contenedor nginx..."
	docker-compose -f $(DOCKER_COMPOSE) exec nginx bash

clean:
	@echo "Limpiando imágenes y contenedores..."
	docker-compose -f $(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans

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
	@echo "  make build         Construye las imágenes"
	@echo "  make up            Levanta los contenedores en segundo plano"
	@echo "  make down          Detiene los contenedores"
	@echo "  make destroy       Detiene y elimina contenedores y volúmenes"
	@echo "  make logs          Muestra los logs de los contenedores"
	@echo "  make exec_nginx    Ejecuta un bash dentro del contenedor nginx"
	@echo "  make clean         Elimina todas las imágenes y contenedores"
	@echo "  make prune_volumes Elimina volúmenes persistentes"
	@echo "  make restart       Reinicia los contenedores"
