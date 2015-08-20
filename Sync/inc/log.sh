#!/bin/bash
log() {
	logfile="$(logfile)"
	if [[ ! -f "$logfile" ]]; then printf "$0\nPWD: $PWD\n" > "$logfile"; fi
	printf ">>> $1\n" >> "$logfile"
}

logfile() {
	if [ ! -d /firephone/log ]; then mkdir /firephone/log; fi
	index=$(($(date +%-d) + $(date +%-m) * 12))
	time=$(date +%H.%M)
	logfile="/firephone/log/${index}_${time} - $(basename /${0%.*}).log"
	echo $logfile
}