#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "📦 Updating package list..."
run_silent sudo apt-get update

echo "🚀 Installing required dependencies..."
run_silent sudo apt-get install -y lsb-release curl gpg

echo "🔑 Adding Redis GPG key..."
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
sudo chmod 644 /usr/share/keyrings/redis-archive-keyring.gpg

echo "🗂️ Adding Redis repository..."
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list >/dev/null

echo "🔄 Updating package list..."
run_silent sudo apt-get update

echo "💾 Installing Redis..."
run_silent sudo apt-get install -y redis

echo "🔄 Enabling and starting Redis service..."
run_silent sudo systemctl enable redis-server
run_silent sudo systemctl start redis-server

echo "✅ Redis installation completed!"
echo "🔍 Verifying Redis version..."
redis-server --version

echo "🔍 Checking Redis service status..."
sudo systemctl status redis-server --no-pager