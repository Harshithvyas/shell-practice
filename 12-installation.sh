#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR":: Please run this script with root privelege"
fi

dnf install mysql -y

if [ $? -ne 0 ]; then
    echo "ERROR:: installing MySql is Failure"
else
    echo "Installing MySql is SUCCESS"
fi        