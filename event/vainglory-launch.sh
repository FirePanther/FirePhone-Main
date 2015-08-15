#!/bin/bash

# dependency: activator, displayrecorder

# include_once
declare -f log > /dev/null; if [ "$?" == "1" ]; then . /firephone/Sync/inc/log.sh; fi

log "launched vainglory"

record=1

# wait/check 10x3 seconds (if vainglory was launched by accident)
for i in {1..3}
do
	sleep 10
	# if vainglory was closed: don't record
	if [ "$(activator current-app)" != "com.superevilmegacorp.kindred" ]; then
		log "vainglory quitted"
		record=0
		break
	fi
done

if [ "$record" == "1" ]; then
	log "recording vainglory, switch on dnd + displayrecorder + autolock"
	activator send switch-on.com.a3tweaks.switch.do-not-disturb
	activator send switch-on.com.rpetrich.displayrecorder
	activator send switch-off.com.a3tweaks.switch.autolock
fi
