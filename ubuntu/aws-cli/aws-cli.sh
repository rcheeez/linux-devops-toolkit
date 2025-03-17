#!/bin/bash

# Exit immediately if a command fails
set -e

run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo apt update -y

echo "📦 Installing required dependencies..."
run_silent sudo apt install -y curl unzip

echo "⬇️ Downloading AWS CLI v2..."
run_silent curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

echo "📂 Unzipping AWS CLI package..."
run_silent unzip -q awscliv2.zip

echo "🚀 Installing AWS CLI..."
run_silent sudo ./aws/install

# Verify installation
echo "✅ AWS CLI installed successfully!"
aws --version

# Cleanup
echo "🧹 Cleaning up installation files..."
run_silent rm -rf aws awscliv2.zip