#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "📥 Adding Google Cloud SDK repository..."
sudo tee /etc/yum.repos.d/google-cloud-sdk.repo >/dev/null <<EOM
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el9-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM

echo "🔄 Updating package lists..."
run_silent sudo dnf update -y

echo "🛠️ Installing required dependencies..."
run_silent sudo dnf install -y libxcrypt-compat.x86_64

echo "🚀 Installing Google Cloud CLI..."
run_silent sudo dnf install -y google-cloud-cli

# Verify gcloud installation
echo "🔍 Checking gcloud version..."
if command -v gcloud >/dev/null 2>&1; then
    echo "✅ Google Cloud CLI installed successfully!"
    gcloud --version
else
    echo "❌ gcloud installation failed!"
    exit 1
fi