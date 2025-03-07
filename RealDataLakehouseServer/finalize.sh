#!/bin/bash

cd RDL-PGSQL
if ! ./finalize.sh; then
	echo "err"
	exit 200
fi

cd ../RDL-MinIO
if ! ./finalize.sh; then
	echo "err"
	exit 201
fi
exit 0;
