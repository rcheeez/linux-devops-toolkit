#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

# Detect system architecture
ARCH=$(uname -m)
[[ "$ARCH" == "x86_64" ]] && ARCH="amd64"
[[ "$ARCH" == "aarch64" ]] && ARCH="arm64"

# Validate supported architectures
if [[ "$ARCH" != "amd64" && "$ARCH" != "arm64" ]]; then
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
fi

# Define Minikube download URL
MINIKUBE_URL="https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-$ARCH"

echo "📥 Downloading Minikube for $ARCH..."
run_silent curl -LO "$MINIKUBE_URL"

echo "🚀 Installing Minikube..."
run_silent sudo install "minikube-linux-$ARCH" /usr/local/bin/minikube

echo "🧹 Cleaning up..."
rm -f "minikube-linux-$ARCH"

echo "✅ Minikube installation completed!"
echo "🔍 Verifying Minikube version..."
minikube version