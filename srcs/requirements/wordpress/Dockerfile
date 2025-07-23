FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y curl php php-mysql php7.4-fpm mariadb-client


COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN mkdir /run/php

#we copy the script, give the right to launch it in local on our computer
COPY ./tools/script.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/script.sh
ENTRYPOINT ["/usr/local/bin/script.sh"]

#We go the html directory
WORKDIR /var/www/html/

#Launch PHP FPM in foreground and ignore deamonize from conf file (-F)
CMD ["/usr/sbin/php-fpm7.3", "-F"]