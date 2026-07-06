#!/bin/bash

# Array of packages to check/install
# Note: 'realpath' and 'dirname' are part of the 'coreutils' package on Debian/Ubuntu.
PACKAGES=("curl" "unzip" "coreutils")

echo "🌀 Checking system dependencies..."

# Update package lists first
echo "🌀 Updating package lists..."
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

echo "✅All checks complete!"

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