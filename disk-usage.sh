#!/bin/bash

DISK_USAGE=df -hT | grep xfs #this will return memory
DISK_THRESHOLD=5 #if threshold is more than 5 alaram will rise

while IFS=read -r line
do
USAGE=$(echo $line | grep xfs | awk -F " " '{print $6F}' | cut -d "%" -f1)
PARTITION=$(echo $line | grep xfs | awk -F " " '{print $NF}')
if [ $USAGE -ge $DISK_THRESHOLD]
then 
echo "$PARTITION is more than $DISK_THRESHOLD,current value:$USAGE.please check"
fi
done <<< $DISK_USAGE