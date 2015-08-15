#!/bin/bash
log() {
	if [ ! -d /firephone/log ]; then mkdir /firephone/log; fi
	index=$(expr $(date +%d) + $(date +%m) + $(date +%y))
	time=$(date +%H.%M)
	logfile="/firephone/log/${index}_${time} - $(basename /${0%.*}).log"
	if [[ ! -f "$logfile" ]]; then printf "$0\nPWD: $PWD\n" > $logfile; fi
	printf ">>> $1\n" >> "$logfile"
}
