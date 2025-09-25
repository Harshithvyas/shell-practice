#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR":: Please run this script with root privelege"
    exit 1 # failure is other than 0
fi

dnf install mysql -y

if [ $? -ne 0 ]; then
    echo "ERROR:: installing MySql is Failure"
    exit 1
else
    echo "Installing MySql is SUCCESS"
fi        