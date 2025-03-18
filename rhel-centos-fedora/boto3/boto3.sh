#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo dnf update -y

echo "🐍 Installing Python 3..."
run_silent sudo dnf install -y python3

# Verify Python installation
python3 --version || { echo "❌ Python installation failed!"; exit 1; }

echo "📦 Installing pip for Python 3..."
run_silent sudo dnf install -y python3-pip

echo "📦 Installing Boto3 (AWS SDK for Python)..."
run_silent pip3 install --user boto3

# Verify Boto3 installation
echo "🔍 Checking Boto3 version..."
python3 -c "import boto3; print('✅ Boto3 installed:', boto3.__version__)" || { echo "❌ Boto3 installation failed!"; exit 1; }

echo "✅ Installation complete!"