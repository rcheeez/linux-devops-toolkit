#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "🔄 Updating package lists..."
run_silent sudo apt update

echo "📦 Adding JFrog Artifactory APT repository..."
echo "deb https://releases.jfrog.io/artifactory/artifactory-debs xenial main" | sudo tee /etc/apt/sources.list.d/artifactory.list > /dev/null

echo "🔑 Importing JFrog repository GPG key..."
run_silent curl -fsSL https://releases.jfrog.io/artifactory/api/gpg/key/public | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/artifactory.gpg

echo "🔄 Updating package lists again..."
run_silent sudo apt update

echo "🚀 Installing JFrog Artifactory OSS..."
run_silent sudo apt install -y jfrog-artifactory-oss

echo "⚙️ Enabling Artifactory service..."
run_silent sudo systemctl enable artifactory.service

echo "▶️ Starting Artifactory service..."
run_silent sudo systemctl start artifactory.service

echo "✅ JFrog Artifactory installation completed!"

# Verifying service status
echo ""
echo "🔍 Checking JFrog Artifactory status..."
sudo systemctl status artifactory.service --no-pager