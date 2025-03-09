#!/bin/bash

if [ ! -f ../../.env ];then
	echo "please spacify ../.env file."
	exit 255
fi

. ../../.env 

if [ ! -f ../../.password ]; then
	echo "cannot read ../../.password"
	exit 254
fi

. ../../.password

rm -f kc.sh

cat << EOF > ./.env 
DOMAIN_NAME='${DOMAIN_NAME}'
KEYCLOAK_DB_USERNAME='${KEYCLOAK_DB_USERNAME}'
KEYCLOAK_DB_PASSWORD='${KEYCLOAK_DB_PASSWORD}'
KEYCLOAK_ADMIN='${KEYCLOAK_ADMIN}'
KEYCLOAK_ADMIN_PASSWORD='${KEYCLOAK_ADMIN_PASSWORD}'
KEYCLOAK_PORT='${KEYCLOAK_PORT}'
EOF

sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" kc.sh.org > kc.sh
chmod 755 kc.sh

COMPOSE_BAKE=true docker compose up -d --build

exit 0;
