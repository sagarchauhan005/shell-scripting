#!/usr/bin/env bash

# $1  :  Commit Message
# $2 : to push or not, type : true/false
# $3 : branch name

RED="\033[1;31m\n"
NOCOLOR="\033[0m\n"
YELLOW='\033[0;33m'

# Adds and commit to git
git add . && git commit -m "$1"
printf "${YELLOW}Added and committed${NOCOLOR}"

# checks if push is true and branch name is mentioned
if [ -z "$2" ] || [ -z "$3" ]
  then
    exit 1
fi

# if push is true
if [  $2 = "true" ]  # spaces in between are important
  then
    git pull origin $3
    printf "${YELLOW} "Pulled"${NOCOLOR}"
fi