#!/bin/bash
set -e
source .env

docker run \
    -v $(pwd)/nginx/certinit.conf:/etc/nginx/conf.d/certinit.conf \
    -v $(pwd)/certbot/www:/var/www/certbot \
    -p 80:80 \
    --name certinit_nginx \
    -d \
    nginx

docker run \
    -v $(pwd)/certbot/www:/var/www/certbot \
     certbot/certbot \
     certonly --webroot -w /var/www/certbot -d $REDMINE_HOST --agree-tos --email $CERTBOT_EMAIL

docker kill certinit_nginx
docker rm certinit_nginx