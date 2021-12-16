#!/bin/bash
while true ; do
target="google.com"
sleep 90
count=$( ping -c 1 $target | grep icmp* | wc -l )
if [ $count -eq 0 ]
then

/sbin/shutdown -r now
else

fi
done
