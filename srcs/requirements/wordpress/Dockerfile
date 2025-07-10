FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y curl php php-mysql php7.4-fpm mariadb-client

COPY tools/script.sh /tools/script.sh
RUN chmod +x tools/script.sh

ENTRYPOINT [ "tools/script.sh" ]
