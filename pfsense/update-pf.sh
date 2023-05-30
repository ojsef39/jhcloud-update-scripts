#!/bin/sh

# Update package repositories
echo
echo -e "[INFO] GETTING UPDATES \n"
pkg update

# Upgrade installed packages
echo
echo -e "[INFO] YEAH UPGRADE \n"
pkg upgrade -y

# Check for pfSense updates
pfsense_version=$(cat /etc/version)
latest_version=$(fetch -qo - https://updates.pfsense.org/_updaters/amd64/version)
echo
echo "Current pfSense version: $pfsense_version"
echo "Latest pfSense version: $latest_version"

if [ "$latest_version" != "$pfsense_version" ]; then
    echo
    echo "A pfSense update is available. Performing update..."
    pkg upgrade -r pfSense -y
    echo
    echo -e "[INFO] FINISHED UPDATING! \n"
    echo "pfSense update completed."
else
    echo
    echo -e "[INFO] FINISHED UPDATING! \n"
    echo "No pfSense update available."
fi
