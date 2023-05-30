#!/bin/sh

# Function for logging
log_info() {
  log_message="$1"
  echo
  echo "[INFO] ${log_message}"
  echo
}

# Function for updating package repository
update_package_repo() {
  log_info "Updating package repository"
  if ! pkg update; then
    log_info "Failed to update package repository"
    exit 1
  fi
}

# Function for upgrading installed packages
upgrade_packages() {
  log_info "Upgrading installed packages"
  if ! pkg upgrade -y; then
    log_info "Failed to upgrade installed packages"
    exit 1
  fi
}

# Function for checking and updating pfSense
check_update_pfsense() {
  log_info "Checking for pfSense updates"

  pfsense_version
  latest_version

  if ! pfsense_version=$(cat /etc/version); then
    log_info "Failed to read pfSense version"
    exit 1
  fi

  if ! latest_version=$(fetch -qo - https://updates.pfsense.org/_updaters/amd64/version); then
    log_info "Failed to fetch latest pfSense version"
    exit 1
  fi

  log_info "Current pfSense version: ${pfsense_version}, Latest pfSense version: ${latest_version}"

  if [ "${latest_version}" != "${pfsense_version}" ]; then
    log_info "A pfSense update is available. Performing update..."
    if ! pkg upgrade -r pfSense -y; then
      log_info "Failed to update pfSense"
      exit 1
    fi
    log_info "pfSense update completed successfully"
  else
    log_info "No pfSense update available"
  fi
}

# Execution
update_package_repo
upgrade_packages
check_update_pfsense
log_info "Script execution finished successfully"
