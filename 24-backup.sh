#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}  # Default to 14 days if not provided

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(basename "$0" .sh)
#LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
LOG_FILE="$LOGS_FOLDER/backup.log" # modified to run the script as command

mkdir -p $LOGS_FOLDER
echo "Script started execute at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]; then
    echo -e "ERROR:: Please run this script with root privilege"
    exit 1 # failure is other 0
fi

USAGE() {
    echo -e "$R USAGE:: sudo sh 24-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS>[optional, default 14 days] $N"
    exit 1
}

### Check SOURCE_DIR and DEST_DIR passed or onot ###
if [ $# -lt 2 ]; then
    USAGE
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "$R ERROR:: Source $SOURCE_DIR does not exist $N"
    exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
    echo -e "$R ERROR:: Destination $DEST_DIR does not exist $N"
    exit 1
fi

FILES=$(find "$SOURCE_DIR" -name "*.log" -type f -mtime +$DAYS)

if [ -n "$FILES" ]; then
    echo -e "$G Files found: $FILES $N"
    TIMESTAMP=$(date +%F-%H-%M)
    ZIP_FILE_NAME="$DEST_DIR/app-log-$TIMESTAMP.zip"
    echo -e "$Y Creating archive: $ZIP_FILE_NAME $N"
    echo "$FILES" | zip -@ -j "$ZIP_FILE_NAME"
else
    echo -e "$Y No files to archive ... SKIPPING $N"
fi
