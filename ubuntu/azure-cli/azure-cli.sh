#!/bin/bash

# Exit immediately if a command fails
set -e

run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo apt-get update -y

echo "📦 Installing required dependencies..."
run_silent sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

echo "📂 Creating keyrings directory..."
sudo mkdir -p /etc/apt/keyrings

echo "🔑 Adding Microsoft GPG key..."
run_silent curl -sLS https://packages.microsoft.com/keys/microsoft.asc | \
  gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null

sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

# Detect distribution codename
AZ_DIST=$(lsb_release -cs)

echo "📝 Adding Azure CLI repository..."
echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources > /dev/null

echo "🔄 Updating package lists again..."
run_silent sudo apt-get update -y

echo "🚀 Installing Azure CLI..."
run_silent sudo apt-get install -y azure-cli

# Verify installation
echo "✅ Azure CLI installed successfully!"
az version