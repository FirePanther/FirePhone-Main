#!/bin/bash

# dependency: activator, displayrecorder

# include_once
declare -f log > /dev/null; if [ "$?" == "1" ]; then . /firephone/Sync/inc/log.sh; fi

log "quitted vainglory"

# only turn off dnd if it's between 7 and 0 o'clock
hour=$(date +%H)
log "Hour is $hour"
if [ $hour -gt 6 ]; then
	log "(-gt 6), switch off dnd"
	activator send switch-off.com.a3tweaks.switch.do-not-disturb
fi

# finish recording and offer rename
log "switch off displayrecorder"
activator send switch-off.com.rpetrich.displayrecorder
/firephone/event/recorded.sh
