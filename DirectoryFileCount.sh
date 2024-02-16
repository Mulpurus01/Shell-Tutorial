#!/bin/bash
#To execute this file permissions are manually set 0740 OR 0640
#To start the script give sh <script name.sh>
#To run the script in background and copy the output to file nohup </path/to/filename/filename.sh> &
echo ----------------------------------------------
echo 'Started counting the staging file'
echo ----------------------------------------------
NUMBER_OF_FILES_STILL_EXIST=0

#LIST OF DIRECTORIES IN WHICH WE NEED TO CHECK
DIRECTORIES=("LOCATION1" "LOCATION1" "LOCATION2" "LOCATION3" "LOCATION4" "LOCATION5")

for DIRECTORY in "${DIRECTORIES[@]}"
  do
    cd "/path/to/folders/$DIRECTORY/any/internal/folder/"
    echo $(pwd) has : $(ls | wc -l)
    NUMBER_OF_FILES_STILL_EXIST=$((NUMBER_OF_FILES_STILL_EXIST+$(ls |wc -l)))
  done
echo ----------------------------------------------
echo Todat: $NUMBER_OF_FILES_STILL_EXIST
echo ----------------------------------------------
echo HAIL HYDRA
