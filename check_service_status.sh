#!/bin/bash

################################################
# This script can be used to check if any service is running or not.
# If found to be not running, then the script would make an attempt to start the service.
################################################

# address of the machine to check
ssh 111.22.33.44

# name of the service to check
service=jenkins

if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
echo "$service is running :)"
else
echo "$service has stopped, starting it :)"
/etc/init.d/$service start
fi
