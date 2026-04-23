#!/bin/bash

source ./common.sh

check_root

cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOGS_FILE
VALIDATE $? "Copying Mongo Repo.."

dnf install mongodb-org -y &>>$LOGS_FILE
VALIDATE $? "Installing Mongodb Server.."

systemctl enable mongod &>>$LOGS_FILE
VALIDATE $? "Enabling Mongodb Server.."

systemctl start mongod &>>$LOGS_FILE
VALIDATE $? "Starting Mongodb Server.."

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf 
VALIDATE $? "Allowing connections from internet.."

systemctl restart mongod &>>$LOGS_FILE
VALIDATE $? "Restarting Mongodb Server.."

print_total_time