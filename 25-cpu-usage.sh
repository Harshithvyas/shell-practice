#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)

while IFS=read -r line
do
  echo "line: $line"
done  <<< $DISK_USAGE 
