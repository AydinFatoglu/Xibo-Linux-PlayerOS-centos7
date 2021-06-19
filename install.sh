#!/bin/bash

echo "Createing User : ttsignage"

id -u ttsignage &>/dev/null || useradd ttsignage > /dev/null 2>&1
echo Teknik.209 | passwd ttsignage --stdin > /dev/null 2>&1

echo "Downloading and Installing GUI"

yum groupinstall "X Window System" -y > /dev/null 2>&1
yum install xorg* -y > /dev/null 2>&1
yum install epel-release -y > /dev/null 2>&1
yum install gdm -y > /dev/null 2>&1
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

echo "Auto Login is configured for user ttsignage"

cd /etc/gdm/
sed -i "4i AutomaticLogin=ttsignage" custom.conf
sed -i "5i AutomaticLoginEnable=True" custom.conf

echo "Xibo Player Auto Start at logon configured"

mkdir /home/ttsignage/.config/ > /dev/null 2>&1
cd /home/ttsignage/.config/ > /dev/null 2>&1
mkdir openbox > /dev/null 2>&1
cd openbox > /dev/null 2>&1
echo "xibo-player" > autostart.sh > /dev/null 2>&1

host="USER INPUT"
read -p "YOU MUST ENTER A NEW HOSTNAME: " host
hostnamectl set-hostname $host.teknik.thynet.thy.com
echo "ALL DONE!!!! - REBOOTING NOW..."
sleep 5
sudo reboot
