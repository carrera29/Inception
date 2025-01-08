#!/bin/bash

CERT_DIR="/etc/nginx/ssl/certs"
CERT_KEY="${CERT_DIR}/cert.key"
CERT_CRT="${CERT_DIR}/cert.crt"

# Crea la carpeta si no existe
mkdir -p $CERT_DIR

# Verifica si los archivos de certificado ya existen
if [ ! -f $CERT_KEY ] || [ ! -f $CERT_CRT ]; then
    echo "Generando certificado ssl"
    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout $CERT_KEY \
        -out $CERT_CRT \
        -subj "/C=US/ST=California/L=San Francisco/O=MyOrg/OU=IT/CN=localhost"
else
    echo "Certificados ssl ya existen."
fi
