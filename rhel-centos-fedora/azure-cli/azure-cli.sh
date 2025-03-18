#!/bin/bash

set -e  # Exit on error

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "📦 Importing Microsoft GPG key..."
run_silent sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

echo "🔄 Adding Microsoft package repository..."
run_silent sudo dnf install -y https://packages.microsoft.com/config/rhel/9.0/packages-microsoft-prod.rpm

echo "📝 Configuring Azure CLI repository..."
echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo >/dev/null

echo "🚀 Installing Azure CLI..."
run_silent sudo dnf install -y azure-cli

echo "🔄 Upgrading Azure CLI to the latest version..."
run_silent az upgrade --yes

echo "✅ Azure CLI installation and upgrade completed!"
echo "🔍 Verifying Azure CLI version..."
az version