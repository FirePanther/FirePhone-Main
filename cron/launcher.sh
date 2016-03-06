#!/bin/bash

# dependency: sbutils (sbdevice), activator, noslowanimation

# launch some apps in the night to sync some stuff

currentMode=$(activator current-mode)
firetime=0

# if between 0 and 11 am
if [ "$(date +%k)" -ge 0 ] && [ "$(date +%k)" -le 8 ]; then

	# if FireTime app is running
	if [ "$(activator current-app)" == "pro.firepanther.FireTime" ]; then firetime=1; fi
	
	# if not in an (important) app (like vainglory :D)
	if [ "$firetime" == "1" ] || [ "$currentMode" == "lockscreen" ]; then
		
		# if last run older than 14 hours
		if [ ! -f /tmp/_fp-last-launch.txt ] || [ "$(cat /tmp/_fp-last-launch.txt)" -lt "$(expr $(date +%s) - 3600 \* 12)" ]; then
			
			# if charging
			if [ "$(sbdevice -s)" == "Charging" ]; then
				/firephone/event/unlock.sh
				
				activator send com.reederapp.rkit2.ios && sleep 2
				activator send ph.telegra.Telegraph && sleep 2
				activator send com.tapbots.Tweetbot4 && sleep 4
				activator send com.getdropbox.Dropbox && sleep 4
				activator send com.airmailapp.iphone && sleep 4
				activator send com.todoist.ios && sleep 4
				
				if [ "$firetime" == "1" ]; then
					activator send pro.firepanther.FireTime && sleep 2
				
				# don't use homebutton anymore, let todoist open for me for the next day :)
				# else
					#activator send libactivator.system.homebutton && sleep 1
					
				fi
				date +%s > /tmp/_fp-last-launch.txt
			fi
		fi
	fi
fi

/firephone/event/lock.sh
