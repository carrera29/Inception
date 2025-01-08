# Usamos una versión de Alpine Linux como base
FROM alpine:3.15

# Instalamos PHP y extensiones necesarias
RUN apk add --no-cache \
    php8 \
    php8-fpm \
    php8-mysqli \
    php8-json \
    php8-curl \
    php8-mbstring \
    php8-xml \
    php8-session \
    php8-opcache \
    php8-gd \
    php8-zip \
    php8-phar \
    php8-dom \
    php8-simplexml \
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
RUN mkdir /etc/php8/conf
COPY ./conf/php-fpm.conf /etc/php8/conf/php-fpm.conf

# Exponemos el puerto 9000
EXPOSE 9000

# Iniciamos PHP-FPM en modo foreground (sin daemonizar)
CMD ["php-fpm8", "-F"]

