#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "📦 Updating package list..."
run_silent sudo apt update

echo "🚀 Installing PostgreSQL..."
run_silent sudo apt install -y postgresql

echo "✅ PostgreSQL installation completed!"

echo "🔄 Starting PostgreSQL service..."
sudo systemctl start postgresql
sudo systemctl enable postgresql

echo "🔍 Checking PostgreSQL service status..."
sudo systemctl status postgresql --no-pager