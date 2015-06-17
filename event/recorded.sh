#!/bin/bash
drec=/var/mobile/Library/Keyboard/DisplayRecorder
recs=/User/Documents/Recordings

sleep 3

cd $drec

for i in {1..50}
do
	last=$(ls -t | grep -i .mov | head -1)
	if [ -z "$last" ]; then
		echo "Waiting..."
		sleep .1
	else
		echo "Breaking wait"
		break
	fi
done
if [ -n "$last" ]; then
	value=$(sbalert -t "Recording" -m "Do you want to rename the recording?" -d "Rename" -a "Just move" -o "Cancel" -p)
	button=$?
	date=$(date +%Y-%m-%d_%H.%M)
	echo "Button $button pressed"
	if [ $button = 0 ]; then
		# clicked on "Rename"
		echo "Renaming $last to $value.mov"
		mv "$drec/$last" $recs/$date-$value.mov
	elif [ $button = 1 ]; then
		# just move
		echo "Moving $last"
		mv "$drec/$last" $recs/$date-$last
	fi
else
	echo "Couldn't find *.mov"
fi