#!/bin/bash

# dependency: activator, displayrecorder

# include_once
declare -f log > /dev/null; if [ "$?" == "1" ]; then . /firephone/Sync/inc/log.sh; fi

log "launched vainglory"

record=1

# wait/check 30 seconds (if vainglory was launched by accident)
sleep 30
# if vainglory was closed: don't record

# sometimes current-app throws an error
try=5
app=""
while [[ "$app" == *"Activator: Failed"* ]] || [ "$app" == "" ]; do
	sleep 1
	app=$(activator current-app)
	((try--))
	if [ "$try" -lt "1" ]; then break; fi
done
if [ "$app" != "com.superevilmegacorp.kindred" ]; then
	log "vainglory quitted, current app: '$app'"
	record=0
fi

if [ "$record" == "1" ]; then
	log "recording vainglory, switch on dnd + displayrecorder + autolock"
	{
		echo ">>> other outputs\n"
		activator send switch-on.com.a3tweaks.switch.do-not-disturb
		activator send switch-off.com.a3tweaks.switch.autolock
		activator send switch-on.com.rpetrich.displayrecorder
	} >> "$(logfile)"
fi
