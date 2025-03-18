#!/bin/bash

set -e  # Exit on error

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

# Detect system architecture
ARCH=$(uname -m)
case "$ARCH" in
    x86_64)   AWS_CLI_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" ;;
    aarch64)  AWS_CLI_URL="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" ;;
    *) echo "❌ Unsupported architecture: $ARCH"; exit 1 ;;
esac

echo "📦 Updating package list..."
run_silent sudo dnf update -y

echo "🛠️ Installing required dependencies (unzip)..."
run_silent sudo dnf install -y unzip

echo "📥 Downloading AWS CLI v2 for ${ARCH}..."
run_silent curl -sSL -o awscliv2.zip "$AWS_CLI_URL"

echo "📂 Extracting AWS CLI..."
run_silent unzip -q awscliv2.zip

echo "🚀 Installing AWS CLI..."
run_silent sudo ./aws/install

echo "🗑️ Cleaning up..."
run_silent rm -rf aws awscliv2.zip

echo "✅ AWS CLI installation completed!"
echo "🔍 Verifying AWS CLI version..."
aws --version