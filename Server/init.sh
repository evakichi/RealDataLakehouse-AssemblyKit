#!/bin/bash

cd MinIO/
if ! ./init.sh;then
	exit 200
fi

cd ../PostgreSQL/
if ! ./init.sh;then
	exit 201
fi
exit 0;
