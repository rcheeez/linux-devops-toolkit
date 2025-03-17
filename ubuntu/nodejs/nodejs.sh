#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "📦 Updating package list..."
run_silent sudo apt update

echo "🚀 Installing Node.js..."
run_silent sudo apt install -y nodejs

echo "✅ Node.js installation completed!"
echo "🔍 Verifying installation..."
node -v