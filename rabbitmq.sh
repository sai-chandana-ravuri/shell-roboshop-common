#!/bin/bash

source ./common.sh
app_name=rabbitmq


check_root

cp $SCRIPT_DIR/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
VALIDATE $? "Added rabbitmq repo"

dnf install rabbitmq-server -y
VALIDATE $? "Installing rabbitmq"

systemctl enable rabbitmq-server
systemctl start rabbitmq-server
VALIDATE $? "Enable and starting Rabbitmq"

rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
VALIDATE $? "Craeted user and given permissions"

print_total_time