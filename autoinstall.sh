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

cat <<EOT >> /home/$xibouser/.config/openbox/conkyshow.sh
#!/usr/bin/bash

conky &
EOT

cat <<EOT >> /home/$xibouser/.config/openbox/autostart.sh
.config/openbox/startvnc start &
.config/openbox/playercontrol.sh &
.config/openbox/conkyshow.sh &
EOT

chmod +x /home/$xibouser/.config/openbox/autostart.sh
chmod +x /home/$xibouser/.config/openbox/playercontrol.sh
chmod +x /home/$xibouser/.config/openbox/conkyshow.sh

echo "Configureing  XiboPlayer as Service"

cat <<EOT >> /etc/systemd/system/xiboplayer.service
[Unit]
Description=Xibo Service

[Service]
ExecStart=xibo-player
Restart=always

[Install]
WantedBy=multi-user.target
EOT

chmod +x /etc/systemd/system/xiboplayer.service

echo "Configureing  Conky"

rm -f /etc/conky/conky.conf

cat <<EOT >> /etc/conky/conky.conf
alignment top_left
background no
border_width 1
cpu_avg_samples 2
default_color white
default_outline_color white
default_shade_color white
draw_borders no
draw_graph_borders yes
draw_outline no
draw_shades no
use_xft yes
xftfont DejaVu Sans Mono:size=12
gap_x 5
gap_y 60
minimum_size 5 5
net_avg_samples 2
no_buffers yes
out_to_console no
out_to_stderr no
extra_newline no
own_window yes
own_window_class Conky
own_window_type desktop
stippled_borders 0
update_interval 1.0
uppercase no
use_spacer none
show_graph_scale no
show_graph_range no

TEXT
${scroll 16 $nodename }
$hr
${color grey}Uptime:$color $uptime
${color grey}RAM:$color $mem - $memperc% ${membar 4}
${color grey}CPU:$color $cpu% ${cpubar 4}
${color grey}Processes:$color $processes  ${color grey}Running:$color $running_processes
$hr
${color grey}Networking:
Up:$color ${upspeed eth0} ${color grey} - Down:$color ${downspeed eth0}
Ip:${addr eth0}
$hr
EOT

chmod +x /etc/conky/conky.conf


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
