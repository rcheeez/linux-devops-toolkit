#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "🔍 Detecting system architecture..."
ARCH=$(uname -m)

# Download KIND based on system architecture
if [[ "$ARCH" == "x86_64" ]]; then
    echo "📥 Downloading KIND for AMD64 / x86_64..."
    run_silent curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-amd64
elif [[ "$ARCH" == "aarch64" ]]; then
    echo "📥 Downloading KIND for ARM64..."
    run_silent curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-arm64
else
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
fi

echo "🔧 Setting executable permissions..."
run_silent chmod +x ./kind

echo "🚀 Moving KIND binary to /usr/local/bin..."
run_silent sudo mv ./kind /usr/local/bin/kind

# Verify installation
echo "🔍 Checking KIND installation..."
if kind --version >/dev/null 2>&1; then
    echo "✅ KIND installation completed successfully!"
    kind --version
else
    echo "❌ KIND installation failed!"
    exit 1
fi