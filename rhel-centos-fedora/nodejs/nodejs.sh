#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo yum update -y

echo "🛠 Installing Development Tools..."
run_silent sudo dnf groupinstall -y "Development Tools"

echo "🚀 Installing Node.js..."
run_silent sudo yum install -y nodejs

# Verify installation
echo "✅ Node.js installation completed!"
node --version || { echo "❌ Node.js installation failed!"; exit 1; }