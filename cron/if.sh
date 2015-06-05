#!/bin/bash

# if between 2 and 6 am
if [ "$(date +%k)" -ge 2 ] && [ "$(date +%k)" -le 6 ]; then
	# if FireTime app is running
	if [ -n "$(launchctl list | grep pro.firepanther.FireTime)" ]; then
		# just to be sure, vain glory is not running :D
		if [ -z "$(launchctl list | grep com.superevilmegacorp.vainglory)" ]; then
			# if last run older than 14 hours
			if [ "$(cat /User/Documents/FireCloud/cache/last-if.txt)" -lt "$(expr $(date +%s) - 3600 \* 12)" ]; then
				# if charging
				if [ -n "$(ioreg -l | grep -i 'ExternalConnected\" = Yes')" ]; then
					# if no errors (e.g. device is not locked)
					if [ -z "$(open pro.firepanther.FireTime 2>&1)" ]; then
						sblaunch -b com.google.photos
						sblaunch -b com.reederapp.rkit2.ios
						sblaunch -b com.omnigroup.OmniFocus2.iPhone
						sblaunch -b com.ifttt.ifttt
						sleep 3
						open pro.firepanther.FireTime
						date +%s > /User/Documents/FireCloud/cache/last-if.txt
					fi
				fi
			fi
		fi
	fi
fi
