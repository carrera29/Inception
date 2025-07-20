#!/bin/bash

MYSQL_USER_PASSWORD=$(cat /run/secrets/db_password.txt)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password.txt)
MYSQL_USER=$(cat /run/secrets/db_credentials.txt)

# Espera a que MariaDB esté listo
mysqld_safe --skip-networking &
sleep 5

mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};"
mariadb -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';"
mariadb -u root -e "GRANT ALL ON ${DATABASE_NAME}.* TO '${MYSQL_USER}'@'%';"
mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mariadb -u root -e "ALTER USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mariadb -u root -e "FLUSH PRIVILEGES;"

mysqladmin shutdown -u root -p"$MYSQL_ROOT_PASSWORD"

mysqld --bind-address=0.0.0.0 --port=3306 --user=root

