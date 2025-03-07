#!/bin/bash

docker compose down 
docker volume rm pgsql_rdl-pgsql-store
rm -f conf/nginx.conf
sudo rm -rf certs
