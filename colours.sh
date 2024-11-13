#!/bin/bash
#!/bin/bash
R="\e[31m"
G="\e[32m"
N="\e[0m"
USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
echo " Please runt his script with root priveleges"
exit 1
fi

dnf list installed git -y

if [ $? -ne 0 ]
then 
echo -e " $R GIT is not installed...please check $N"
dnf installed git -y
if [ $? -ne 0 ]
then 
echo "GIT is not installed ..please check"
else
echo "GIT installed"
fi
else
echo "GIT is already installed"
fi

dnf list install mysql -y

if [ $? -ne 0 ]
then 
echo "Mysql is not installed...please check"
dnf install mysql -y
if [ $? -ne 0 ]
then 
echo "Mysql is not installed ..please check"
else
echo "Mysql is installation completed"
fi
else
echo "Mysql is already installed"
fi