#!/bin/bash

USERID=$(id -u)
SCRIPT_NAME=$(basename "$0")
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # If not provided, default is 14 days

LOGS_FOLDER="/var/log/shell-script"
LOG_FILE="${LOGS_FOLDER}/${SCRIPT_NAME}_log"
echo "Script started executed at: $(date)" | tee -a "$LOG_FILE"

if [ "$USERID" -ne 0 ]; then
    echo "ERROR: Please run this script with root privilege"
    exit 1 # Failure if user is not root
fi

USAGE() {
    echo "USAGE: sudo $SCRIPT_NAME <SOURCE_DIR> <DEST_DIR> [optional: days, default 14]"
    exit 1
}

if [ $# -lt 2 ]; then
    USAGE
fi