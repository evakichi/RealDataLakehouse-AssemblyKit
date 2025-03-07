#!/bin/bash

cd OpenLDAP/
if ! ./up.sh; then
	echo "err"
	exit 200
fi

cd ../Keycloak/
if ! ./up.sh; then
	echo "err"
	exit 201
fi
exit 0;
