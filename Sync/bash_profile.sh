export PS1='\[\033[01;34m\]\w
\[\033[01;31m\]\u $ \[\033[00m\]'
umask 022

alias hlp="echo \"- FirePanther Help -
myip                Shows your local ip
ll                  ls -hl
l                   ls -hlA
s                   ssh as root
.., ...             One or two dirs up
fcget               FireCloud get (sync)
rlb                 Reaload bash_profile

- SSH -
sshl                Load ssh daemon
sshu                Unload ssh daemon
sshk                Kick everyone from ssh

- LCTL -
lctl load x         Load LaunchDaemon
lctl unload x       Unload LaunchDaemon
lctl reload x       Unload and than load LaunchDaemon
lctl list           List all LaunchDaemons
lctl fl             List FirePanther LaunchDaemons
lctl install x      Install a new LaunchDaemon

- CD -
cld                 Goto LaunchDaemons
cfc                 Goto FireCloud
capp                Goto (Bundle) Application
\""

alias ls='ls -h'
alias ll='ls -hl'
alias l='ls -hlA'
alias ..='cd ..'
alias ...='cd ../..'
alias s='ssh -l root'

alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"

# firecloud get
alias fcget='/User/Documents/FireCloud/cron/sync.sh'

# reload bash
alias rlb='. /User/Documents/FireCloud/Sync/bash_profile.sh'

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
	elif [ -n $1 ]; then
		cd /Library/LaunchDaemons
	else
		echo "unknown action: $1"
	fi
}
_findplistlocation() {
	if [ -f "$1" ]; then echo "$1"
	elif [ -f "/Library/LaunchDaemons/$1" ]; then echo "/Library/LaunchDaemons/$1"
	elif [ -f "$1.plist" ]; then echo "$1.plist"
	elif [ -f "/Library/LaunchDaemons/$1.plist" ]; then echo "/Library/LaunchDaemons/$1.plist"
	elif [ -f "pro.firepanther.$1.plist" ]; then echo "pro.firepanther.$1.plist"
	elif [ -f "/Library/LaunchDaemons/pro.firepanther.$1.plist" ]; then echo "/Library/LaunchDaemons/pro.firepanther.$1.plist"
	else echo 2> "Can't find file: $1"
	fi
}

# play sound
{ sleep .1 && play /User/Documents/FireCloud/Sync/audio/ssh-connected.aiff& disown; } 2>/dev/null

# change dir aliasses
alias cld='cd /Library/LaunchDaemons'
alias cfc='cd /User/Documents/FireCloud'
alias capp='cd /var/mobile/Containers/Bundle/Application'

echo -e "\033[1;33m iOS version:     \033[0m" `sw_vers -productVersion`
echo -e "\033[1;33m System time:     \033[0m" `date`
echo -e "\033[1;33m User:            \033[0m" `/usr/bin/who`

