#!/bin/bash

# Array of packages to check/install
# Note: 'realpath' and 'dirname' are part of the 'coreutils' package on Debian/Ubuntu.
PACKAGES=("curl" "unzip" "coreutils")

echo "Checking system dependencies..."

# Check if the user has sudo/root permissions
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo or as root to install missing packages."
    exit 1
fi

# Update package lists first
echo "Updating package lists..."
apt-get update -y > /dev/null 2>&1

# Loop through each package and install if missing
for pkg in "${PACKAGES[@]}"; do
    if dpkg -s "$pkg" > /dev/null 2>&1; then
        echo "✅ $pkg is already installed."
    else
        echo "⏳ $pkg is missing. Installing..."
        apt-get install -y "$pkg"
        
        if [ $? -eq 0 ]; then
            echo "✨ Successfully installed $pkg."
        else
            echo "❌ Failed to install $pkg."
        fi
    fi
done

echo "All checks complete!"

echo "Installing Oh My Posh..."

curl -s https://ohmyposh.dev/install.sh | zsh -s

echo "Oh My Posh installation complete!"