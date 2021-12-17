#!/bin/bash
# Recommend syntax for setting an infinite while loop
while :
do
sleep 60
ping -c4 8.8.8.8
let a=$?
if [ "$a" != "0" ]; then
  /sbin/shutdown -r now
fi

done
