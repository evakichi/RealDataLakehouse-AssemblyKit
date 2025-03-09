#!/bin/bash

if [ ! -f ../../.env ];then
	echo "please spacify ../../.env file."
	exit 255
fi

. ../../.env 

rm -f Dockerfile

cat << EOF > ./.env
DOMAIN_NAME='${DOMAIN_NAME}'
KEYCLOAK_PORT='${KEYCLOAK_PORT}'
SAMPLE_API_SERVER_PORT='${SAMPLE_API_SERVER_PORT}'
WEBAPP_FLASK_FRONTEND_PORT='${WEBAPP_FLASK_FRONTEND_PORT}'
KEYCLOAK_MINIO_CLIENT_SECRET='${KEYCLOAK_MINIO_CLIENT_SECRET}'
EOF

sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" ./Dockerfile.org > Dockerfile
sed "s/__SAMPLE_API_SERVER_PORT__/${SAMPLE_API_SERVER_PORT}/g" -i ./Dockerfile
sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" ./application.properties.org > application.properties

sed "s/__KEYCLOAK_PORT__/${KEYCLOAK_PORT}/g" -i ./application.properties
sed "s/__SAMPLE_API_SERVER_PORT__/${SAMPLE_API_SERVER_PORT}/g" -i ./application.properties
sed "s/__SAMPLE_API_SERVER_CLIENT_ID__/${SAMPLE_API_SERVER_CLIENT_ID}/g" -i ./application.properties
sed "s/__SAMPLE_API_SERVER_CLIENT_SECRET__/${SAMPLE_API_SERVER_CLIENT_SECRET}/g" -i ./application.properties

COMPOSE_BAKE=true docker compose up -d --build

exit 0;
