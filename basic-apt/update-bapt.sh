#!/bin/bash

# Function for logging
log_info() {
  local log_message="$1"
  echo
  echo "[INFO] ${log_message}"
  echo
}

# Function for updating package list
update_package_list() {
  log_info "Updating package list"
  if ! sudo apt update; then
    log_info "Failed to update package list"
    exit 1
  fi
}

# Function for upgrading installed packages
upgrade_packages() {
  log_info "Upgrading installed packages"
  if ! sudo apt upgrade -y; then
    log_info "Failed to upgrade installed packages"
    exit 1
  fi
}

# Execution
update_package_list
upgrade_packages
log_info "Script execution finished successfully"
