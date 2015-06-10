#!/bin/bash

# this script sends the battery status to the server

# battery
sleep 1
battery=$(sbdevice -l)
charging=$(if [ "`sbdevice -s`" = "Charging" ]; then echo "c"; else echo ""; fi)
if [ ! -f /tmp/info-battery.txt ] || [ "$(cat /tmp/info-battery.txt)" != "$charging$battery" ]; then
	echo "$charging$battery" > /tmp/info-battery.txt
	wget -qO- "http://suat.be/api/ios/deviceinfo.php?s=b&v=$battery&$charging" &> /dev/null
fi
