#!/bin/bash
echo "Hi Am! Installing Nvidia drivers now..." &&
echo "Please run this script as root (like sudo /path/to/script), mmkay?"
  if [ $(id -u) -eq 0 ]; then
    return 0
  else
    echo "Error: This script must be run as root."
    exit 1
  fi
dnf install akmod-nvidia -y &&
echo "Nvidia driver install finished" 