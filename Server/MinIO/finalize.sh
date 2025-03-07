#!/bin/bash

docker compose down
docker volume rm minio_rdl-minio-volume
rm -f conf/nginx.conf

