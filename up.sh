#!/bin/bash

cd Authenticator/
if ! ./up.sh; then
	echo "err"
	exit 200
fi

cd ../Server/
if ! ./up.sh; then
	echo "err"
	exit 201
fi

cd ../Executor/
if ! ./up.sh; then
	echo "err"
	exit 201
fi
exit 0;
