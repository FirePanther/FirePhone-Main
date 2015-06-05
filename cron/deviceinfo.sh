#!/bin/bash

# this script sends the battery status to the server

# battery
battery=$(sbdevice -l)
if [ ! -f /tmp/info-battery.txt ] || [ "$(cat /tmp/info-battery.txt)" != "$battery" ]; then
	echo $battery > /tmp/info-battery.txt
	wget -qO- "http://suat.be/api/ios/deviceinfo?s=b&v=$battery" &> /dev/null
fi
