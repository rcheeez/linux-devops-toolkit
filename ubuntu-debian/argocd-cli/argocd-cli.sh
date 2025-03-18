#!/bin/bash

# Exit immediately if a command fails
set -e

run_silent() {
    "$@" >/dev/null 2>&1
}
    
echo "🔄 Updating package lists..."
run_silent sudo apt-get update -y

echo "📦 Installing required dependencies..."
run_silent sudo apt-get install -y curl

# Define ArgoCD version and architecture
ARGOCD_VERSION="v2.4.7"
ARCH="amd64"

echo "⬇️ Downloading ArgoCD CLI (Version: $ARGOCD_VERSION, Arch: $ARCH)..."
run_silent sudo curl -sSL -o /usr/local/bin/argocd \
  "https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-${ARCH}"

echo "🔑 Setting executable permissions..."
sudo chmod +x /usr/local/bin/argocd

# Verify installation
echo "✅ ArgoCD CLI installed successfully!"
argocd version --client || echo "⚠️ ArgoCD CLI installed, but unable to retrieve version."