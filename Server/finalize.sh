#!/bin/bash

cd PostgreSQL
if ! ./finalize.sh; then
	echo "err"
	exit 200
fi

cd ../MinIO
if ! ./finalize.sh; then
	echo "err"
	exit 201
fi
exit 0;
