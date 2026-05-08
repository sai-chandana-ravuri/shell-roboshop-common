#!/bin/bash

source ./common.sh
app_name=redis


check_root

dnf install mysql-server -y &>>$LOGS_FILE
VALIDATE $? "Installing mysql server"

systemctl enable mysqld &>>$LOGS_FILE
systemctl start mysqld &>>$LOGS_FILE
VALIDATE $? "Enable and starting mysql"

mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOGS_FILE
VALIDATE $? "Creating root user"