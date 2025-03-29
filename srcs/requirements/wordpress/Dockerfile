# Use the latest Debian image as the base
FROM debian:latest

# Update and install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    php-fpm \
    php-mysqli \
    curl

COPY www.conf /etc/php/8.2/fpm/pool.d/.

COPY script.sh .
RUN chmod +x script.sh

# Set the default command to run PHP-FPM
CMD ["./script.sh"]