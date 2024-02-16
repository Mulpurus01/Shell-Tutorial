#!/bin/bash
#To execute this file permissions are manually set 0740 OR 0640
#To start the script give sh <script name.sh>
#To run the script in background and copy the output to file nohup </path/to/filename/filename.sh> &
echo ----------------------------------------------
echo 'Started renaming and delivery via SFTP / FTP'
echo ----------------------------------------------

cd /path/where/files/required/to/be/delivered/exist

for file in * #* indicates that it'll take all files in the PWD, otherwise specify the file name pattern
  do
    mv "$file" "new_name_to_file.0.$file" #Appending a partial name to given filename
    #Can include the FTP or SFTP commands to perform the delivery
  done
echo ----------------------------------------------
echo File re-name and delivery completed
echo ----------------------------------------------
echo HAIL HYDRA
