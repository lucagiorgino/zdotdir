#!/bin/zsh

if ! command -v cargo 2>&1 >/dev/null
then
    echo "Installing Rust..." && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! command -v mise 2>&1 >/dev/null && command -v cargo 2>&1 >/dev/null
then
    echo "Installing Mise (with cargo)..." && \
    cargo install mise
fi

if ! command -v batcat 2>&1 >/dev/null || ! command -v bat 2>&1 >/dev/null
then
    echo "Installing bat..." && \
    sudo apt install bat
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
fi

if ! command -v docker 2>&1 >/dev/null    
then
    # https://docs.docker.com/engine/install/ubuntu/
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update


    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # https://docs.docker.com/engine/install/linux-postinstall/
    # Manage Docker as a non-root user
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
fi