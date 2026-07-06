#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🌀 Starting Zsh installation and setup..."

# 1. Install Zsh using apt
if command -v zsh >/dev/null 2>&1; then
    echo "✅ Zsh is already installed."
else
    echo "⏳ Installing Zsh..."
    sudo apt update && apt install -y zsh
fi

# 2. Verify installation
ZSH_VERSION=$(zsh --version)
echo "✅ Verified: $ZSH_VERSION"

# 3. Change default shell to Zsh
CURRENT_SHELL=$(basename "$SHELL")
if [ "$CURRENT_SHELL" = "zsh" ]; then
    echo "✅ Zsh is already your default shell."
else
    echo "⏳ Changing your default shell to Zsh..."
    sudo chsh -s "$(which zsh)" "$USER"
fi

# 4. Launch Zsh for the current session
echo "🚀 Launching Zsh for this session now..."
exec zsh