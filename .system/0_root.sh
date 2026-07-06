#!/bin/bash

# Check if the user has sudo/root permissions
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo or as root to install missing packages."
    exit 1
fi

# Dynamically find the original user's real home directory using the system passwd database
ZUSERHOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)

# Fallback just in case the script is running without sudo
if [ -z "$ZUSERHOME" ]; then
    ZUSERHOME="$HOME"
fi

echo "🌀 Starting system setup and package installation..."

chmod +x "$ZDOTDIR/.system/1_setup_omp.sh"
"$ZDOTDIR/.system/1_setup_omp.sh"

chmod +x "$ZDOTDIR/.system/2_bin.sh"
"$ZDOTDIR/.system/2_bin.zsh"

chmod +x "$ZDOTDIR/.system/3_install_zsh.sh"
"$ZDOTDIR/.system/3_install_zsh.sh"