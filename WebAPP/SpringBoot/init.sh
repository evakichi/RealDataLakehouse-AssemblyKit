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

rm -f conf/nginx.conf

cat << EOF > ./.env
DOMAIN_NAME='${DOMAIN_NAME}'
WEBAPP_CLIENT_ID='${WEBAPP_CLIENT_ID}'
WEBAPP_CLIENT_SECRET='${WEBAPP_CLIENT_SECRET}'
EOF

sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" ./Dockerfile.org > Dockerfile
sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" conf/nginx.conf.org > conf/nginx.conf

COMPOSE_BAKE=true docker compose up -d --build

exit 0;
