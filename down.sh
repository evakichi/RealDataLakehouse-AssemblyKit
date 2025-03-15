#!/bin/bash

cd Authenticator/
if ! ./down.sh; then
	echo "err"
	exit 200
fi

cd ../Server/
if ! ./down.sh; then
	echo "err"
	exit 201
fi

cd ../Executor/
if ! ./down.sh; then
	echo "err"
	exit 202
fi

cd ../Transmitter/
if ! ./down.sh; then
	echo "err"
	exit 202
fi

cd ../Receiver/
if ! ./down.sh; then
	echo "err"
	exit 202
fi
exit 0;
