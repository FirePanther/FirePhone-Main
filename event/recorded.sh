#!/bin/bash
drec=/var/mobile/Library/Keyboard/DisplayRecorder
recs=/User/Documents/Recordings

sleep 5

cd $drec

lastBackUp=$(ls -t | grep -i .mov | head -1)

for i in {1..10}
do
	last=$(ls -t | grep -i .mov | head -1)
	if [ -z "$last" ] && [ "$lastBackUp" == "$last" ]; then
		echo "Waiting..."
		sleep .5
	else
		echo "Breaking wait"
		break
	fi
done
if [ -n "$last" ]; then
	value=$(sbalert -t "Recording" -m "Do you want to rename the recording?" -d "Rename" -a "Delete" -p)
	button=$?
	date=$(date +%Y-%m-%d_%H.%M)
	echo "Button $button pressed"
	if [ $button = 0 ]; then
		# clicked on "Rename"
		if [ -z "$value" ]; then
			echo "Moving $last"
			mv "$drec/$last" $recs/$date-$last
		else
			echo "Renaming $last to $value.mov"
			mv "$drec/$last" $recs/$date-"$value".mov
		fi
	else
		# clicked on "Delete"
		rm "$drec/$last"
	fi
else
	echo "Couldn't find *.mov"
fi
