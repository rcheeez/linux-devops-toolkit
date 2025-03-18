#!/bin/bash

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "📥 Downloading Helm installation script..."
run_silent curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

echo "🔑 Making script executable..."
chmod 700 get_helm.sh

echo "🚀 Installing Helm..."
run_silent ./get_helm.sh

echo "✅ Helm installation completed!"
echo "🔍 Verifying Helm version..."
helm version