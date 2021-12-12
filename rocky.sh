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
sudo dnf install epel-release -y -y
yum install gnome-classic-session -y
systemctl set-default graphical

sudo yum install snapd -y
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

sudo snap install xibo-player
sleep 3
sudo snap install xibo-player

echo "Configureing  XiboPlayer as Service"

cat <<EOT >> /etc/systemd/system/xibo.service
[Unit]
Description=Service Xibo-client
[Service]
Type=simple
RestartSec=10
Environment=DISPLAY=:0
User=$xibouser
ExecStart=/bin/bash -c '/snap/bin/xibo-player'
Restart=always
[Install]
WantedBy=default.target
EOT

chmod +x /etc/systemd/system/xibo.service
systemctl enable xibo.service




sudo dnf install tigervnc-server -y

cat <<EOT >> /etc/systemd/system/vnc@:1.service
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/usr/libexec/vncsession-start %i
PIDFile=/run/vncsession-%i.pid
SELinuxContext=system_u:system_r:vnc_session_t:s0

# Restart service after session log out
Restart=on-failure
RestartSec=10


[Install]
WantedBy=multi-user.target
EOT

chmod +x /etc/systemd/system/vnc@:1.service
systemctl enable vnc@:1.service



mkdir /home/$xibouser/.vnc
echo $vncpass | vncpasswd -f > /home/$xibouser/.vnc/passwd
chown -R $xibouser:$xibouser /home/$xibouser/.vnc
chmod 0600 /home/$xibouser/.vnc/passwd

cd /etc/gdm/
sed -i "4i AutomaticLogin=$xibouser" custom.conf
sed -i "5i AutomaticLoginEnable=True" custom.conf

echo "Setting Time Zone"
sudo timedatectl set-timezone $systimezone





























