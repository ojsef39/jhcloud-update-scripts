#!/bin/bash

# Get the current date and time
now=$(date +"%m_%d_%Y")

# Define the output file name
logfile="/var/log/update_script_$now.log"

# Check for available disk space, require at least 1GB
available_space=$(df / | tail -1 | awk '{print $4}')
required_space=1048576

if (( available_space < required_space )); then
  echo "Not enough disk space. At least 1GB is required." | tee -a $logfile
  exit 1
fi

# Perform the update/upgrade and output the result to the logfile
echo "Starting system update..." | tee -a $logfile

if ! apt-get update -y | tee -a $logfile; then
  echo "System update failed!" | tee -a $logfile
  exit 1
fi

if ! apt-get upgrade -y | tee -a $logfile; then
  echo "System upgrade failed!" | tee -a $logfile
  exit 1
fi

# Perform cleanup
if ! apt-get autoremove -y | tee -a $logfile; then
  echo "System cleanup failed!" | tee -a $logfile
  exit 1
fi

echo "System update completed successfully!" | tee -a $logfile
