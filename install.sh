#!/bin/bash
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
The one and only fully automated installer for Centos 7 x64 platform!
EOF
echo ""
echo ""

#id -u youruser &>/dev/null || useradd youruser
#echo yourpass | passwd youruser --stdin

#hostnamectl set-hostname yourhost.local



xibouser="USER INPUT"
read -p "YOU MUST ENTER A NEW USERNAME FOR THIS SIGNAGE DISPLAY: " xibouser
id -u $xibouser &>/dev/null || useradd $xibouser
echo "YOU MUST ENTER A NEW PASSWORD (twice) FOR USER [$xibouser]"
passwd $xibouser

host="USER INPUT"
read -p "YOU MUST ENTER A NEW HOSTNAME: " host
hostnamectl set-hostname $host.local

echo "Createing User : [$xibouser]"
echo "Setting Hostname as : [$host.local]"

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
systemctl disable firewalld
systemctl daemon-reload

echo "YOU MUST ENTER A NEW PASSWORD FOR VNC ACCESS"
runuser -l $xibouser -c 'vncpasswd'
#(echo mypass; echo mypass) | vncpasswd

git clone https://github.com/sebestyenistvan/runvncserver > /dev/null 2>&1
cp ~/runvncserver/startvnc ~
chmod +x ~/startvnc

echo "Configureing AutoStart"

mkdir -p /home/$xibouser/.config/openbox
cp ~/startvnc /home/$xibouser/.config/openbox/
cat <<EOT >> /home/$xibouser/.config/openbox/autostart.sh
/home/$xibouser/.config/openbox/startvnc start
xibo-player
EOT
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
