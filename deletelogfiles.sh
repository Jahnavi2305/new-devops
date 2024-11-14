#!/bin/bash

SOURCE_DIR=/home/ec2-user/logs  #path where logs are stored

if [ -d $SOURCE_DIR]   # -d directory
then  
 echo  "$SOURCE_DIR exits"
else 
echo "$SOURCE_DIR doesnot exit"
fi

FILES=$(find $SOURCE_DIR -name "*.log*" -mtime +14)

echo "FILES: $FILES"


while IFS=read -r file #IFS , internal feild seperator,empty it will ignore while special characters like /*$..
do

echo "deleting file: $FILES"

rm -rf $FILES
done <<<$FILES  