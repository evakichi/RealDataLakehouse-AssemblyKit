#!/bin/bash

cd RDL-MinIO/
if ! ./up.sh; then
	echo "err"
	exit 200
fi

cd ../RDL-PGSQL/
if ! ./up.sh; then
	echo "err"
	exit 201
fi
exit 0;
