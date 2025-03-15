#!/bin/bash

if ! docker compose down ; then
	echo "err"
	exit 200
fi
exit 0;
