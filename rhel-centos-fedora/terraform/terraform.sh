#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo yum update -y

echo "📦 Installing YUM utilities..."
run_silent sudo yum install -y yum-utils

echo "📥 Adding HashiCorp repository..."
run_silent sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

echo "🚀 Installing Terraform..."
run_silent sudo yum install -y terraform

# Verify installation
echo "✅ Terraform installation completed!"
terraform --version || { echo "❌ Terraform installation failed!"; exit 1; }