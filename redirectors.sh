#!/bin/bash

R="\e[31m"  #to print red colour
G="\e[32m"  #to print green  colour
Y="\e[33m"  #to print yellow colour

LOGS_FOLDER="/var/log/shell-script"  #to store logs in this shell script directory
SCRIPT_NAME=$(echo $0 | cut -d "." -f1) #this will return the folder name 
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S) #this is to craete a timestamp
LOG_FILE="$LOGS_FOLDRE/$SCRIPT_NAME-$TIMESTAMMP.log"  #logfloder , scriptname,timestamp are together

mkdir -p $LOGS_FOLDER #this is to create log folder  -p : is used if this already a director with same name then it will not craete if there is no directory with this name then directory is created

USERID=$(id -u) #will give the used id id it is sudo then O or 1001 /1002..

CHECK_ROOT(){    #this function is to check whether command is run with root access or not , if not exit
   
    if [ $USERID -ne 0 ]
    then
        echo -e "$R Please run this script with root priveleges $N" | tee -a $LOG_FILE
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
       echo -e "$2 is $R FALIED $N" | tee -a $LOG_FILE  #tee command is used to prit log in terminal and in log folder
    exit 1
    else
        echo -e "$2 is $R SUCCESS $N" &>> $LOG_FILE
    fi

}

USAGE(){  #this function is executed if in the command arguments are not passed
    echo -e " $R USAGE: $N sudo $SCRIPT_NAME.sh package1 package1 "
    exit 1
}
 echo "Script started executing at: $(date)"   | tee -a $LOG_FILE

CHECK_ROOT

if [ $# -eq 0 ]  #checks the aruguments are passed or not
then 
   USAGE
   fi
  for PACKAGE in $@   #$@ refers to the all arguments passed to it

  do 
  dnf list installed $PACKAGE &>>$LOG_FILE
  if [ $? -ne 0 ]     #$? is checking last executed command is succesfull or not
    then 
     echo " $PACKAGE is not installed , going to install it.." | tee -a $LOG_FILE # if not successfull install
      dnf install $PACKAGE -y &>> $LOG_FILE
       VALIDATE $? "Installing $PACKAGE"  # validate method is called to checke whether installation is completed or not
  else
  echo -e "$PACKAGE is already $Y installed" $N | tee -a $LOG_FILE
fi
done

