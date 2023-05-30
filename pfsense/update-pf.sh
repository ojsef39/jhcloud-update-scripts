#!/bin/sh

print_info() {
  echo "[INFO] $1"
  echo
}

print_info "GETTING UPDATES"

pkg update
echo

print_info "YEAH UPGRADE"

pkg upgrade -y
echo

print_info "CHECKING FOR PFSENSE UPDATES"

pfsense_version=$(cat /etc/version)
latest_version=$(fetch -qo - https://updates.pfsense.org/_updaters/amd64/version)
echo
print_info "Current pfSense version: $pfsense_version, Latest pfSense version: $latest_version"

if [ "$latest_version" != "$pfsense_version" ]; then
  print_info "A pfSense update is available. Performing update..."
  pkg upgrade -r pfSense -y
  echo
  print_info "FINISHED UPDATING! pfSense update completed"
else
  print_info "FINISHED UPDATING! No pfSense update available"
fi
