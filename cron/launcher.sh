#!/bin/bash

# dependency: sbutils, activator, noslowanimation

# launch some apps in the night to sync some stuff

currentMode=$(activator current-mode)

if [ "$currentMode" == "lockscreen" ]; then locked=1; fi

# if between 2 and 6 am
if [ "$(date +%k)" -ge 0 ] && [ "$(date +%k)" -le 11 ]; then

	# if FireTime app is running
	if [ "$(activator current-app)" == "pro.firepanther.FireTime" ]; then firetime=1; fi
	
	# if not in an (important) app (like vainglory :D)
	if [ "$firetime" == "1" ] || [ "$currentMode" != "application" ]; then
		
		# if last run older than 14 hours
		if [ ! -f /tmp/last-launch.txt ] || [ "$(cat /tmp/last-launch.txt)" -lt "$(expr $(date +%s) - 3600 \* 12)" ]; then
			
			# if charging
			if [ "$(sbdevice -s)" == "Charging" ]; then
				if [ "$locked" == "1" ]; then activator send com.bd452.bypass && sleep 1; fi
				
				sblaunch com.google.photos && sleep 1.5
				sblaunch com.reederapp.rkit2.ios && sleep 1.5
				sblaunch ph.telegra.Telegraph && sleep 1.5
				sblaunch com.atebits.Tweetie2 && sleep 4
				
				if [ "$firetime" == "1" ]; then
					sblaunch pro.firepanther.FireTime
				else
					activator send libactivator.system.homebutton
				fi
				date +%s > /tmp/last-launch.txt
			fi
		fi
	fi
fi

if [ "$locked" == "1" ]; then activator send libactivator.system.sleepbutton; fi
