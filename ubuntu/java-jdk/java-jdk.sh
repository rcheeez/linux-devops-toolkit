#!/bin/bash

# Exit immediately if a command fails
set -e

run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo apt update -y

echo "📦 Installing required dependencies..."
run_silent sudo apt install openjdk-17-jre-headless -y  

# Verify installation
echo "✅ Java JDK installed successfully!"
java --version