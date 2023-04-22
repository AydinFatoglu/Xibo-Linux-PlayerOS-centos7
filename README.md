# Xibo-Linux-PlayerOS-centos7

This is the only fully automated bash script for installing on the Centos 7 x64 platform. It is designed to prioritize low RAM and CPU usage, ensuring that only the necessary components are installed to run the Xibo Linux Player smoothly.

This script will install the latest stable version of the Xibo Linux Player from Snap, as well as the latest stable versions of Conky for displaying system information on the desktop and Cockpit System Monitor Web Interface. It will also log in automatically to a user of your choice, start the Xibo Linux Player on login, and enable VNC remote access when the system boots.

In addition, the script will automatically restart the operating system every night at 12 AM and also in case the network is disconnected. It will also automatically restart the Xibo Linux Player if it crashes.



# Installers

**Centos 7 Configurator (Yum Package Downloads ONLY)**

yum install wget -y -y && wget https://raw.githubusercontent.com/AydinFatoglu/Xibo-Linux-PlayerOS-centos7/main/download.sh && chmod +x download.sh && ./download.sh

**Centos 7 Configurator (Yum Package Downloads NOT Included)**

yum install wget -y -y && wget https://raw.githubusercontent.com/AydinFatoglu/Xibo-Linux-PlayerOS-centos7/main/configure.sh && chmod +x configure.sh && ./configure.sh

**Centos 8**

yum install wget -y -y && wget https://raw.githubusercontent.com/AydinFatoglu/Xibo-Linux-PlayerOS-centos7/main/centos8.sh && chmod +x centos8.sh && ./centos8.sh

**Rocky Linux 8**

yum install wget -y -y && wget https://raw.githubusercontent.com/AydinFatoglu/Xibo-Linux-PlayerOS-centos7/main/rocky.sh && chmod +x rocky.sh && ./rocky.sh


# Configuration

Here are some predefined configuration variables to make your life easy.

Check configuration section of the script for more details.

- xibouser - Auto logon system user
- loginpass - Auto logon system password for user
- vncpass - Vnc Password for remote connection to client
- systimezone - Operating System time zone configuration based on your region (use cmd to get the list: timedatectl list-timezones)


