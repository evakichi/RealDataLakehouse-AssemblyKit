#!/bin/bash

if [ ! -f ../.env ];then
	echo "please spacify .env file."
	exit 255
fi

. ../.env 

if [ ! -f ../.password ];then
	echo "please spacify .password file."
	exit 254
fi

. ../.password

#if [ ! -f ../.secret ]; then
#	echo "cannot read ../.secret"
#	exit 254
#fi

#. ../.secret
mkdir -p data
cat << EOF > ./.env
DOMAIN_NAME='${DOMAIN_NAME}'
MINIO_ROOT_USER='${MINIO_ROOT_USER}'
MINIO_ROOT_PASSWORD='${MINIO_ROOT_PASSWORD}' 
MINIO_CONSOLE_NGINX_PORT='${MINIO_CONSOLE_NGINX_PORT}'
MINIO_CLI_NGINX_PORT='${MINIO_CLI_NGINX_PORT}'
SPARK_JUPYTER_NOTEBOOK_PORT='${SPARK_JUPYTER_NOTEBOOK_PORT}'
SPARK_APPLICATION_WEB_UI_PORT='${SPARK_APPLICATION_WEB_UI_PORT}'
SPARK_JOB_HISTORY_WEB_UI_PORT='${SPARK_JOB_HISTORY_WEB_UI_PORT}'
EOF

sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" Dockerfile.org > Dockerfile
sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" conf/nginx.conf.org > conf/nginx.conf
sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" ./conf/spark-defaults.conf.org > ./conf/spark-defaults.conf
sed "s/__SPARK_CATALOG_NAME__/${SPARK_CATALOG_NAME}/g" -i ./conf/spark-defaults.conf
sed "s/__POSTGRES_USERNAME__/${POSTGRES_USERNAME}/g" -i ./conf/spark-defaults.conf 
sed "s/__POSTGRES_DBNAME__/${POSTGRES_DBNAME}/g" -i ./conf/spark-defaults.conf 
sed "s/__POSTGRES_PORT__/${POSTGRES_PORT}/g" -i ./conf/spark-defaults.conf 
sed "s/__MINIO_CLI_NGINX_PORT__/${MINIO_CLI_NGINX_PORT}/g" -i ./conf/spark-defaults.conf 
sed "s/__SPARK_ENDPOINT_NAME__/${SPARK_ENDPOINT_NAME}/g" -i ./conf/spark-defaults.conf 
sed "s/__SPARK_WAREHOUSE_NAME__/${SPARK_WAREHOUSE_NAME}/g" -i ./conf/spark-defaults.conf 

echo "spark.sql.catalog."${SPARK_CATALOG_NAME}".jdbc.password     "${POSTGRES_PASSWORD} >> ./conf/spark-defaults.conf

if [ ! -d ./certs ];then 
	cp -r ../certs ./
fi

COMPOSE_BAKE=true docker compose up -d --build
exit 0;
