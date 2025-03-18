#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "📦 Updating package list..."
run_silent sudo apt-get update

echo "🚀 Installing dependencies..."
run_silent sudo apt-get install -y gnupg software-properties-common

echo "🔑 Adding HashiCorp GPG key..."
run_silent wget -qO- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null

echo "🗂️ Verifying key fingerprint..."
run_silent gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

echo "📥 Adding HashiCorp repository..."
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null

echo "🔄 Updating package list..."
run_silent sudo apt update

echo "🌍 Installing Terraform..."
run_silent sudo apt-get install -y terraform

echo "✅ Terraform installation completed!"
echo "🔍 Verifying Terraform version..."
terraform -version