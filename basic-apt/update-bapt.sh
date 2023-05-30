#!/bin/bash

print_info() {
  echo "[INFO] $1"
  echo
}

print_info "GETTING UPDATES"

sudo apt update
echo

print_info "YEAH UPGRADE"

sudo apt upgrade -y
echo

print_info "FINISHED UPDATING!"
