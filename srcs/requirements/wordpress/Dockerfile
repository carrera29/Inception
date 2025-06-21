FROM debian:12

RUN apt-get update && \
    apt-get install -y php-fpm php-mysqli php-curl php-gd php-xml php-mbstring php-zip php-intl php-soap php-xmlrpc php-imagick curl && \
    rm -rf /var/lib/apt/lists/*

COPY www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

CMD ["/usr/local/bin/script.sh"]
