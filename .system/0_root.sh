#!/bin/bash

# Check if the user has sudo/root permissions
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo or as root to install missing packages."
    exit 1
fi
cd .system

chmod +x ./1_setup_omp.zsh
./1_setup_omp.sh

chmod +x ./2_bin.zsh
./2_bin.zsh

chmod +x ./3_install_zsh.zsh
./3_install_zsh.sh

# source the .zshenv from ZDOTDIR
# securely renames existing .zshenv
# [[ -f ~/.zshenv ]] && mv -f ~/.zshenv ~/.zshenv.bak
echo ". $ZDOTDIR/.zshenv" > ~/.zshenv

# start a new zsh session
zsh