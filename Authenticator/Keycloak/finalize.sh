#!/bin/bash

docker compose down 
docker volume rm keycloak_rdl-keycloak-db-store
docker volume rm keycloak_rdl-keycloak-volume
