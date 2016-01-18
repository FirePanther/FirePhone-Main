#!/bin/bash

# unlocks the device, locks the device on home press

if [ "$(activator current-mode)" == "lockscreen" ]; then
	touch /tmp/_fp-lock.txt && chown mobile /tmp/_fp-lock.txt && activator send com.bd452.bypass && sleep 2
fi