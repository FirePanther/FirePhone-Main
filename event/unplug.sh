#!/bin/bash

if [ "$(activator current-app)" == "pro.firepanther.FireTime" ]; then
	killall FireTime
	activator send libactivator.system.sleepbutton
fi

activator send switch-on.com.a3tweaks.switch.autolock

/firephone/cron/deviceinfo.sh