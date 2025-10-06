#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(basename "$0")
LOG_FILE="$LOGS_FOLDER/${SCRIPT_NAME%.sh}.log"

mkdir -p "$LOGS_FOLDER"
echo -e "${Y}Script started at: $(date)${N}" | tee -a "$LOG_FILE"

SOURCE_DIR="/home/ec2-user/app-logs"

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${Y}Directory $SOURCE_DIR not found. Creating now...${N}" | tee -a "$LOG_FILE"
    mkdir -p "$SOURCE_DIR"
    echo -e "${G}Created directory: $SOURCE_DIR${N}" | tee -a "$LOG_FILE"
fi

FILES_TO_DELETE=$(find "$SOURCE_DIR" -name "*.log" -type f -mtime +14)

if [ -z "$FILES_TO_DELETE" ]; then
    echo -e "${Y}No old log files found to delete.${N}" | tee -a "$LOG_FILE"
else
    while IFS= read -r filepath; do
        echo -e "${R}Deleting file: $filepath${N}" | tee -a "$LOG_FILE"
        rm -f "$filepath"
    done <<< "$FILES_TO_DELETE"
    echo -e "${G}Old log files deleted successfully.${N}" | tee -a "$LOG_FILE"
fi
