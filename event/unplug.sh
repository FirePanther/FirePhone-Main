#!/bin/bash

if [ "$(activator current-app)" == "pro.firepanther.FireTime" ]; then
	killall FireTime
	/firephone/event/lock.sh
fi

activator send switch-on.com.a3tweaks.switch.autolock

/firephone/cron/deviceinfo.sh