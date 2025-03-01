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