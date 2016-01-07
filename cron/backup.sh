#!/bin/bash

# dependency: git, awk (gawk)

cd /firephone/cydia

# cydia packages
cat /var/lib/dpkg/status | grep Package: | awk -F: '{print $2}' | sort > packages

# cydia sources
cat /etc/apt/sources.list.d/cydia.list > sources

# git
git add .
git commit -m "auto backup cydia data"
