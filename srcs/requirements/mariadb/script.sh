#!/bin/bash

source /etc/environment

# Inicializar base de datos
mysql_install_db

# Iniciar servicio de MariaDB en segundo plano
mysqld_safe &

sleep 5

# Crear base de datos y usuario con las variables de entorno
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD';
GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

wait
