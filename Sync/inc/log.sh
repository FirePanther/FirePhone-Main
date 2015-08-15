#!/bin/bash
log() {
	mkdir /firephone/log
	date=$(date +%Y-%m-%d_%H.%M)
	printf "$0\nPWD: $PWD\n$1\n" >> "/firephone/log/$(basename ${0%.*}) - $date.log"
}