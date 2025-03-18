#!/bin/bash

# Exit immediately if a command fails
set -e

run_silent() {
    "$@" >/dev/null 2>&1
}

# Update package lists
echo "🔄 Updating package lists..."
run_silent sudo apt update -y

# Install Docker
echo "🐳 Installing Docker..."
run_silent sudo apt install -y docker.io

# Add the current user to the Docker group (to run Docker without sudo)
echo "👤 Adding $USER to the Docker group..."
sudo usermod -aG docker "$USER"

# Apply the group change
echo "🔄 Refreshing group permissions..."
newgrp docker || echo "⚠️ Please log out and log back in for group changes to take effect."

# Verify installation
echo "✅ Docker installed successfully!"
docker --version