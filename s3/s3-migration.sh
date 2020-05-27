#!/usr/bin/env bash

# TO use the commands below, make sure awscli is configured onto your system.
# This is just a gist of simple commands withoud validation of flow and with understanding that all parameters have been
# provided.

#$1 : old s3 directory
#$2 : new s3 directory
#$3 : current path
#$4 : target path

# Empty the current directory

aws s3 rm s3://"$1" --recursive
printf "Current Directory Emptied"

# Make folder
aws s3api put-object --bucket "$2" --key "$3"
printf "Created folder"

# Sync old s3 to new s3
aws s3 sync s3://"$1" s3://"$2"
printf "Synced old directory to new"

# Move folders
aws s3 mv s3://"$1"/"$3" s3://"$2"/"$4" --recursive
printf "Moved folder"

# Delete folder
aws s3 rm s3://"$1"/"$3" --recursive
printf "Delete folder"

printf "All commands completed !"
