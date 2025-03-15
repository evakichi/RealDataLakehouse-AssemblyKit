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

cat << EOF > .env
DOMAIN_NAME='${DOMAIN_NAME}'
POSTGRES_DBNAME='${POSTGRES_DBNAME}'
POSTGRES_USERNAME='${POSTGRES_USERNAME}'
POSTGRES_PASSWORD='${POSTGRES_PASSWORD}'
POSTGRES_PORT='${POSTGRES_PORT}'
ADMINER_NGINX_PORT='${ADMINER_NGINX_PORT}'
EOF

rm -f conf/nginx.conf
sudo rm -rf ./certs

sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" conf/nginx.conf.org > conf/nginx.conf

if  ! sudo cp -r ../../certs/ ./ ;then
	echo "copy certs err."
	exit 253;
fi

if  ! sudo chown 999:999 ./certs/* ; then
	echo "certs err"
	exit 252;
fi

COMPOSE_BAKE=true docker compose up -d --build

exit 0;
