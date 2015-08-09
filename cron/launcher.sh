#!/bin/bash

# dependency: sbutils (sbdevice), activator, noslowanimation

# launch some apps in the night to sync some stuff

currentMode=$(activator current-mode)

# if between 2 and 6 am
if [ "$(date +%k)" -ge 0 ] && [ "$(date +%k)" -le 11 ]; then

	# if FireTime app is running
	if [ "$(activator current-app)" == "pro.firepanther.FireTime" ]; then firetime=1; fi
	
	# if not in an (important) app (like vainglory :D)
	if [ "$firetime" == "1" ] || [ "$currentMode" != "application" ]; then
		
		# if last run older than 14 hours
		if [ ! -f /tmp/_fp-last-launch.txt ] || [ "$(cat /tmp/_fp-last-launch.txt)" -lt "$(expr $(date +%s) - 3600 \* 12)" ]; then
			
			# if charging
			if [ "$(sbdevice -s)" == "Charging" ]; then
				/firephone/event/unlock.sh
				
				activator send com.google.photos && sleep 1.5
				activator send com.reederapp.rkit2.ios && sleep 1.5
				activator send ph.telegra.Telegraph && sleep 1.5
				activator send com.atebits.Tweetie2 && sleep 4
				
				if [ "$firetime" == "1" ]; then
					activator send pro.firepanther.FireTime
				else
					activator send libactivator.system.homebutton
				fi
				date +%s > /tmp/_fp-last-launch.txt
			fi
		fi
	fi
fi

/firephone/event/lock.sh
