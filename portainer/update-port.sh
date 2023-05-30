#!/bin/bash

# Get the current date and time
now=$(date +"%m_%d_%Y")

# Define the output file name
logfile="/var/log/update_script_$now.log"

# Perform the update/upgrade and output the result to the logfile
echo "Starting system update..." | tee -a $logfile
apt-get update -y | tee -a $logfile
apt-get upgrade -y | tee -a $logfile

# Update Portainer
echo "Updating portainer..." | tee -a $logfile
# Stop and remove the Portainer container
docker stop portainer | tee -a $logfile
docker rm portainer | tee -a $logfile

# Pull the latest version of the Portainer image
docker pull portainer/portainer-ce | tee -a $logfile

# Start a new Portainer container using the updated image
sleep 10
docker run -d -p 443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /evergreen:/data portainer/portainer-ce:latest --http-disabled | tee -a $logfile

echo "System update completed successfully!" | tee -a $logfile
