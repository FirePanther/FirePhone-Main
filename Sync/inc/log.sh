#!/bin/bash
log() {
	mkdir /firephone/log
	date=$(date +%Y-%m-%d_%H.%M)
	logfile="/firephone/log/$(basename ${0%.*}) - $date.log"
	if [ ! -f $logfile ]; then printf "$0\nPWD: $PWD\n" > $logfile; fi
	printf ">>> $1\n" >> $logfile
}