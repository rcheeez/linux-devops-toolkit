#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "📦 Updating package list..."
run_silent sudo apt update

echo "🚀 Installing Nginx..."
run_silent sudo apt install -y nginx

echo "✅ Nginx installation completed!"
echo "🔍 Verifying installation..."
nginx -v