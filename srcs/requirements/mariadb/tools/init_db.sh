#!/bin/sh

# Esperar a que MariaDB inicie
until mariadb -hlocalhost -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SELECT 1" > /dev/null 2>&1; do
    echo "Esperando a que MariaDB inicie..."
    sleep 2
done

echo "MariaDB iniciado. Creando base de datos y usuarios..."

# Crear base de datos y usuarios
mariadb -hlocalhost -uroot -p"$MYSQL_ROOT_PASSWORD" << EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON wordpress.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

echo "Base de datos y usuarios creados exitosamente."

# Mantener el contenedor en ejecución
exec mysqld_safe