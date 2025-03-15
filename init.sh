#!/bin/bash

#POSTGRS_PASSQORD='$(pwgen -1 -c -B -y -n -r "\$&;:><*\"\'\` \\" 32)'

if [ ! -f ./.env ];then
	echo "please spacify .env file."
	exit 255
fi

. ./.env 

if [ -f ./.password ]; then
	. ./.password
else
cat << EOF > ./.password
MINIO_ROOT_PASSWORD='$(pwgen -1 -c -B -y -n -r "\'" 32)'
POSTGRES_PASSWORD='$(pwgen -1 -c -B -y -n -r "\'" 32)'
LDAP_ADMIN_PASSWORD='$(pwgen -1 -c -B -y -n -r "\'" 32)'
LDAP_READONLY_USER_PASSWORD='$(pwgen -1 -c -B -y -n -r "\'" 32)'
LAM_PASSWORD='$(pwgen -1 -c -B -y -n -r "\'" 32)'
KEYCLOAK_DB_PASSWORD='$(pwgen -1 -c -B -y -n -r "\'" 32)'
KEYCLOAK_ADMIN_PASSWORD='$(pwgen -1 -c -B -y -n -r "\'" 32)'
EOF
. ./.password
fi

cd Authenticator/
if ! ./init.sh;then
	exit 200
fi

cd ../Server/
if ! ./init.sh;then
	exit 201
fi

cd ../Executor/
if ! ./init.sh;then
	exit 202
fi

cd ../Transmitter/
if ! ./init.sh;then
	exit 202
fi

cd ../Receiver/
if ! ./init.sh;then
	exit 202
fi
