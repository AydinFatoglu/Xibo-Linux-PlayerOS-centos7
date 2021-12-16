#!/bin/bash
while true ; do

if /sbin/ethtool eth0 | grep -q "Link detected: yes"; then
    sleep 90
else
    /sbin/shutdown -r now
fi
done
