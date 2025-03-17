#!/bin/bash

# Exit on error
set -e

run_silent() {
    "$@" >/dev/null 2>&1
}

# Detect system architecture
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then
  ARCH="amd64"
elif [[ "$ARCH" == "aarch64" ]]; then
  ARCH="arm64"
else
  echo "❌ Unsupported architecture: $ARCH"
  exit 1
fi

PLATFORM="$(uname -s)_$ARCH"
EKSCTL_URL="https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
CHECKSUM_URL="https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt"

echo "🔹 Installing eksctl on Ubuntu ($PLATFORM)..."

# Download eksctl binary
echo "📥 Downloading eksctl from: $EKSCTL_URL"
curl -sLO "$EKSCTL_URL" >/dev/null 2>&1

# (Optional) Verify checksum
echo "🔍 Verifying checksum..."
run_silent curl -sL "$CHECKSUM_URL" | grep "$PLATFORM" | sha256sum --check || { echo "❌ Checksum verification failed!"; exit 1; }

# Extract and install
echo "📦 Extracting eksctl..."
run_silent tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

echo "🚀 Moving eksctl to /usr/local/bin/"
sudo mv /tmp/eksctl /usr/local/bin/

# Verify installation
echo "✅ eksctl installed successfully!"
eksctl version