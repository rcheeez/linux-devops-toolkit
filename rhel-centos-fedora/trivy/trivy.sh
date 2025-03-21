#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo yum update -y

echo "📦 Adding Trivy repository..."
sudo tee /etc/yum.repos.d/trivy.repo > /dev/null <<EOL
[trivy]
name=Trivy repository
baseurl=https://aquasecurity.github.io/trivy-repo/rpm/releases/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOL

echo "🚀 Installing Trivy..."
run_silent sudo yum install -y trivy

# Verify installation
echo "✅ Trivy installation completed!"
trivy --version || { echo "❌ Trivy installation failed!"; exit 1; }