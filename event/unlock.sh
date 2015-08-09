#!/bin/bash

# unlocks the device, locks the device on home press

if [ "$(activator current-mode)" == "lockscreen" ]; then
	touch /tmp/_fp-unlock.txt && chown mobile /tmp/_fp-unlock.txt && activator send com.bd452.bypass && sleep 1
fi