#!/bin/bash

if ! COMPOSE_BAKE=true docker compose up -d --build ; then
	echo "err"
	exit 200
fi
exit 0;
