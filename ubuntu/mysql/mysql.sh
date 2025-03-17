#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "📦 Updating package list..."
run_silent sudo apt-get update

echo "🚀 Installing MySQL Server..."
run_silent sudo apt-get install -y mysql-server

echo "🔄 Starting MySQL service..."
run_silent sudo systemctl start mysql

echo "📌 Enabling MySQL to start on boot..."
run_silent sudo systemctl enable mysql

echo "✅ MySQL installation completed!"
echo "🔍 Verifying MySQL version..."
mysql --version

echo "📊 Checking MySQL service status..."
sudo systemctl status mysql --no-pager