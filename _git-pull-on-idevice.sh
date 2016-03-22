#!/bin/bash

# execute on iMac/MacBook, git pulls on iDevice and sets execute permissions
ssh root@firephone "cd /firephone; git pull --rebase origin master && chmod -R +x /firephone/event/ && chmod -R +x /firephone/cron/"
