#!/bin/sh

# Variables de entorno provenientes del archivo .env
DB_NAME=${MYSQL_DATABASE}
DB_USER=${MYSQL_USER}
DB_PASSWORD=${MYSQL_PASSWORD}
ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}

# Verifica que todas las variables necesarias estén definidas
if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ] || [ -z "$ROOT_PASSWORD" ]; then
    echo "ERROR: Faltan variables de entorno necesarias."
    exit 1
fi

# Inicializa el sistema de directorios de MariaDB si es la primera vez
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Inicializando directorios de MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

# Inicia MariaDB en segundo plano
mysqld_safe --datadir=/var/lib/mysql &
pid="$!"

# Espera que MariaDB esté listo
echo "Esperando que MariaDB esté listo..."
while ! mysqladmin ping --silent; do
    sleep 1
done

# Comandos SQL para inicializar la base de datos
echo "Configurando la base de datos y el usuario..."
mysql -uroot <<EOF
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${ROOT_PASSWORD}');
DELETE FROM mysql.user WHERE User='';
CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Detenemos el servidor MariaDB en segundo plano
kill "$pid"
wait "$pid"

# Reiniciamos MariaDB en primer plano
exec mysqld_safe --datadir=/var/lib/mysql