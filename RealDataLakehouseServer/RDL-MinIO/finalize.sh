#!/bin/bash

docker compose down
docker volume rm rdl-minio_rdl-minio-volume
rm -f conf/nginx.conf

