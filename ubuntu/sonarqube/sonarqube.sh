#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "🔍 Checking if Docker is installed..."
if command_exists docker; then
    echo "✅ Docker is already installed!"
else
    echo "🚀 Installing Docker..."
    run_silent sudo apt update
    run_silent sudo apt install -y docker.io
    run_silent sudo usermod -aG docker "$USER"
    echo "🔄 Please log out and log back in for Docker group changes to take effect."
fi

echo "🚀 Running SonarQube container..."
run_silent docker run -d -p 9000:9000 --name sonarqube sonarqube:lts-community

echo "✅ SonarQube is running at http://localhost:9000"
echo "🔒 Default credentials: admin/admin"
echo "📝 Please change the default password after logging in!"