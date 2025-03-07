#!/bin/bash

docker compose down
docker volume rm openldap_rdl-ldap-config
docker volume rm openldap_rdl-ldap-data
