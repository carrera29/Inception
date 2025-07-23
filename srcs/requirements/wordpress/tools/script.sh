#!/bin/bash

MYSQL_USER=$(cat /run/secrets/db_credentials.txt)
MYSQL_USER_PASSWORD=$(cat /run/secrets/db_password.txt)
MYSQL_ADMIN_PASSWORD=$(cat /run/secrets/db_root_password.txt)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password.txt)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password.txt)

read WP_ADMIN_USER WP_ADMIN_EMAIL < <(head -n 1 /run/secrets/wp_admin_credentials.txt | tr ':' ' ')
read WP_USER WP_USER_EMAIL WP_USER_ROLE < <(head -n 1 /run/secrets/wp_user_credentials.txt | tr ':' ' ')

echo "===== VARIABLES CARGADAS DESDE SECRETS ====="
echo "MYSQL_USER: $MYSQL_USER"
echo "WP_ADMIN_USER: $WP_ADMIN_USER"
echo "WP_ADMIN_EMAIL: $WP_ADMIN_EMAIL"
echo "WP_ADMIN_PASSWORD: $WP_ADMIN_PASSWORD"
echo "WP_USER: $WP_USER"
echo "WP_USER_EMAIL: $WP_USER_EMAIL"
echo "WP_USER_ROLE: $WP_USER_ROLE"
echo "WP_USER_PASSWORD: $WP_USER_PASSWORD"
echo "WP_TITLE: $WP_TITLE"
echo "DOMAIN: $DOMAIN"
echo "DATABASE_NAME: $DATABASE_NAME"
echo "MYSQL_USER_PASSWORD: $MYSQL_USER_PASSWORD"
echo "============================================"

# Download and install WordPress
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# Change permissions and move wp-cli to a directory
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
cd /var/www/html
chmod -R 755 /var/www/html
# Replace the socket path in the PHP-FPM configuration file
# This is necessary to ensure that PHP-FPM listens on the correct port
sed -i '36 s/\/run\/php\/php7.4-fpm.sock/9000/' /etc/php/7.4/fpm/pool.d/www.conf

# Wait for the MariaDB service to be ready
for ((i = 1; i <= 10; i++)); do
    if mariadb -h mariadb -P 3306 \
        -u "${MYSQL_USER}" \
        -p"${MYSQL_USER_PASSWORD}" -e "SELECT 1" > /dev/null 2>&1; then
        break
    else
        sleep 2
    fi
done

# Download and configure WordPress
wp core download --allow-root

# Configure WordPress with the MariaDB database
wp config create \
    --dbname=${DATABASE_NAME} \
    --dbuser=${MYSQL_USER} \
    --dbpass=${MYSQL_USER_PASSWORD} \
    --dbhost=mariadb:3306 --allow-root

# Provided credentials for WordPress installation
wp core install \
    --url=${DOMAIN} \
    --title=${WP_TITLE} \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} --allow-root

# Create a new WordPress user with the specified role
wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
    --user_pass="${WP_USER_PASSWORD}" \
    --role="${WP_USER_ROLE}" \
    --allow-root

wp theme install twentytwentyfour --activate --allow-root

wp plugin install redis-cache --activate --allow-root
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --raw --allow-root
wp redis enable --allow-root

chown -R www-data:www-data /var/www/html

mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F
