#!/bin/bash

# dependency: activator, displayrecorder

# only turn off dnd if it's between 7 and 0 o'clock
hour=$(date +%H)
if [ $hour -gt 6 ]; then
	activator send switch-off.com.a3tweaks.switch.do-not-disturb
fi

# finish recording and offer rename
activator send switch-off.com.rpetrich.displayrecorder
/firephone/event/recorded.sh
