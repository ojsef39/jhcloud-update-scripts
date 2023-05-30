#!/bin/sh

# Update package repositories
pkg update

# Upgrade installed packages
pkg upgrade -y

# Check for pfSense updates
pfsense_version=$(cat /etc/version)
latest_version=$(fetch -qo - https://updates.pfsense.org/_updaters/amd64/version)
echo "Current pfSense version: $pfsense_version"
echo "Latest pfSense version: $latest_version"

if [ "$latest_version" != "$pfsense_version" ]; then
    echo "A pfSense update is available. Performing update..."
    pkg upgrade -r pfSense -y
    echo "pfSense update completed."
else
    echo "No pfSense update available."
fi
