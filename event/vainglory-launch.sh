#!/bin/bash

# dependency: activator

record=1

# wait/check 15x3 seconds
for i in {1..3}
do
	sleep 15
	# if vainglory was closed: don't record
	if [ "$(activator current-app)" != "com.superevilmegacorp.kindred" ]; then
		record=0
		break
	fi
done

if [ "$record" == "1" ]; then
	activator send switch-on.com.a3tweaks.switch.do-not-disturb
	activator send switch-on.com.rpetrich.displayrecorder
fi
