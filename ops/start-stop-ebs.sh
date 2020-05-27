#!/usr/bin/env bash
#$1 : Minimum number of instance
#$2 : Maximum number of instance
#<auto-scaling-group-name> : To find this, visit EC2 section in your aws management dashboard and in your left sidebar,
#                             click on AUTO SCALING GROUPS at the very bottom and it shall display all the scaling groups of your EBS.
#                             Select your group name from there.

RED="\033[1;31m\n"
NOCOLOR="\033[0m\n"
YELLOW='\033[0;33m'


# Staging
aws autoscaling  update-auto-scaling-group --auto-scaling-group-name <auto-scaling-group-name> --min-size "$1" --max-size "$2"

printf "${YELLOW}Instance set to minimum $1 and maximum $2 ${NOCOLOR}
