#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(basename "$0" .sh)
LOG_FILE="$LOGS_FOLDER/${SCRIPT_NAME}.log"

if [ $USERID -ne 0 ]; then
    echo -e "$R ERROR:: Please run this script with root privilege $N"
    exit 1
fi

mkdir -p "$LOGS_FOLDER"
echo -e "Script started executed at: $(date) " | tee -a "$LOG_FILE"

USAGE(){
    echo "USAGE:: sudo sh 24-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS>[optional, default 14 days]"
    exit 1
}

if [ $# -lt 2 ]; then
   USAGE
fi

DAYS=${3:-14}   # default 14 days if not provided
