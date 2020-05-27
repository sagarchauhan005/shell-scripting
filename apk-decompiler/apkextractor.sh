#!/bin/bash

# This scripts need apktool at /usr/local/bin/apktool.jar and java installed on your system.

#echo $1
NOCOLOR="\033[0m\n"
YELLOW='\033[0;33m'
#checks for the size of folder
SIZE=$(ls -1q "$1" | wc -l)

# check if folder is empty
if [ "$SIZE" -eq "0" ]; then
   echo "Target folder is empty";
   exit;
fi

#check if filetype is given
if [ -z "$2" ]
then
      echo "Target filetype is empty";
      exit;
else
      #creates output folder
      output="${1}../Extracted/"
      rm -r "$output"
      mkdir "$output" && chmod -R 777 "$output"

      targetfolder="${1}*.${2}"
      #echo $var
      # proceed to loop the folder
      for file in $targetfolder; do
            filename="${file##*/}"
            printf "${YELLOW}Extracting ${filename} ${NOCOLOR}"
            printf "..........................................${NOCOLOR}"
            #echo "$filename"
            #exit;
            #make this file output folder
            fileOut="${1}../Extracted/${filename}"
            printf "${YELLOW}Your output folder is ${fileOut} ${NOCOLOR}"
            #exit;
            #rm -r "$fileOut"  #deletes the old folder
            mkdir "$fileOut"  && chmod -R 777 "$fileOut"

            #start extraction
            #echo "$file"
            java -jar /usr/local/bin/apktool.jar -f -o "$fileOut" d "$file"
            printf "########################################################${NOCOLOR}"
            #exit;
      done
fi
