#!/bin/bash

# lock the device again (@see unlock.sh)

if [ -f "/tmp/fpunlock.txt" ]; then
	rm /tmp/fpunlock.txt
	activator send libactivator.system.sleepbutton
fi