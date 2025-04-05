#!/bin/bash

if [ ! -d /var/www/html ]; then
  mkdir /var/www/html
fi

cd /var/www/html

# Limpiar el contenido de la carpeta
rm -rf *

# Descargar WP-CLI si no está instalado
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Verificar si wp-cli está disponible
if ! command -v wp &> /dev/null
then
  echo "WP-CLI is not installed. Please install it first."
  exit 1
fi

# Descargar WordPress
echo "Downloading WordPress..."
wp core download --allow-root

# Comprobación de variables de entorno necesarias para wp-config.php
if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PWD" ] || [ -z "$DB_HOST" ]; then
  echo "Error: the environment variables DB_NAME, DB_USER, DB_PWD or DB_HOST are not set."
  exit 1
fi

# Crear wp-config.php en el directorio actual
echo "Creating wp-config.php..."
wp config create \
  --dbname=$DB_NAME \
  --dbuser=$DB_USER \
  --dbpass=$DB_PWD \
  --dbhost=$DB_HOST \
  --path=/var/www/html \
  --allow-root

# Verificar que wp-config.php fue creado en el directorio
if [ -f /var/www/html/wp-config.php ]; then
  echo "wp-config.php is created."
else
  echo "wp-config.php is not created."
  exit 1
fi

echo "Creating database..."
wp core install \
  --url=$DOMAIN_NAME \
  --title=$WP_TITLE \
  --admin_user=$WP_ADMIN \
  --admin_password=$WP_ADMIN_PWD \
  --admin_email=$WP_ADMIN_EMAIL \
  --skip-email \
  --path=/var/www/html \
  --allow-root

echo "Creating user..."
wp user create \
  $WP_USER \
  $WP_USER_EMAIL \
  --role=author \
  --user_pass=$WP_USER_PWD \
  --path=/var/www/html \
  --allow-root

# Ejecutar PHP-FPM
php-fpm8.2 -F
