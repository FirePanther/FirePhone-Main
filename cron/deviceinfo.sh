#!/bin/bash

# dependency: sbutils, wget

# this script sends the battery status to the server
. /deviceinfoPassword.sh

# battery
sleep 1
battery=$(sbdevice -l)
charging=$(if [ "`sbdevice -s`" = "Charging" ]; then echo "c"; else echo ""; fi)
if [ ! -f /tmp/_fp-info-battery.txt ] || [ "$(cat /tmp/_fp-info-battery.txt)" != "$charging$battery" ]; then
	echo "$charging$battery" > /tmp/_fp-info-battery.txt && chown mobile /tmp/_fp-info-battery.txt
	wget -qO- "http://suat.be/api/ios/deviceinfo.php?p=$deviceinfoPassword&s=b&v=$battery&$charging" &> /dev/null
	if [ "$battery$charging" == "1.0000c" ]; then play /firephone/sounds/Pop.aiff; fi
fi
