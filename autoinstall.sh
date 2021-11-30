#!/bin/bash

#Configuration
###############
xibouser=ttsignage
loginpass=Teknik.209
vncpass=Teknik.209
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
hostnamectl set-hostname $host.local

echo "Setting Hostname as : [$host.local]"

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
echo "Downloading and Installing GUI [GDM]"
yum install epel-release -y > /dev/null 2>&1
yum install gdm -y > /dev/null 2>&1
echo "Downloading and Installing GUI [Openbox]"
yum install openbox -y > /dev/null 2>&1

echo "Downloading and Installing Prerequsits"
yum install git -y > /dev/null 2>&1
yum install nano -y > /dev/null 2>&1
yum install wget -y > /dev/null 2>&1
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

git clone https://github.com/sebestyenistvan/runvncserver > /dev/null 2>&1
cp ~/runvncserver/startvnc ~
chmod +x ~/startvnc

echo "Configureing Firewall"

systemctl stop firewalld
systemctl disable firewalld > /dev/null 2>&1
systemctl daemon-reload

echo "Configureing  XiboPlayer AutoStart / Crash Control Script"

mkdir -p /home/$xibouser/.config/openbox
cp ~/startvnc /home/$xibouser/.config/openbox/

cat <<EOT >> /home/$xibouser/.config/openbox/playercontrol.sh
#!/usr/bin/bash
while "true"
do
  xibo-player
done
EOT

chmod +x /home/$xibouser/.config/openbox/playercontrol.sh

cat <<EOT >> /home/$xibouser/.config/openbox/autostart.sh
.config/openbox/startvnc start &
.config/openbox/playercontrol.sh &
EOT

chmod +x /home/$xibouser/.config/openbox/autostart.sh

chmod +x /home/$xibouser/.config/openbox/playercontrol.sh

echo "Configureing  XiboPlayer as Service

cat <<EOT >> /etc/systemd/system/xiboplayer.service
[Unit]
Description=Xibo Service

[Service]
ExecStart=/bin/xibo-player
Restart=always

[Install]
WantedBy=multi-user.target
EOT

chmod +x /etc/systemd/system/xiboplayer.service

systemctl enable xiboplayer.service

echo "GUI enabled"
systemctl set-default graphical.target > /dev/null 2>&1
echo "Setting Time Zone"
sudo timedatectl set-timezone $systimezone


echo "Auto Login is configured for user ttsignage"

cd /etc/gdm/
sed -i "4i AutomaticLogin=ttsignage" custom.conf
sed -i "5i AutomaticLoginEnable=True" custom.conf

echo "Never Sleep configured"
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target > /dev/null 2>&1

echo "Schedule Reboot configured"
echo '00 1 * * * sudo shutdown -r' >>/etc/crontab

echo "ALL DONE!!!! - REBOOTING NOW..."
sleep 5
sudo reboot
