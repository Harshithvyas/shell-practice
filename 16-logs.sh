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

# MySQL
dnf list installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]; then
  dnf install mysql -y &>>$LOG_FILE
  VALIDATE $? "MySQL"
else
  echo -e "MySQL already exists ... $Y SKIPPING $N"
fi

# Nginx
dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ]; then
  dnf install nginx -y &>>$LOG_FILE
  VALIDATE $? "Nginx"
else
  echo -e "Nginx already exists ... $Y SKIPPING $N"
fi

# Python3
dnf list installed python3 &>>$LOG_FILE
if [ $? -ne 0 ]; then
  dnf install python3 -y &>>$LOG_FILE
  VALIDATE $? "Python3"
else
  echo -e "Python3 already exists ... $Y SKIPPING $N"
fi
