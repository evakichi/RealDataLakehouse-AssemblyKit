#!/bin/bash

cd MinIO/
if ! ./up.sh; then
	echo "err"
	exit 200
fi

cd ../PostgreSQL/
if ! ./up.sh; then
	echo "err"
	exit 201
fi
exit 0;
