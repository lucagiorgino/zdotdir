#!/bin/sh

if ! command -v oh-my-posh >/dev/null 2>&1; then
    echo "🌀 Oh My Posh not found. Installing Oh My Posh..."

    # Create local bin directory if it doesn't exist
    mkdir -p "$HOME/.local/bin"
    
    # Download and install the binary natively
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d "$HOME/.local/bin"

    echo "🚀 Oh My Posh installed."
else
    echo "✅ Oh My Posh is already installed."
fi

if ! command -v cargo 2>&1 >/dev/null
then
    echo "🌀 Installing Rust..." && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # Source the new cargo path into the current script session
    . "$HOME/.cargo/env"
    echo "🚀 Rust installed."
else
    echo "✅ Rust is already installed."
fi

if ! command -v mise >/dev/null 2>&1 && command -v cargo >/dev/null 2>&1;
then
    echo "🌀 Installing Mise (with cargo)..." && \
    cargo install --locked mise
    echo "🚀 Mise installed."
else
    echo "✅ Mise is already installed."
fi

if ! command -v batcat 2>&1 >/dev/null || ! command -v bat 2>&1 >/dev/null
then
    echo "🌀 Installing bat..." && \
    sudo apt install bat
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
    echo "🚀 bat installed."
else
    echo "✅ bat is already installed."
fi

if ! command -v docker 2>&1 >/dev/null    
then
    echo "🌀 Installing Docker..."
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

    if ! command -v newgrp 2>&1 >/dev/null    
    then
        echo "❌ newgrp command missing."
    else
        # https://docs.docker.com/engine/install/linux-postinstall/
        # Manage Docker as a non-root user
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker

        echo "✅ Docker usable as non-root user."
    fi
 
    echo "🚀 Docker installation complete!"
else
    echo "✅ Docker is already installed."
fi