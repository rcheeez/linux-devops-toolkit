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

echo "🚀 Installing Nginx..."
run_silent sudo yum install -y nginx

echo "▶️ Starting Nginx service..."
run_silent sudo systemctl start nginx

echo "🔄 Enabling Nginx to start on boot..."
run_silent sudo systemctl enable nginx

# Verify installation
echo "✅ Nginx installation completed!"
nginx -v || { echo "❌ Nginx installation failed!"; exit 1; }

# Verify service status
echo "🔍 Checking Nginx service status..."
sudo systemctl status nginx --no-pager