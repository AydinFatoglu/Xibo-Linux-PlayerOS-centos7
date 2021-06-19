#!/bin/bash

echo "Createing User : ttsignage"

id -u ttsignage &>/dev/null || useradd ttsignage
echo Teknik.209 | passwd ttsignage --stdin

echo "Downloading and Installing GUI"

yum groupinstall "X Window System" -y
yum install xorg* -y
yum install epel-release -y
yum install gdm -y
yum install openbox -y

echo "Downloading and Installing Snap For Centos 7"

sudo yum install snapd -y
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

echo "Downloading and Installing Xibo Player From Snap"

sudo snap install xibo-player
sleep 5
sudo snap install xibo-player

echo "GUI is now enabled"

systemctl set-default graphical.target

echo "Auto Login is configured for user ttsignage"

cd /etc/gdm/
sed -i "4i AutomaticLogin=ttsignage" custom.conf
sed -i "5i AutomaticLoginEnable=True" custom.conf

echo "Xibo Player Auto Start at logon configured"

mkdir /home/ttsignage/.config/
cd /home/ttsignage/.config/
mkdir openbox
cd openbox
echo "xibo-player" > autostart.sh

host="USER INPUT"
read -p "YOU MUST ENTER A NEW HOSTNAME: " host
hostnamectl set-hostname $host.teknik.thynet.thy.com
echo "ALL DONE!!!! - REBOOTING NOW..."
sleep 5
sudo reboot
