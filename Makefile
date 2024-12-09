# Nombre de los servicios en el archivo docker-compose
SERVICES = nginx wordpress mariadb

# Ruta al archivo docker-compose
DOCKER_COMPOSE = /srcs/docker-compose.yml

# El comando para construir las imágenes
build:
	docker-compose -f $(DOCKER_COMPOSE) build

# El comando para levantar los contenedores
up:
	docker-compose -f $(DOCKER_COMPOSE) up -d

# El comando para detener los contenedores
down:
	docker-compose -f $(DOCKER_COMPOSE) down

# El comando para detener y eliminar contenedores
destroy:
	docker-compose -f $(DOCKER_COMPOSE) down --volumes --remove-orphans

# El comando para ejecutar los tests
logs:
	docker-compose -f $(DOCKER_COMPOSE) logs

# Para ejecutar cualquier comando dentro de el contenedor nginx
exec_nginx:
	docker-compose exec nginx bash

# Eliminar todas las imágenes y contenedores
clean:
	docker-compose -f $(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans

# Eliminar volúmenes persistentes
prune_volumes:
	docker volume prune -f

# Ayuda
help:
	@echo "Makefile para gestionar los contenedores Docker"
	@echo ""
	@echo "Uso:"
	@echo "  make build       Construye las imágenes"
	@echo "  make up          Levanta los contenedores en segundo plano"
	@echo "  make down        Detiene los contenedores"
	@echo "  make destroy     Detiene y elimina contenedores y volúmenes"
	@echo "  make logs        Muestra los logs de los contenedores"
	@echo "  make exec_nginx  Ejecuta un bash dentro del contenedor nginx"
	@echo "  make clean       Elimina todas las imágenes y contenedores"
	@echo "  make prune_volumes Elimina volúmenes persistentes"
	@echo "  make help        Muestra este mensaje"
