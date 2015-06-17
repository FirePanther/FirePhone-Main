#!/bin/bash
drec=/var/mobile/Library/Keyboard/DisplayRecorder
recs=/User/Documents/Recordings

for i in {1..50}
do
	last=$(ls -t | grep -i .mov | head -1)
	if [ -z $last ]; then
		sleep .1
	else
		break
	fi
done
if [ -n $last ]; then
	value=$(sbalert -t "Recording" -m "Do you want to rename the recording?" -d "Rename" -a "No" -p)
	date=$(date +%Y-%m-%d_%H.%M)
	if [ $? = 0 ]; then
		# clicked on "Rename"
		mv $drec/$last $recs/$date-$value.mov
	else
		# cancelled
		mv $drec/$last $recs/$date-$last
	fi
fi