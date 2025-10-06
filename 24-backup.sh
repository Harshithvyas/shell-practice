#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SOURCE_DIR=$1
DEST_DIR=$2

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(basename "$0" .sh)
LOG_FILE="$LOGS_FOLDER/${SCRIPT_NAME}.log"
DAYS=$(3:-14) # if not provided considered as 14 days

mkdir -p "$LOGS_FOLDER"
echo -e "Script started executed at: $(date) " | tee -a "$LOG_FILE"

if [ $USERID -ne 0 ]; then
    echo -e "$R ERROR:: Please run this script with root privilege $N"
    exit 1
fi

USAGE(){
    echo " $R USAGE:: sudo sh 24-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS>[optional, default 14 days] $N"
    exit 1
}

if [ $# -lt 2 ]; then
   USAGE
fi
if [ -d $SOURCE_DIR ]; then
   echo -e "$R Source $SOURCE_DIR does not exist $N"
   exit
fi

if [ ! -d $DEST_DIR ]; then
   echo -e "$R Destination $DEST_DIR does not exist $N"
   exit
fi   

FILES=$(find $SOURCE_DIR -name "*log" -type f -ntime +14)

if [ ! -z "$(FILES)" ]; then
   echo "Files found"
else
    echo "No files to archeive ... $V SKIPPING $N"
fi