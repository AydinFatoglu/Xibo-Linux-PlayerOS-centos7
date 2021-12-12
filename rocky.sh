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






dnf update -y -y
dnf upgrade -y -y
dnf install gnome-classic-session -y
systemctl set-default graphical
