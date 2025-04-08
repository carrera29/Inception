#!/bin/bash

# Comprobar si MariaDB ya está inicializado (miramos la tabla del sistema)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Inicializando base de datos..."
    mysql_install_db

    # Iniciar MariaDB en segundo plano
    mysqld_safe &

    sleep 5

    echo "Configurando base de datos y usuario..."
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD';
GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

wait

else
    echo "Base de datos ya inicializada, arrancando MariaDB..."
    mysqld_safe
fi


