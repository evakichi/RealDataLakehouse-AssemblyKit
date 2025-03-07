#!/bin/bash

cd Keycloak/
if ! ./down.sh; then
	echo "err"
	exit 200
fi

cd ../OpenLDAP/
if ! ./down.sh; then
	echo "err"
	exit 201
fi
exit 0;
