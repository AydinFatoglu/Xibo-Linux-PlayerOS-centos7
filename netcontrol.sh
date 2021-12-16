#!/bin/bash
while true ; do
target="google.com"
sleep 60
count=$( ping -c 1 $target | grep icmp* | wc -l )
if [ $count -eq 0 ]
then
date >> /root/pingfail.txt
/sbin/shutdown -r now
else
date >> /root/pingsuccess.txt
fi
done
