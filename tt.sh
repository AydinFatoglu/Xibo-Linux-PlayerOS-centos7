#!/bin/bash

$xibouser = ttsignage
#$host = TTIPTV


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
Fully automated installer for Centos 7 (2009) x64 platform By AYDINFATOGLU
EOF
echo ""
echo ""

host="USER INPUT"
read -p "YOU MUST ENTER A NEW HOSTNAME: " host
hostnamectl set-hostname $host.teknik.thynet.thy.com



id -u $xibouser &>/dev/null || useradd $xibouser
echo Teknik.209 | passwd $xibouser --stdin

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
Fully automated installer for Centos 7 (2009) x64 platform By AYDINFATOGLU
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

echo "Downloading and Installing Tools"
yum install git -y > /dev/null 2>&1
yum install nano -y > /dev/null 2>&1
yum install wget -y > /dev/null 2>&1

echo "Downloading and Installing Snap For Centos 7"

sudo yum install snapd -y > /dev/null 2>&1
sudo systemctl enable --now snapd.socket > /dev/null 2>&1
sudo ln -s /var/lib/snapd/snap /snap > /dev/null 2>&1

echo "Downloading and Installing Xibo Player From Snap"

sudo snap install xibo-player > /dev/null 2>&1
sleep 5
sudo snap install xibo-player > /dev/null 2>&1

echo "Downloading and Installing Terminator"
yum install -y terminator > /dev/null 2>&1

echo "Downloading and Installing TightVNC Server"
yum install -y tigervnc-server > /dev/null 2>&1
echo "Configureing TightVNC Server"

cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver_$xibouser@:2.service > /dev/null 2>&1
sed -i 's/<USER>/$xibouser/g' /etc/systemd/system/vncserver_$xibouser@:2.service > /dev/null 2>&1
systemctl stop firewalld
systemctl disable firewalld > /dev/null 2>&1
systemctl daemon-reload

runuser -l $xibouser -c '(echo Teknik.209; echo Teknik.209) | vncpasswd'


git clone https://github.com/sebestyenistvan/runvncserver > /dev/null 2>&1
cp ~/runvncserver/startvnc ~
chmod +x ~/startvnc

echo "Configureing AutoStart XiboPlayer"

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

echo "GUI is now enabled"
systemctl set-default graphical.target > /dev/null 2>&1

echo "Auto Login is configured for user $xibouser"

cd /etc/gdm/
sed -i "4i AutomaticLogin=$xibouser" custom.conf
sed -i "5i AutomaticLoginEnable=True" custom.conf


echo "Never Sleep configured"
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target > /dev/null 2>&1
echo "ALL DONE!!!! - REBOOTING NOW..."
sleep 5
sudo reboot






