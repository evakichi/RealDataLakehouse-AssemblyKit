#!/bin/bash

cd OpenLDAP/
if ! ./init.sh;then
	exit 200
fi

cd ../Keycloak/
if ! ./init.sh;then
	exit 201
fi
exit 0;
