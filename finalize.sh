#!/bin/bash

cd RealDataLakehouseServer/
if ! ./finalize.sh; then
	echo "err"
	exit 200
fi

cd ../RealDataLakehouseExecutor
if ! ./finalize.sh; then
	echo "err"
	exit 201
fi
exit 0;
