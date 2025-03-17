#!/bin/bash

# Exit immediately if a command fails
set -e

run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo apt-get update -y 

echo "📦 Installing required dependencies..."
run_silent sudo apt-get install -y apt-transport-https ca-certificates gnupg curl 

echo "🔑 Adding Google Cloud public signing key..."
run_silent curl -sSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
  sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg 

echo "➕ Adding Google Cloud SDK repository..."
run_silent echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
  sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list 

echo "🔄 Updating package lists again..."
run_silent sudo apt-get update -y 

echo "🚀 Installing Google Cloud CLI..."
run_silent sudo apt-get install -y google-cloud-cli 

# Verify installation
echo "✅ Google Cloud CLI installed successfully!"
gcloud --version