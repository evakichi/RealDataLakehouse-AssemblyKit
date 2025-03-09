#!/bin/bash

if [ ! -f ../../.env ];then
	echo "please spacify ../../.env file."
	exit 255
fi

. ../../.env 

if [ ! -f ../../.password ]; then
	echo "cannot read ../../.password"
	exit 254
fi

. ../../.password

if [ ! -f ../../.secret ]; then
	echo "cannot read ../../.secret"
	exit 254
fi

. ../../.secret

rm -f Dockerfile
rm -f frontend_oidc-config.json
rm -f conf/nginx.conf

cat << EOF > ./.env
DOMAIN_NAME='${DOMAIN_NAME}'
KEYCLOAK_PORT='${KEYCLOAK_PORT}'
WEBAPP_FLASK_FRONTEND_PORT='${WEBAPP_FLASK_FRONTEND_PORT}'
KEYCLOAK_MINIO_CLIENT_SECRET='${KEYCLOAK_MINIO_CLIENT_SECRET}'
EOF

. ./.env

sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" ./Dockerfile.org > Dockerfile
sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" ./frontend_oidc-config.json.org > frontend_oidc-config.json
sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" conf/nginx.conf.org > conf/nginx.conf

sed "s/__KEYCLOAK_MINIO_CLIENT_SECRET__/${KEYCLOAK_MINIO_CLIENT_SECRET}/g" -i ./frontend_oidc-config.json
sed "s/__KEYCLOAK_PORT__/${KEYCLOAK_PORT}/g" -i ./frontend_oidc-config.json
sed "s/__WEBAPP_FLASK_FRONTEND_PORT__/${WEBAPP_FLASK_FRONTEND_PORT}/g" -i ./frontend_oidc-config.json


COMPOSE_BAKE=true docker compose up -d --build

exit 0;
