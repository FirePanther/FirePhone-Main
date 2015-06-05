#!/bin/bash
cd /User/Documents/FireCloud/Cydia

# cydia packages
cat /var/lib/dpkg/status | grep Package: | awk -F: '{print $2}' | sort > Packages.txt

# cydia sources
cat /etc/apt/sources.list.d/cydia.list > Sources.txt

# git
git add .
git commit -m "auto backup cydia data"