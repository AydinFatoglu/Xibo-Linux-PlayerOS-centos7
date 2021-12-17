#!/bin/bash
sleep 180
while true ; do

if /sbin/ethtool enp4s0 | grep -q "Link detected: yes"; then
    sleep 90
else
    /sbin/shutdown -r now
fi
done
