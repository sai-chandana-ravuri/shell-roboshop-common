#!/bin/bash

USER_ID=$(id -u)
LOGS_FOLDER="/var/log/shell-roboshop"
LOGS_FILE="/var/log/shell-roboshop/$0.log"

R='\e[31m'
G='\e[32m'
Y='\e[33m'
B='\e[34m'
N='\e[0m'
START_TIME=$(date +%s)

mkdir -p $LOGS_FOLDER

echo "$(date "+%Y-%M-%D %H:%M:%S) | Script started executing at: $(date)" | tee -a $LOGS_FILE
check_root(){
    if [ $USER_ID -ne 0 ]; then
        echo -e "$R Please use admin access to install.. $N" | tee -a $LOGS_FILE
        exit 1
    else
        echo -e "$G Proceeding with installation.."
    fi
}


VALIDATE(){
if [ $1 -eq 0 ]; then
   echo -e "$(date "+%Y-%M-%D %H:%M:%S) | $2...$G SUCCESS $N" | tee -a $LOGS_FILE
else
   echo -e "$(date "+%Y-%M-%D %H:%M:%S) | $2...$R FAILURE $N" | tee -a $LOGS_FILE
   exit 1
fi
}

print_total_time(){
    END_TIME=$(date +%s)
    TOTAL_TIME=$(( $START_TIME-$END_TIME ))
    echo -e "$(date "+%Y-%M-%D %H:%M:%S) | Script executed in: $G $TOTAL_TIME seconds $N" | tee -a $LOGS_FILE
}