#!/bin/bash

cd Authenticator/
if ! ./finalize.sh; then
	echo "err"
	exit 200
fi

cd ../Server/
if ! ./finalize.sh; then
	echo "err"
	exit 201
fi

cd ../Executor
if ! ./finalize.sh; then
	echo "err"
	exit 202
fi
exit 0;
