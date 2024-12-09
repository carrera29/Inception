# Usamos una versión de Alpine Linux como base
FROM alpine:3.15

# Instalamos PHP y extensiones necesarias
RUN apk add --no-cache \
    php7 \
    php7-fpm \
    php7-mysqli \
    php7-json \
    php7-curl \
    php7-mbstring \
    php7-xml \
    php7-session \
    php7-opcache \
    php7-gd \
    php7-zip \
    php7-phar \
    php7-dom \
    php7-simplexml \
    wget

# Descargamos WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    rm latest.tar.gz

# Movemos los archivos de WordPress al directorio raíz de la web
RUN mkdir -p /var/www/html && \
    mv wordpress/* /var/www/html && \
    rm -rf wordpress

# Copiamos el archivo de configuración de PHP-FPM
COPY conf/php-fpm.conf /etc/php7/php-fpm.conf

# Exponemos el puerto 9000
EXPOSE 9000

# Iniciamos PHP-FPM en modo foreground (sin daemonizar)
CMD ["php-fpm7", "-F"]

