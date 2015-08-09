#!/bin/bash

# lock the device again (@see unlock.sh)

if [ -f "/tmp/_fp-lock.txt" ]; then
	rm /tmp/_fp-lock.txt
	activator send libactivator.system.sleepbutton
fi