#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "📦 Updating package list..."
run_silent sudo apt-get update

echo "🚀 Installing required dependencies..."
run_silent sudo apt-get install -y wget apt-transport-https gnupg lsb-release

echo "🔑 Adding Trivy GPG key..."
wget -qO- https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg >/dev/null

echo "🗂️ Adding Trivy repository..."
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/trivy.list >/dev/null

echo "🔄 Updating package list..."
run_silent sudo apt-get update

echo "🌍 Installing Trivy..."
run_silent sudo apt-get install -y trivy

echo "✅ Trivy installation completed!"
echo "🔍 Verifying Trivy version..."
trivy --version