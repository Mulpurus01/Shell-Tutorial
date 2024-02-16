#!/bin/bash
#To copy files from different locations to sinlge location
#To execute this file permissions are manually set 0740 OR 0640
#To start the script give sh <script name.sh>
#To run the script in background and copy the output to file nohup </path/to/filename/filename.sh> &
echo ----------------------------------------------
echo 'Started copying the files'
echo ----------------------------------------------

#LIST OF DIRECTORIES IN WHICH WE NEED TO CHECK
DIRECTORIES=("LOCATION1" "LOCATION1" "LOCATION2" "LOCATION3" "LOCATION4" "LOCATION5")

DESTINATION='/path/to/target/location/'

for DIRECTORY in "${DIRECTORIES[@]}"
  do
    cd "/path/to/folders/$DIRECTORY/any/internal/folder/"
    LATEST_ZIP_FileName=$(ls -t | head -1)
    FileName=$(unzip -l $LATEST_ZIP_FileName | head -4 | tail -1) #The required is inside the zip file. this will print that filename Viz Filename.zip has 1. Metadata.txt & RequiredFileName.txt
    cp $LATEST_ZIP_FileName $DESTINATION #Entire ZIP file is copied to destination
    echo $LATEST_ZIP_FileName file transfer done
  done
echo ----------------------------------------------
echo Copy of files completed
echo ----------------------------------------------
echo HAIL HYDRA
