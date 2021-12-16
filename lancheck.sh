if /sbin/ethtool eth0 | grep -q "Link detected: yes"; then
    echo "Online"
else
    echo "Not online"
fi
