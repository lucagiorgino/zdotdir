#!/bin/bash

# Check if the user has sudo/root permissions
if [ "$EUID" -ne 0 ]; then
    echo "❌ Please run this script with sudo or as root to install missing packages."
    exit 1
fi

echo "🌀 Starting system setup and package installation..."

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
            echo "🚀 Successfully installed $pkg."
        else
            echo "❌ Failed to install $pkg."
        fi
    fi
done

if ! command -v cc >/dev/null 2>&1
then
    echo "🌀 Installing build-essential..."
    sudo apt update && sudo apt install -y build-essential
    echo "🚀 build-essential installed."
else
    echo "✅ build-essential is already installed."
fi

if ! command -v pkg-config >/dev/null 2>&1 || ! pkg-config --exists openssl; then
    echo "🌀 Installing pkg-config and libssl-dev (missing OpenSSL dependencies)..."
    sudo apt update && sudo apt install -y pkg-config libssl-dev
    echo "🚀 pkg-config and OpenSSL dependencies installed."
else
    echo "✅ pkg-config and OpenSSL dependencies are already installed."
fi

echo "✅ All checks complete!"