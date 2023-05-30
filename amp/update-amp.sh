#!/bin/bash

# Get the current date and time
now=$(date +"%m_%d_%Y")

# Define the output file name
logfile="/var/log/update_script_$now.log"

# Perform the update/upgrade and output the result to the logfile
echo "Starting system update..." | tee -a $logfile
apt-get update -y | tee -a $logfile
apt-get upgrade -y | tee -a $logfile

# Update AMP
sudo -u amp ampinstmgr upgradeall | tee -a $logfile

echo "System update completed successfully!" | tee -a $logfile
