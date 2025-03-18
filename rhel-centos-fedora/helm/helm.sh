#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "📥 Downloading Helm install script..."
run_silent curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

echo "🔒 Setting execution permissions..."
chmod 700 get_helm.sh

echo "🚀 Installing Helm..."
run_silent ./get_helm.sh

# Verify Helm installation
echo "🔍 Checking Helm version..."
if command -v helm >/dev/null 2>&1; then
    echo "✅ Helm installed successfully!"
    helm version
else
    echo "❌ Helm installation failed!"
    exit 1
fi

# Cleanup
rm -f get_helm.sh