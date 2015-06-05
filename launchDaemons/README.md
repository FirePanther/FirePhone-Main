# location
/Library/LaunchDaemons/

# list
launchctl list | grep -i "pro.firepanther"

# load
launchctl load /Library/LaunchDaemons/pro.firepanther.xxxxx.plist

# unload
launchctl unload /Library/LaunchDaemons/pro.firepanther.xxxxx.plist