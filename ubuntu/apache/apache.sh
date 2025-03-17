#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "📦 Updating package list..."
run_silent sudo apt update

echo "🚀 Installing Apache2..."
run_silent sudo apt install -y apache2

echo "✅ Apache2 installation completed!"
echo "🔍 Verifying installation..."
apache2 -v
echo "🔍 Verifying Apache2 service status..."
sudo systemctl status apache2 --no-pager