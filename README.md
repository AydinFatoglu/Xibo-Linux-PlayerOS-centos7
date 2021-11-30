# Xibo-Linux-PlayerOS-centos7

This is the one and only fully automated install bash script for Centos 7 x64 platform.
It focuses on low ram and cpu usage so only needed components will be installed to run Xibo Linux Player smoothly!

- It will install latest stable version of Xibo Linux Player from Snap.
- It will install latest stable version of Conky to display system info on desktop.
- It will auto logon to pre-definned user by you.
- It will auto start Xibo Linux Player on logon.
- It will auto start Xibo Linux Player if Crashes.
- It will auto restart the operating system every night at 1 AM.

# Usage

yum install wget -y -y && wget https://raw.githubusercontent.com/AydinFatoglu/Xibo-Linux-PlayerOS-centos7/main/autoinstall.sh && chmod +x autoinstall.sh && ./autoinstall.sh


# Configuration

Here are some predefined configuration variables to make your life easy 

- xibouser - Auto logon system user
- loginpass - Auto logon system password for user
- vncpass - Vnc Password for remote connection to client
- systimezone - Operating System time zone configuration based on your region (use cmd to get the list: timedatectl list-timezones)


