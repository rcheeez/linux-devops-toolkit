#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo yum update -y

echo "📦 Installing EPEL repository..."
run_silent sudo yum install -y epel-release

echo "⚙️ Installing Snap package manager..."
run_silent sudo yum install -y snapd

echo "▶️ Enabling and starting Snap service..."
run_silent sudo systemctl enable --now snapd.socket

echo "🔗 Creating symbolic link for Snap..."
run_silent sudo ln -s /var/lib/snapd/snap /snap

echo "🚀 Installing Ngrok..."
run_silent sudo snap install ngrok

# Ensure the system recognizes Ngrok
echo "🔄 Updating system PATH..."
echo 'export PATH=$PATH:/snap/bin' | sudo tee -a /etc/profile > /dev/null
export PATH=$PATH:/snap/bin

# Verify installation
echo "✅ Ngrok installation completed!"
/snap/bin/ngrok --version || { echo "❌ Ngrok installation failed!"; exit 1; }