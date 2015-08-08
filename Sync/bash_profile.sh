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
gpush               git push origin master
gpull               git pull origin master

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

alias gpush='git push origin master'
alias gpull='git pull origin master && chmod -R +x /User/Documents/FireCloud/event/ && chmod -R +x /User/Documents/FireCloud/cron/'

# reload bash
alias rlb='. /User/Documents/FireCloud/Sync/bash_profile.sh'

. /User/Documents/FireCloud/Sync/inc/ssh.sh
. /User/Documents/FireCloud/Sync/inc/lctl.sh

# play sound
{ sleep .1 && play /User/Documents/FireCloud/Sync/audio/ssh-connected.aiff& disown; } 2>/dev/null

# change dir aliasses
alias cld='cd /Library/LaunchDaemons'
alias cfc='cd /User/Documents/FireCloud'
alias capp='cd /var/mobile/Containers/Bundle/Application'

echo -e "\033[1;33m iOS version:     \033[0m" `sw_vers -productVersion`
echo -e "\033[1;33m System time:     \033[0m" `date`
echo -e "\033[1;33m User:            \033[0m" `/usr/bin/who`

