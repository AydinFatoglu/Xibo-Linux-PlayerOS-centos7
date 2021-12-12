#!/bin/bash

#Configuration
###############
xibouser=user
loginpass=1234.
vncpass=88888888
domain=signage.local
systimezone=Europe/Istanbul 
# use cmd to get the list: timedatectl list-timezones
###############

id -u $xibouser &>/dev/null || useradd $xibouser
echo $loginpass | passwd $xibouser --stdin

host="USER INPUT"
read -p "YOU MUST ENTER A NEW HOSTNAME: " host
hostnamectl set-hostname $host.$domain

echo "Setting Hostname as : [$host.$domain]"

echo "STARTING NOW!!!"
sleep 2
clear




dnf update -y -y
dnf upgrade -y -y
dnf install gnome-classic-session -y

























systemctl set-default graphical
