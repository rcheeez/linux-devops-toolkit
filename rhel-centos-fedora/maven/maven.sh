#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo dnf update -y

echo "🚀 Installing Apache Maven..."
run_silent sudo dnf install -y maven

# Verify installation
echo "✅ Maven installation completed!"
mvn -version || { echo "❌ Maven installation failed!"; exit 1; }