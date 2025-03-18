#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "📦 Updating package list..."
run_silent sudo apt-get update

echo "🔑 Installing required dependencies..."
run_silent sudo apt-get install -y gnupg curl lsb-release

echo "📥 Adding MongoDB GPG key..."
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-8.0.gpg

echo "🗂️ Adding MongoDB repository..."
echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list >/dev/null

echo "🔄 Updating package list..."
run_silent sudo apt-get update

echo "🚀 Installing MongoDB 8.0..."
run_silent sudo apt-get install -y mongodb-org

echo "🔄 Starting MongoDB service..."
sudo systemctl start mongod

echo "📌 Enabling MongoDB to start on boot..."
sudo systemctl enable mongod

echo "✅ MongoDB installation and setup completed!"
echo "🔍 Verifying MongoDB version..."
mongod --version

echo "📊 Checking MongoDB service status..."
sudo systemctl status mongod --no-pager