#!/bin/bash

if [ ! -f ../../.env ];then
	echo "please spacify .env file."
	exit 255
fi

. ../../.env 

if [ ! -f ../../.password ]; then
	echo "cannot read ../.password"
	exit 254
fi

. ../../.password

if [ ! -f ../../.secret ]; then
	echo "cannot read ../.secret"
	exit 254
fi

. ../../.secret

cat << EOF > ./.env
DOMAIN_NAME='${DOMAIN_NAME}'
MINIO_ROOT_USER='${MINIO_ROOT_USER}'
MINIO_ROOT_PASSWORD='${MINIO_ROOT_PASSWORD}'
MINIO_CLIENT_SECRET='${MINIO_CLIENT_SECRET}'
MINIO_CONSOLE_NGINX_PORT='${MINIO_CONSOLE_NGINX_PORT}'
MINIO_CLI_NGINX_PORT='${MINIO_CLI_NGINX_PORT}'
KEYCLOAK_MINIO_REALM='${KEYCLOAK_MINIO_REALM}'
KEYCLOAK_MINIO_CLIENT='${KEYCLOAK_MINIO_CLIENT}'
KEYCLOAK_PORT='${KEYCLOAK_PORT}'
KEYCLOAK_MINIO_CLIENT_SECRET='${KEYCLOAK_MINIO_CLIENT_SECRET}'
EOF

rm -f conf/nginx.conf

sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" conf/nginx.conf.org > conf/nginx.conf

COMPOSR_BAKE=true docker compose up -d --build

exit 0;
