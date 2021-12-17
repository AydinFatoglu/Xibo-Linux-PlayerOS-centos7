# Xibo-Linux-PlayerOS-centos7

This is the one and only fully automated install bash script for Centos 7 x64 platform.
It focuses on low ram and cpu usage so only needed components will be installed to run Xibo Linux Player smoothly!

- It will install latest stable version of Xibo Linux Player from Snap.
- It will install latest stable version of Conky to display system info on desktop.
- It will auto logon to pre-definned user by you.
- It will auto start Xibo Linux Player on logon.
- It will auto start Vnc remote accsess when system boots.
- It will auto start Xibo Linux Player if Crashes.
- It will auto restart the operating system every night at 12 AM.
- It will auto restart the operating system if netwok is disconnected.

# Installers

**Centos 7**

yum install wget -y -y && wget https://raw.githubusercontent.com/AydinFatoglu/Xibo-Linux-PlayerOS-centos7/main/autoinstall.sh && chmod +x autoinstall.sh && ./autoinstall.sh

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


