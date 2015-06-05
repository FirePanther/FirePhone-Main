#!/bin/bash

# launch some apps in the night to sync some stuff

# if between 2 and 6 am
if [ "$(date +%k)" -ge 2 ] && [ "$(date +%k)" -le 6 ]; then
	# if FireTime app is running
	if [ -n "$(launchctl list | grep pro.firepanther.FireTime)" ]; then
		# just to be sure, vain glory is not running :D
		if [ -z "$(launchctl list | grep com.superevilmegacorp)" ]; then
			# if last run older than 14 hours
			if [ ! -f /tmp/last-launch.txt ] || [ "$(cat /tmp/last-launch.txt)" -lt "$(expr $(date +%s) - 3600 \* 12)" ]; then
				# if charging
				if [ -n "$(ioreg -l | grep -i 'ExternalConnected\" = Yes')" ]; then
					sblaunch -b com.google.photos
					sblaunch -b com.reederapp.rkit2.ios
					sblaunch -b com.omnigroup.OmniFocus2.iPhone
					sblaunch -b com.ifttt.ifttt
					sblaunch -b ph.telegra.Telegraph
					sleep 3
					open pro.firepanther.FireTime
					date +%s > /tmp/last-launch.txt
				fi
			fi
		fi
	fi
fi
