#!/bin/bash

source ./common.sh
app_name=frontend

check_root

dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y
VALIDATE $? "Enable and installing nginx"

systemctl enable nginx 
systemctl start nginx 
VALIDATE $? "Enable and start nginx"

rm -rf /usr/share/nginx/html/* 
VALIDATE $? "Removing default content"

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
VALIDATE $? "Downlaoding code"

cd /usr/share/nginx/html 
unzip /tmp/frontend.zip
VALIDATE $? "Unzipping code"

rm -rf /etc/nginx/nginx.conf

cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf
VALIDATE $? "Replacing nginx content"

systemctl restart nginx 
VALIDATE $? "Restarted nginx"

print_total_time