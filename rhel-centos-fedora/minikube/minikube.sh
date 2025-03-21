#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "📥 Downloading Minikube..."
run_silent curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64

echo "🚀 Installing Minikube..."
run_silent sudo install minikube-linux-amd64 /usr/local/bin/minikube

echo "🗑️ Cleaning up installation files..."
rm -f minikube-linux-amd64

# Verify installation
echo "✅ Minikube installation completed!"
minikube version || { echo "❌ Minikube installation failed!"; exit 1; }