#!/bin/bash

# dependency: sbutils (sbdevice), activator, noslowanimation

# launch some apps in the night to sync some stuff

currentMode=$(activator current-mode)

# if between 0 and 11 am
if [ "$(date +%k)" -ge 0 ] && [ "$(date +%k)" -le 8 ]; then
	# if not in an (important) app
	if [ "$currentMode" == "lockscreen" ]; then
		
		# if last run older than 14 hours
		if [ ! -f /tmp/_fp-last-launch.txt ] || [ "$(cat /tmp/_fp-last-launch.txt)" -lt "$(expr $(date +%s) - 3600 \* 12)" ]; then
			
			# if charging
			if [ "$(sbdevice -s)" == "Charging" ]; then
				/firephone/event/unlock.sh
				
				activator send com.reederapp.rkit2.ios && sleep 2
				activator send ph.telegra.Telegraph && sleep 2
				
				# tweetbot api: http://tapbots.net/tweetbot3/support/url-schemes/
				uiopen tweetbot://FirePanther/timeline & sleep 4
				
				#activator send com.getdropbox.Dropbox && sleep 4
				activator send com.airmailapp.iphone && sleep 4
				
				activator send com.google.photos && sleep 4
				
				# todoist api: https://github.com/Doist/todoist-api/blob/master/source/includes/_urlschemes.md
				uiopen todoist://today && sleep 4
				
				date +%s > /tmp/_fp-last-launch.txt
			fi
		fi
	fi
fi

/firephone/event/lock.sh
