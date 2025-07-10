#!/bin/bash

# Lee las contraseñas desde los Docker secrets
MYSQL_USER_PASSWORD=$(cat /run/secrets/db_password.txt)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password.txt)
MYSQL_USER=$(cat /run/secrets/db_credentials.txt)

# Inicializa el servidor MariaDB y crea base de datos y usuarios
service mariadb start
mariadb -e "CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME}"
mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}'"
mariadb -e "GRANT ALL ON ${DATABASE_NAME}.* TO '${MYSQL_USER}'@'%';"
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mariadb -e "ALTER USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mariadb -e "FLUSH PRIVILEGES;"
mysqladmin shutdown -u root
mysqld --bind-address=0.0.0.0 --port=3306 --user=root
