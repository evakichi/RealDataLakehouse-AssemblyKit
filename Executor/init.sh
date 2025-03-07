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

cat << EOF > ./.env
MINIO_ROOT_USER='${MINIO_ROOT_USER}'
MINIO_ROOT_PASSWORD='${MINIO_ROOT_PASSWORD}' 
DOMAIN_NAME='${DOMAIN_NAME}'
EOF

sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" Dockerfile.org > Dockerfile
sed "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" ./conf/spark-defaults.conf.org > ./conf/spark-defaults.conf
sed "s/__SPARK_CATALOG_NAME__/${SPARK_CATALOG_NAME}/g" -i ./conf/spark-defaults.conf
sed "s/__POSTGRES_USERNAME__/${POSTGRES_USERNAME}/g" -i ./conf/spark-defaults.conf 
sed "s/__POSTGRES_DBNAME__/${POSTGRES_DBNAME}/g" -i ./conf/spark-defaults.conf 
sed "s/__SPARK_ENDPOINT_NAME__/${SPARK_ENDPOINT_NAME}/g" -i ./conf/spark-defaults.conf 
sed "s/__SPARK_WAREHOUSE_NAME__/${SPARK_WAREHOUSE_NAME}/g" -i ./conf/spark-defaults.conf 

echo "spark.sql.catalog."${SPARK_CATALOG_NAME}".jdbc.password     "${POSTGRES_PASSWORD} >> ./conf/spark-defaults.conf

if [ ! -d ./certs ];then 
	cp -r ../certs ./
fi

COMPOSE_BAKE=true docker compose up -d --build
exit 0;
