#!/bin/bash
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
    -v $(pwd)/certbot/conf:/etc/letsencrypt \
     certbot/certbot \
     certonly --webroot -w /var/www/certbot -d $REDMINE_HOST --agree-tos --email $CERTBOT_EMAIL --non-interactive

docker run \
    -v $(pwd)/certbot/www:/var/www/certbot \
    -v $(pwd)/certbot/conf:/etc/letsencrypt \
     certbot/certbot \
     certonly --webroot -w /var/www/certbot -d $JENKINS_HOST --agree-tos --email $CERTBOT_EMAIL --non-interactive

docker run \
    -v $(pwd)/certbot/www:/var/www/certbot \
    -v $(pwd)/certbot/conf:/etc/letsencrypt \
     certbot/certbot \
     certonly --webroot -w /var/www/certbot -d $OVERLEAF_HOST --agree-tos --email $CERTBOT_EMAIL --non-interactive

docker kill certinit_nginx
docker rm certinit_nginx