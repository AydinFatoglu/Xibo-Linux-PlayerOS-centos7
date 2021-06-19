#!/bin/bash

xibouser="USER INPUT"
read -p "YOU MUST ENTER A NEW USERNAME FOR SIGNAGE DISPLAY: " xibouser
id -u $xibouser &>/dev/null || useradd $xibouser > /dev/null 2>&1

userpass="USER INPUT"
read -s "YOU MUST ENTER A PASSWORD FOR THIS USE: " userpass
echo $userpass | passwd $xibouser --stdin > /dev/null 2>&1

host="USER INPUT"
read -p "YOU MUST ENTER A NEW HOSTNAME: " host
hostnamectl set-hostname $host.teknik.thynet.thy.com

echo "Createing User : $xibouser"
echo "Setting Hostname : $host"

echo "Downloading and Installing GUI [X Window System / xorg / GDM / Openbox]"
echo "Downloading and Installing GUI [X Window System]"
yum groupinstall "X Window System" -y > /dev/null 2>&1
echo "Downloading and Installing GUI [xorg]"
yum install xorg* -y > /dev/null 2>&1
echo "Downloading and Installing GUI [GDM]"
yum install epel-release -y > /dev/null 2>&1
yum install gdm -y > /dev/null 2>&1
echo "Downloading and Installing GUI [Openbox]"
yum install openbox -y > /dev/null 2>&1

echo "Downloading and Installing Snap For Centos 7"

sudo yum install snapd -y > /dev/null 2>&1
sudo systemctl enable --now snapd.socket > /dev/null 2>&1
sudo ln -s /var/lib/snapd/snap /snap > /dev/null 2>&1

echo "Downloading and Installing Xibo Player From Snap"

sudo snap install xibo-player > /dev/null 2>&1
sleep 5
sudo snap install xibo-player > /dev/null 2>&1

echo "GUI is now enabled"

systemctl set-default graphical.target > /dev/null 2>&1

echo "Auto Login is configured for user $xibouser"

cd /etc/gdm/
sed -i "4i AutomaticLogin=$xibouser" custom.conf
sed -i "5i AutomaticLoginEnable=True" custom.conf

echo "Xibo Player Auto Start at logon configured"

mkdir /home/$xibouser/.config/
cd /home/$xibouser/.config/
mkdir openbox
cd openbox
echo "xibo-player" > autostart.sh

echo "ALL DONE!!!! - REBOOTING NOW..."
sleep 5
sudo reboot
