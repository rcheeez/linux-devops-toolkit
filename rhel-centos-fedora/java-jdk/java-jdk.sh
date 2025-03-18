#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo dnf update -y

echo "☕ Installing Java 17 (OpenJDK Development Kit)..."
run_silent sudo dnf install -y java-17-openjdk-devel

# Verify Java installation
echo "🔍 Checking Java version..."
if command -v java >/dev/null 2>&1 && command -v javac >/dev/null 2>&1; then
    echo "✅ Java and Javac installed successfully!"
    java -version
    javac -version
else
    echo "❌ Java installation failed!"
    exit 1
fi