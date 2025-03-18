#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔍 Detecting system architecture..."
ARCH=$(uname -m)
case "$ARCH" in
    x86_64)   ARCH="amd64" ;;
    aarch64)  ARCH="arm64" ;;
    armv7l)   ARCH="armv7" ;;
    armv6l)   ARCH="armv6" ;;
    *) echo "❌ Unsupported architecture: $ARCH"; exit 1 ;;
esac

PLATFORM="$(uname -s)_$ARCH"

echo "📥 Downloading eksctl for $PLATFORM..."
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

echo "✅ Verifying checksum..."
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep "$PLATFORM" | sha256sum --check || { echo "❌ Checksum verification failed!"; exit 1; }

echo "📂 Extracting eksctl..."
tar -xzf "eksctl_$PLATFORM.tar.gz" -C /tmp && rm "eksctl_$PLATFORM.tar.gz"

echo "🚀 Moving eksctl to /usr/local/bin..."
sudo mv /tmp/eksctl /usr/local/bin

# Verify eksctl installation
echo "🔍 Verifying eksctl version..."
eksctl version || { echo "❌ eksctl installation failed!"; exit 1; }

echo "✅ eksctl installation completed successfully!"