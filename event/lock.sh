#!/bin/bash

# lock the device again (@see unlock.sh)

if [ -f "/tmp/_fp-unlock.txt" ]; then
	rm /tmp/_fp-unlock.txt
	activator send libactivator.system.sleepbutton
fi