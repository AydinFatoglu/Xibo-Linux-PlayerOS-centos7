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

clear
cat << "EOF"

 /$$   /$$ /$$$$$$ /$$$$$$$   /$$$$$$        /$$$$$$$  /$$                                                /$$$$$$   /$$$$$$ 
| $$  / $$|_  $$_/| $$__  $$ /$$__  $$      | $$__  $$| $$                                               /$$__  $$ /$$__  $$
|  $$/ $$/  | $$  | $$  \ $$| $$  \ $$      | $$  \ $$| $$  /$$$$$$  /$$   /$$  /$$$$$$   /$$$$$$       | $$  \ $$| $$  \__/
 \  $$$$/   | $$  | $$$$$$$ | $$  | $$      | $$$$$$$/| $$ |____  $$| $$  | $$ /$$__  $$ /$$__  $$      | $$  | $$|  $$$$$$ 
  >$$  $$   | $$  | $$__  $$| $$  | $$      | $$____/ | $$  /$$$$$$$| $$  | $$| $$$$$$$$| $$  \__/      | $$  | $$ \____  $$
 /$$/\  $$  | $$  | $$  \ $$| $$  | $$      | $$      | $$ /$$__  $$| $$  | $$| $$_____/| $$            | $$  | $$ /$$  \ $$
| $$  \ $$ /$$$$$$| $$$$$$$/|  $$$$$$/      | $$      | $$|  $$$$$$$|  $$$$$$$|  $$$$$$$| $$            |  $$$$$$/|  $$$$$$/
|__/  |__/|______/|_______/  \______/       |__/      |__/ \_______/ \____  $$ \_______/|__/             \______/  \______/ 
                                                                     /$$  | $$                                              
                                                                    |  $$$$$$/                                              
                                                                     \______/                                               
Fully automated installer for Centos 8 (v211) x64 platform By AYDINFATOGLU
EOF
echo ""
echo ""



id -u $xibouser &>/dev/null || useradd $xibouser 
echo $loginpass | passwd $xibouser --stdin





host="USER INPUT"
read -p "YOU MUST ENTER A NEW HOSTNAME: " host
hostnamectl set-hostname $host.$domain

echo "Setting Hostname as : [$host.$domain]"

echo "STARTING NOW!!!"
sleep 2
clear

cat << "EOF"

 /$$   /$$ /$$$$$$ /$$$$$$$   /$$$$$$        /$$$$$$$  /$$                                                /$$$$$$   /$$$$$$ 
| $$  / $$|_  $$_/| $$__  $$ /$$__  $$      | $$__  $$| $$                                               /$$__  $$ /$$__  $$
|  $$/ $$/  | $$  | $$  \ $$| $$  \ $$      | $$  \ $$| $$  /$$$$$$  /$$   /$$  /$$$$$$   /$$$$$$       | $$  \ $$| $$  \__/
 \  $$$$/   | $$  | $$$$$$$ | $$  | $$      | $$$$$$$/| $$ |____  $$| $$  | $$ /$$__  $$ /$$__  $$      | $$  | $$|  $$$$$$ 
  >$$  $$   | $$  | $$__  $$| $$  | $$      | $$____/ | $$  /$$$$$$$| $$  | $$| $$$$$$$$| $$  \__/      | $$  | $$ \____  $$
 /$$/\  $$  | $$  | $$  \ $$| $$  | $$      | $$      | $$ /$$__  $$| $$  | $$| $$_____/| $$            | $$  | $$ /$$  \ $$
| $$  \ $$ /$$$$$$| $$$$$$$/|  $$$$$$/      | $$      | $$|  $$$$$$$|  $$$$$$$|  $$$$$$$| $$            |  $$$$$$/|  $$$$$$/
|__/  |__/|______/|_______/  \______/       |__/      |__/ \_______/ \____  $$ \_______/|__/             \______/  \______/ 
                                                                     /$$  | $$                                              
                                                                    |  $$$$$$/                                              
                                                                     \______/                                               
Fully automated installer for Centos 8 (v211) x64 platform By AYDINFATOGLU
EOF


echo ""
echo ""
echo "Downloading and Installing GUI [GNOME Clasic Session / GDM]"
yum install gnome-classic-session -y 

cat <<EOT >> /var/lib/AccountsService/users/$xibouser
# This file contains defaults for new users. To edit, first
# copy it to /etc/accountsservice/user-templates and make changes
# there

[com.redhat.AccountsServiceUser.System]
id='almalinux'
version-id='8.5'

[User]
Session=gnome-classic-wayland
Icon=/home/test/.face
SystemAccount=false
EOT




echo "Downloading and Installing Prerequsits"
yum install git -y
yum install nano -y
yum install wget -y


echo "Downloading and Installing Snap For Centos 8"

sudo dnf install epel-release -y -y
sudo dnf upgrade -y -y
sudo yum install snapd -y
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

echo "Downloading and Installing Xibo Player From Snap"

setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed '7s/^#//' -i /etc/gdm/custom.conf

sudo snap install xibo-player
sleep 3
sudo snap install xibo-player

echo "Downloading and Installing TightVNC Server"
dnf install tigervnc-server tigervnc-server-module -y


echo "Configureing TightVNC Server"




mkdir /home/$xibouser/.vnc
echo $vncpass | vncpasswd -f > /home/$xibouser/.vnc/passwd
chown -R $xibouser:$xibouser /home/$xibouser/.vnc
chmod 0600 /home/$xibouser/.vnc/passwd

echo "Configureing  VNC as Service"

cat <<EOT >> /etc/systemd/system/vnc.service
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target
[Service]
Type=forking
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/sbin/runuser -l $xibouser -c "/usr/bin/vncserver %i -geometry 1280x1024"
PIDFile=/home/$xibouser/.vnc/%H%i.pid
ExecStop=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
[Install]
WantedBy=multi-user.target
EOT

chmod +x /etc/systemd/system/vnc.service
systemctl enable vnc.service


echo "Configureing Firewall"

systemctl stop firewalld
systemctl disable firewalld
systemctl daemon-reload

echo "Configureing Start on Login"


echo "Configureing  XiboPlayer as Service"

cat <<EOT >> /etc/systemd/system/xibo.service
[Unit]
Description=Service Xibo-client
[Service]
Type=simple
RestartSec=10
Environment=DISPLAY=:0
User=$xibouser
ExecStart=/snap/bin/xibo-player
Restart=always
[Install]
WantedBy=default.target
EOT

chmod +x /etc/systemd/system/xibo.service
systemctl enable xibo.service







echo "GUI enabled"
systemctl set-default graphical.target
echo "Setting Time Zone"
sudo timedatectl set-timezone $systimezone


echo "Auto Login is configured for user: $xibouser"

cd /etc/gdm/
sed -i "4i AutomaticLogin=$xibouser" custom.conf
sed -i "5i AutomaticLoginEnable=True" custom.conf

echo "Never Sleep configured"
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

echo "Schedule Reboot configured"
echo '00 1 * * * sudo shutdown -r' >>/etc/crontab

echo "ALL DONE!!!! - REBOOTING NOW..."
sleep 5
sudo reboot
