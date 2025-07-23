#!/bin/bash

set -e

# create the nginx configuration file
cat > /etc/nginx/nginx.conf << 'EOF'
events {}
http {
    include /etc/nginx/mime.types;

    server {
        listen 443 ssl;
        listen [::]:443 ssl;

        root /var/www/html;
        server_name clcarrer.42.fr ;

        index index.php;

        ssl_certificate /etc/nginx/ssl/inception.crt;
        ssl_certificate_key /etc/nginx/ssl/inception.key;
        ssl_protocols TLSv1.3;
        
        location / {
            try_files $uri $uri/ /index.php$is_args$args;
        }

        location ~ \.php$ {
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            fastcgi_pass wordpress:9000; #PHP for wordpress will listen on the port 9000
            fastcgi_index index.php;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_param SCRIPT_NAME $fastcgi_script_name;
        }
    }
}
EOF

# make sure the directory for the SSL certificates exists if not create it
mkdir -p /etc/nginx/ssl
if [ ! -f /etc/nginx/ssl/inception.crt ] || [ ! -f /etc/nginx/ssl/inception.key ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/inception.key \
        -out /etc/nginx/ssl/inception.crt \
        -subj "/C=MO/ST=KH/O=42/OU=42/CN=${LOGIN}.42.fr"
fi

# execute nginx in the foreground
exec nginx -g 'daemon off;'
