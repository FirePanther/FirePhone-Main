#!/bin/bash

# dependency: activator

# this script automatically unlocks the iPhone and launcheds
# AlfredRemote after the iPhone is connected to my iMac or Macbook.

. /firephone/event/unlock.sh
open com.runningwithcrayons.AlfredRemote
