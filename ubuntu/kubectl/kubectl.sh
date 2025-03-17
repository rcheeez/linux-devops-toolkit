#!/bin/bash

# Detect system architecture and set the appropriate kubectl URL
ARCH=$(uname -m)
case "$ARCH" in
    x86_64)   KUBECTL_ARCH="amd64" ;;
    aarch64)  KUBECTL_ARCH="arm64" ;;
    *) echo "❌ Unsupported architecture: $ARCH"; exit 1 ;;
esac

KUBECTL_URL="https://s3.us-west-2.amazonaws.com/amazon-eks/1.32.0/2024-12-20/bin/linux/$KUBECTL_ARCH/kubectl"
INSTALL_DIR="/usr/local/bin"

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

# Function to execute commands with progress messages
run_cmd() {
    echo "🔹 $1..."
    shift
    run_silent "$@"
}

run_cmd "Downloading kubectl for $ARCH" curl -sSLO "$KUBECTL_URL"
run_cmd "Making kubectl executable" chmod +x kubectl
run_cmd "Moving kubectl to $INSTALL_DIR" sudo mv kubectl "$INSTALL_DIR/"

echo "✅ kubectl installation completed!"
echo "🔍 Verifying kubectl version..."
kubectl version --client