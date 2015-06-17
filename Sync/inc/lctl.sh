#!/bin/bash

lctl() {
	if [ $1 = "load" ] || [ $1 = "l" ]; then
		plistfilename=$(_findplistlocation "$2")
		if [ -n $plistfilename ]; then launchctl load $plistfilename; fi
	elif [ $1 = "unload" ] || [ $1 = "ul" ] || [ $1 = "u" ]; then
		plistfilename=$(_findplistlocation "$2")
		if [ -n $plistfilename ]; then launchctl unload $plistfilename; fi
	elif [ $1 = "reload" ] || [ $1 = "rl" ] || [ $1 = "r" ]; then
		plistfilename=$(_findplistlocation "$2")
		if [ -n $plistfilename ]; then
			launchctl unload $plistfilename
			launchctl load $plistfilename
		fi
	elif [ $1 = "list" ]; then launchctl list
	elif [ $1 = "lf" ] || [ $1 = "fl" ]; then launchctl list | grep -i "pro.firepanther"
	elif [ $1 = "install" ] || [ $1 = "i" ]; then
		plistfilename=$(_findplistlocation "$2")
		plistfilebasename=$(basename "$plistfilename")
		if [ -f "/Library/LaunchDaemons/$plistfilebasename" ]; then
			lctl unload "/Library/LaunchDaemons/$plistfilebasename"
		fi
		cp -f "$plistfilename" "/Library/LaunchDaemons/$plistfilebasename"
		lctl load "/Library/LaunchDaemons/$plistfilebasename"
		echo "Installed and loaded: $plistfilebasename"
	elif [ -z "$1" ]; then
		cd /Library/LaunchDaemons
	else
		echo "unknown action: $1"
	fi
}
_findplistlocation() {
	# search in current folder
	if [ -f "$1" ]; then echo "$1"
	elif [ -f "$1.plist" ]; then echo "$1.plist"
	elif [ -f "pro.firepanther.$1.plist" ]; then echo "pro.firepanther.$1.plist"
	# search in FireCloud launchDaemons
	elif [ -f "/User/Documents/FireCloud/launchDaemons/$1" ]; then echo "/User/Documents/FireCloud/launchDaemons/$1"
	elif [ -f "/User/Documents/FireCloud/launchDaemons/$1.plist" ]; then echo "/User/Documents/FireCloud/launchDaemons/$1.plist"
	elif [ -f "/User/Documents/FireCloud/launchDaemons/pro.firepanther.$1.plist" ]; then echo "/User/Documents/FireCloud/launchDaemons/pro.firepanther.$1.plist"
	# search in Library LaunchDaemons
	elif [ -f "/Library/LaunchDaemons/$1" ]; then echo "/Library/LaunchDaemons/$1"
	elif [ -f "/Library/LaunchDaemons/$1.plist" ]; then echo "/Library/LaunchDaemons/$1.plist"
	elif [ -f "/Library/LaunchDaemons/pro.firepanther.$1.plist" ]; then echo "/Library/LaunchDaemons/pro.firepanther.$1.plist"
	else echo 2> "Can't find file: $1"
	fi
}
