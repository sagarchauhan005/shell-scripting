#!/bin/bash

# A simple script to perform database operations

DB_HOST=
DB_DATABASE=
DB_USERNAME=
DB_PASSWORD=

RED="\033[1;31m\n"
NOCOLOR="\033[0m\n"
YELLOW='\033[0;33m'

printf "${YELLOW}Creating copy database ${NOCOLOR}"
mysql -h "$DB_HOST" -u "$DB_USERNAME" --password="$DB_PASSWORD" -e "CREATE DATABASE $1";

printf "${YELLOW}Dumping original database ${NOCOLOR}"
mysqldump -h "$DB_HOST" -u "$DB_USERNAME" --password="$DB_PASSWORD"  "$DB_DATABASE" > "$1.sql";

printf "${YELLOW}Uploading the new dump to copy database ${NOCOLOR}"
mysql -h "$DB_HOST" -u "$DB_USERNAME" --password="$DB_PASSWORD"  "$1" < "$1.sql";

printf "${YELLOW}Final result print ${NOCOLOR}"
mysql -h "$DB_HOST" -u "$DB_USERNAME" --password="$DB_PASSWORD" -e "SHOW DATABASES";
