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
Fully automated installer for Centos 7 (v2009) x64 platform By AYDINFATOGLU
EOF
echo ""
echo ""



id -u $xibouser &>/dev/null || useradd $xibouser > /dev/null 2>&1
echo $loginpass | passwd $xibouser --stdin > /dev/null 2>&1



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
Fully automated installer for Centos 7 (v2009) x64 platform By AYDINFATOGLU
EOF


echo ""
echo ""
echo "Downloading and Installing GUI [X Window System / xorg / GDM / Openbox]"
echo "Downloading and Installing GUI [X Window System]"
yum groupinstall "X Window System" -y > /dev/null 2>&1
echo "Downloading and Installing GUI [xorg]"
yum install xorg* -y > /dev/null 2>&1
echo "Downloading and Installing Cockpit"
yum install epel-release -y > /dev/null 2>&1
echo "Downloading and Installing OS Updates"
yum update -y > /dev/null 2>&1
yum install cockpit  -y > /dev/null 2>&1
systemctl start cockpit
systemctl enable cockpit.socket
firewall-cmd --add-service=cockpit
firewall-cmd --add-service=cockpit --permanent
firewall-cmd --reload
echo "Downloading and Installing GUI [GDM]"
yum install gdm -y > /dev/null 2>&1
echo "Downloading and Installing GUI [Openbox]"
yum install openbox -y > /dev/null 2>&1

echo "Downloading and Installing Prerequsits"
yum install git -y > /dev/null 2>&1
yum install nano -y > /dev/null 2>&1
yum install wget -y > /dev/null 2>&1
yum install net-tools -y > /dev/null 2>&1
yum install conky -y > /dev/null 2>&1
yum install -y terminator > /dev/null 2>&1

echo "Downloading and Installing Snap For Centos 7"

sudo yum install snapd -y > /dev/null 2>&1
sudo systemctl enable --now snapd.socket > /dev/null 2>&1
sudo ln -s /var/lib/snapd/snap /snap > /dev/null 2>&1

echo "Downloading and Installing Xibo Player From Snap"

sudo snap install xibo-player > /dev/null 2>&1
sleep 3
sudo snap install xibo-player > /dev/null 2>&1

echo "Downloading and Installing TightVNC Server"
yum install -y tigervnc-server > /dev/null 2>&1

echo "Configureing TightVNC Server"

mkdir /home/$xibouser/.vnc
echo $vncpass | vncpasswd -f > /home/$xibouser/.vnc/passwd
chown -R $xibouser:$xibouser /home/$xibouser/.vnc
chmod 0600 /home/$xibouser/.vnc/passwd

echo "Configureing Firewall"

systemctl stop firewalld
systemctl disable firewalld > /dev/null 2>&1
systemctl daemon-reload

echo "Configureing Start on Login"

mkdir -p /home/$xibouser/.config/openbox

cat <<EOT >> /home/$xibouser/.config/openbox/lcdalwayson.sh
#!/usr/bin/bash
# Example sh file for use with autostart.sh Uncomment below line to use
# Keep screen on
xset -dpms     # Disable DPMS (Energy Star) features
xset s off     # Disable screensaver
xset s noblank # Don't blank video device
EOT

cat <<EOT >> /home/$xibouser/.config/openbox/autostart.sh
# Example autostart.sh for Openbox Uncomment below line to use
.config/openbox/lcdalwayson.sh &
EOT

chmod +x /home/$xibouser/.config/openbox/autostart.sh
chmod +x /home/$xibouser/.config/openbox/lcdalwayson.sh

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
systemctl enable xibo.service > /dev/null 2>&1

echo "Configureing  VNC as Service"

cat <<EOT >> /etc/systemd/system/vnc.service
[Unit]
Description=Remote desktop service (VNC) for :0 display

# Require start of
Requires=display-manager.service

# Wait for
After=network-online.target
After=display-manager.service

[Service]
Type=forking

# Start command
ExecStart=/usr/bin/sh -c 'sleep 3 && /usr/bin/x0vncserver -display :0 -rfbport 5900 -passwordfile /home/$xibouser/.vnc/passwd &'

# Restart service after session log out
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOT

chmod +x /etc/systemd/system/vnc.service
systemctl enable vnc.service > /dev/null 2>&1

echo "Configureing  Conky as Service"

cat <<EOT >> /etc/systemd/system/conky.service
[Unit]
Description=Service Conky
[Service]
Type=simple
RestartSec=5
Environment=DISPLAY=:0
User=$xibouser
ExecStart=/usr/bin/conky
Restart=always
[Install]
WantedBy=default.target
EOT

chmod +x /etc/systemd/system/conky.service
systemctl enable conky.service > /dev/null 2>&1

echo "Overwriteing Default Conky Config "

rm -f /etc/conky/conky.conf
wget -P /etc/conky/ https://raw.githubusercontent.com/AydinFatoglu/Xibo-Linux-PlayerOS-centos7/main/conky.conf > /dev/null 2>&1
chmod +x /etc/conky/conky.conf

echo "GUI enabled"
systemctl set-default graphical.target > /dev/null 2>&1
echo "Setting Time Zone"
sudo timedatectl set-timezone $systimezone


echo "Auto Login is configured for user: $xibouser"

cd /etc/gdm/
sed -i "4i AutomaticLogin=$xibouser" custom.conf
sed -i "5i AutomaticLoginEnable=True" custom.conf

echo "Never Sleep configured"
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target > /dev/null 2>&1

echo "Schedule Reboot configured"
echo '1 0 * * * root /sbin/shutdown -r now' >>/etc/crontab
echo '@reboot root /root/term.sh' >>/etc/crontab
systemctl enable crond

echo "Configureing Network Control Script"
wget https://raw.githubusercontent.com/AydinFatoglu/Xibo-Linux-PlayerOS-centos7/main/netcontrol.sh > /dev/null 2>&1
chmod +x netcontrol.sh


echo "ALL DONE!!!! - REBOOTING NOW..."
sleep 5
sudo reboot







