#!/bin/bash

# dependency: activator, bypass, noslowanimations

if [ -f "/tmp/bt.txt" ] && [ "$(cat /tmp/bt.txt)" == "1" ]; then
	activator send com.bd452.bypass && sleep 1 && sblaunch com.waze.iphone
fi
