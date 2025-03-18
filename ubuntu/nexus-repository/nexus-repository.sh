#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "🔍 Checking if Docker is installed..."
if ! command -v docker &>/dev/null; then
    echo "🐳 Docker not found! Installing Docker..."
    run_silent sudo apt update
    run_silent sudo apt install -y docker.io
    run_silent sudo usermod -aG docker $USER && newgrp docker || echo "⚠️ Please log out and log back in for group changes to take effect."
    echo "✅ Docker installed successfully. Please log out and log back in for group changes to take effect."
else
    echo "✅ Docker is already installed!"
fi

# Run Nexus Repository Manager
echo "🚀 Starting Nexus Repository Manager..."
run_silent docker run -d -p 8081:8081 sonatype/nexus3

echo "✅ Nexus Repository Manager 3 is running at http://<public-ip-address>:8081"
echo "🔒 Default credentials: admin/admin123"
echo "📝 Please change the default password after logging in!"