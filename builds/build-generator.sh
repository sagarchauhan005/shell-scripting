#!/usr/bin/env bash
# shellcheck disable=SC2059

# This script helps in configuring the project for Staging Environment on AWS
# This script works only with Laravel and Docker enabled and running

ENVIRONMENT_FILE=".env"
RED="\033[1;31m\n"
NOCOLOR="\033[0m\n"
YELLOW="\033[0;33m"

APP_URL=dummy
APP_DEBUG=dummy
APP_DEV_STATUS=dummy
APP_ENV=dummy
DB_DATABASE=dummy

setEnv() {
    sed -i "/^\($1=\).*/s//\1$2/" .env $ENVIRONMENT_FILE
}

setEnv "APP_DEBUG" "$APP_DEBUG"
printf  "${YELLOW}Debug set to false${NOCOLOR}"

setEnv "APP_DEV_STATUS" "$APP_DEV_STATUS"
printf "${YELLOW}Project Dev Status set ${NOCOLOR}"

setEnv "APP_URL" "$APP_URL"
printf "${YELLOW}Project live url set${NOCOLOR}"

setEnv "APP_ENV" "$APP_ENV"
printf "${YELLOW}Staging env set${NOCOLOR}"

setEnv "DB_DATABASE" "$DB_DATABASE"
printf "${YELLOW}Staging database set${NOCOLOR}"
