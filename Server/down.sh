#!/bin/bash

cd PostgreSQL/
if ! ./down.sh; then
	echo "err"
	exit 200
fi

cd ../MinIO/
if ! ./down.sh; then
	echo "err"
	exit 201
fi
exit 0;
