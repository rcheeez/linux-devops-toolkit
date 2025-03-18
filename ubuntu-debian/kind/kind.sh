#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

# Detect system architecture
ARCH=$(uname -m)
KIND_VERSION="v0.26.0"

# Set download URL based on architecture
if [[ "$ARCH" == "x86_64" ]]; then
    KIND_URL="https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-amd64"
elif [[ "$ARCH" == "aarch64" ]]; then
    KIND_URL="https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-arm64"
else
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
fi

echo "📥 Downloading Kind for $ARCH..."
run_silent curl -Lo ./kind "$KIND_URL"

echo "🔧 Setting executable permissions..."
run_silent chmod +x ./kind

echo "🚀 Moving Kind to /usr/local/bin..."
run_silent sudo mv ./kind /usr/local/bin/kind

echo "✅ Kind installation completed!"
echo "🔍 Verifying Kind version..."
kind version