#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "📦 Updating package list..."
run_silent sudo apt update

echo "🔑 Adding ngrok GPG key..."
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null

echo "🗂️ Adding ngrok repository..."
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list >/dev/null

echo "🔄 Updating package list..."
run_silent sudo apt update

echo "🚀 Installing ngrok..."
run_silent sudo apt install -y ngrok

echo "✅ ngrok installation completed!"
echo "🔍 Verifying installation..."
ngrok --version