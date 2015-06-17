#!/bin/bash

# ssh control
alias sshl='launchctl load -w /Library/LaunchDaemons/com.openssh.sshd.plist'
alias sshu='launchctl unload -w /Library/LaunchDaemons/com.openssh.sshd.plist'
sshk() {
	if [ -z "$1" ]; then sshuser="$(launchctl list | grep com.openssh.sshd.)"
	else sshuser=$1; fi
	if [ -n "$sshuser" ]; then
		killpid=$(echo $sshuser | head -1 | cut -f1 -d" ")
		if [ -n "$2" ] && [ "$killpid" = "$2" ]; then echo "Quitting loop"
		else
			kill "$killpid"
			sshuser="$(launchctl list | grep com.openssh.sshd.)"
			if [ -n "$sshuser" ]; then sshk "$sshuser" "$killpid"; fi
		fi
	fi
}