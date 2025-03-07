#!/bin/bash

cd RDL-MinIO/
if ! ./init.sh;then
	exit 200
fi

cd ../RDL-PGSQL/
if ! ./init.sh;then
	exit 201
fi
exit 0;
