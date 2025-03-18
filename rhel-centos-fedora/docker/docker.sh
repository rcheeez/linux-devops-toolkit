#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo dnf update -y

echo "🛠️ Installing DNF plugins..."
run_silent sudo dnf -y install dnf-plugins-core

echo "📥 Adding Docker repository..."
run_silent sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

echo "🐳 Installing Docker and required dependencies..."
run_silent sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "🚀 Enabling and starting Docker service..."
run_silent sudo systemctl enable --now docker

# Verify Docker installation
echo "🔍 Checking Docker status..."
if systemctl is-active --quiet docker; then
    echo "✅ Docker is running!"
else
    echo "❌ Docker failed to start!"
    exit 1
fi

echo "🔑 Granting Docker permissions to the current user..."
sudo usermod -aG docker $USER && newgrp docker

echo "🐳 Verifying Docker version..."
docker --version || { echo "❌ Docker installation failed!"; exit 1; }

echo "✅ Docker installation completed successfully!"