#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo dnf update -y

echo "🚀 Installing Redis..."
run_silent sudo dnf install -y redis

echo "▶️ Starting Redis service..."
run_silent sudo systemctl start redis

echo "🔄 Enabling Redis to start on boot..."
run_silent sudo systemctl enable redis

# Verify Redis service status
echo "✅ Verifying Redis service status..."
sudo systemctl status redis --no-pager

# Verify Redis is working
echo "🔍 Testing Redis connection..."
redis-cli ping || { echo "❌ Redis installation failed!"; exit 1; }

echo "🎉 Redis installation and configuration completed successfully!"