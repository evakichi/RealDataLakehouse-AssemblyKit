#!/bin/bash

docker compose down 

rm -f conf/spark-defaults.conf
rm -f Dockerfile
rm -rf certs
