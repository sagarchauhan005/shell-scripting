#!/usr/bin/env bash

# This script helps in configuring the project for Staging Environment on AWS
# This script works only with Laravel and Docker enabled and running

RED="\033[1;31m\n"
NOCOLOR="\033[0m\n"
YELLOW='\033[0;33m'
APP_URL=
APP_DEV_URL=
APP_DEBUG=
APP_DEV_STATUS=
APP_ENV=
DB_DATABASE=
PUSHER_APP_ENCRYPT=
PUSHER_APP_HOST=
PUSHER_APP_PORT=
PUSHER_APP_SCHEME=
WEBSOCKET_LOCAL_CERT=
WEBSOCKET_LOCAL_PRIVATE_KEY=
WEBSOCKET_PASSPHRASE=
INSTAMOJO_KEY=
INSTAMOJO_TOKEN=
INSTAMOJO_SALT=
INSTAMOJO_REDIRECT_URL=
INSTAMOJO_WEBHOOK_URL=


if [ -z `docker ps -q --no-trunc | grep $(docker-compose ps -q app)` ]; then
  printf "${RED}Docker isn't running. Please start the service first${NOCOLOR}"
   exit 1
else
  printf "${YELLOW}Docker is running. Lets  move ahead.${NOCOLOR}"
fi


if [[ $EUID -ne 0 ]]; then
   printf "${RED}This script must be run as root${NOCOLOR}"
   exit 1
fi

# No script installation
printf "${YELLOW}Composer install --no-script${NOCOLOR}"
docker-compose exec app composer install --no-scripts

# Optimizing and cleaning the project
printf "${YELLOW}Dump autoload${NOCOLOR}"
docker-compose exec app composer dump-autoload

printf "${YELLOW}Clear compiled files${NOCOLOR}"
docker-compose exec app php artisan clear-compiled

# setting app environments
printf "${YELLOW}Optimizing artisan${NOCOLOR}"
docker-compose exec app php artisan optimize

docker-compose exec app php artisan env:set APP_DEBUG="$APP_DEBUG"
printf  "${YELLOW}Debug set to false${NOCOLOR}"

docker-compose exec app php artisan env:set APP_DEV_STATUS="$APP_DEV_STATUS"
printf "${YELLOW}Project Dev Status set ${NOCOLOR}"

docker-compose exec app php artisan env:set APP_URL="$APP_URL"
printf "${YELLOW}Project live url set${NOCOLOR}"

docker-compose exec app php artisan env:set APP_ENV="$APP_ENV"
printf "${YELLOW}Staging env set${NOCOLOR}"

docker-compose exec app php artisan env:set DB_DATABASE="$DB_DATABASE"
printf "${YELLOW}Staging database set${NOCOLOR}"

# pusher  configuration
docker-compose exec app php artisan env:set PUSHER_APP_ENCRYPT="$PUSHER_APP_ENCRYPT"
printf "${YELLOW}Pusher encryption set${NOCOLOR}"

docker-compose exec app php artisan env:set PUSHER_APP_HOST="$PUSHER_APP_HOST"
printf "${YELLOW}Pusher host set${NOCOLOR}"

docker-compose exec app php artisan env:set PUSHER_APP_PORT="$PUSHER_APP_PORT"
printf "${YELLOW}Pusher port set${NOCOLOR}"

docker-compose exec app php artisan env:set PUSHER_APP_SCHEME="$PUSHER_APP_SCHEME"
printf "${YELLOW}Pusher scheme set${NOCOLOR}"

#websocket configs
docker-compose exec app php artisan env:set WEBSOCKET_LOCAL_CERT="$WEBSOCKET_LOCAL_CERT"
printf "${YELLOW}Websocket local cert set${NOCOLOR}"

docker-compose exec app php artisan env:set WEBSOCKET_LOCAL_PRIVATE_KEY="$WEBSOCKET_LOCAL_PRIVATE_KEY"
printf "${YELLOW}Websocket local private key set${NOCOLOR}"

docker-compose exec app php artisan env:set WEBSOCKET_PASSPHRASE="$WEBSOCKET_PASSPHRASE"
printf "${YELLOW}Websocket passphrase  set${NOCOLOR}"

# Instamojo configs
docker-compose exec app php artisan env:set INSTAMOJO_KEY="$INSTAMOJO_KEY"
printf "${YELLOW}Instamojo key set${NOCOLOR}"

docker-compose exec app php artisan env:set INSTAMOJO_TOKEN="$INSTAMOJO_TOKEN"
printf "${YELLOW}Instamojo token set${NOCOLOR}"

docker-compose exec app php artisan env:set INSTAMOJO_SALT="$INSTAMOJO_SALT"
printf "${YELLOW}Instamojo salt  set${NOCOLOR}"

docker-compose exec app php artisan env:set INSTAMOJO_REDIRECT_URL="$INSTAMOJO_REDIRECT_URL"
printf "${YELLOW}Instamojo redirect  set${NOCOLOR}"

docker-compose exec app php artisan env:set INSTAMOJO_WEBHOOK_URL="$INSTAMOJO_WEBHOOK_URL"
printf "${YELLOW}Instamojo env set${NOCOLOR}"

# Artisn commands
docker-compose exec app php artisan config:clear
docker-compose exec app php artisan cache:clear

printf "${YELLOW}Removing vendor from gitignore ${NOCOLOR}"
mv .gitignore .gitignore-old && sed '/vendor/d' .gitignore-old >> .gitignore && rm .gitignore-old && chmod 777 .gitignore

# Optimizing and cleaning the project
printf "${YELLOW}Updating composer without dev dependencies${NOCOLOR}"
docker-compose exec app composer update --no-dev

printf "${YELLOW}Composer updated successfully${NOCOLOR}"

printf "${YELLOW}Project is ready to be uploaded to staging server.${NOCOLOR}"
