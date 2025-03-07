#!/bin/bash

cd Keycloak
if ! ./finalize.sh; then
	echo "err"
	exit 200
fi

cd ../OpenLDAP
if ! ./finalize.sh; then
	echo "err"
	exit 201
fi
exit 0;
