#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=$LOGS_FOLDER/$SCRIPT_NAME.log

mkdir -p $LOGS_FOLDER
echo "Script started executed at: $(date)" &>>$LOG_FILE

if [ $USERID -ne 0 ]; then
    echo -e "$R ERROR:: Please run this script with root privilege $N"
    exit 1
fi

VALIDATE(){
  if [ $1 -eq 0 ]; then
    echo -e "Installing $2 ... $G SUCCESS $N"
  else
    echo -e "Installing $2 ... $R FAILURE $N"
    exit 1
  fi
}

 # $@

 for package in $@
 do
      # check package is already installed or not
      dnf list installed $package &>>$LOG_FILE

      #if exit status is 0, already installed, -ne 0 need to install it
      if [ $? -ne 0 ]; then
         dnf install $package -y &>>$LOG_FILE
         VALIDATE $? "$package"
     else
        echo -e "$package already installed ... $v SKIPPING $N"
    fi
    done        