#!/bin/bash

# Exit immediately if a command fails
set -e
# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

# Check if Docker is installed
if ! command -v docker &>/dev/null; then
    echo "🐳 Docker not found! Installing Docker..."
    run_silent sudo apt update
    run_silent sudo apt install -y docker.io
    sudo usermod -aG docker "$USER" && newgrp docker || echo "⚠️ Please log out and log back in for group changes to take effect."
    echo "✅ Docker installed successfully!" 
fi

# Set Splunk password (change this securely)
SPLUNK_PASSWORD="password"

echo "🚀 Pulling and running Splunk container..."
run_silent docker run -d --name splunk \
    -p 8000:8000 \
    -e SPLUNK_START_ARGS='--accept-license' \
    -e SPLUNK_PASSWORD="$SPLUNK_PASSWORD" \
    splunk/splunk:latest

echo "✅ Splunk is running at http://localhost:8000"
echo "🔑 Login using Username: admin | Password: $SPLUNK_PASSWORD"
echo "📝 Please change the default password after logging in!"