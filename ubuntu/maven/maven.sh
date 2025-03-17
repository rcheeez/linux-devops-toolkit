#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "📦 Updating package lists..."
run_silent sudo apt update

echo "🚀 Installing Apache Maven..."
run_silent sudo apt install -y maven

echo "✅ Maven installation completed!"
echo "🔍 Verifying Maven version..."
mvn -version