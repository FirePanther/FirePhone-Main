#!/bin/bash
wget -qrO /tmp/fp-mod.txt http://cloud.suat.be/firepanther/iosmodtime.php
if [ "$(cat /tmp/fp-mod.txt)" -gt "$(cat /User/Documents/FireCloud/cache/last-mod.txt)" ]; then
	. /etc/profile.d/firepanther.sh
	# rm -r /User/Documents/FireCloud/Sync/*
	# todo: replace with list comparison
	wget -qrx -nH -N ftp://ios%40suat.be:$(echo ${TCHostPW} | base64 --decode)@tchost.de -P /User/Documents/FireCloud/Sync
	mv -f /tmp/fp-mod.txt /User/Documents/FireCloud/cache/last-mod.txt
fi
