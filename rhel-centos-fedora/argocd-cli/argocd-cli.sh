#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Detect system architecture
ARCH=$(uname -m)
case "$ARCH" in
    x86_64)   ARCH_LABEL="amd64" ;;
    aarch64)  ARCH_LABEL="arm64" ;;
    *) echo "❌ Unsupported architecture: $ARCH"; exit 1 ;;
esac

ARGOCD_URL="https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-${ARCH_LABEL}"
ARGOCD_BIN="/usr/local/bin/argocd"

echo "📥 Downloading ArgoCD CLI for ${ARCH_LABEL}..."
curl -sSL -o argocd "$ARGOCD_URL"

echo "🚀 Installing ArgoCD CLI..."
sudo install -m 555 argocd "$ARGOCD_BIN"

echo "🗑️ Cleaning up..."
rm -f argocd

echo "✅ ArgoCD CLI installation completed!"
echo "🔍 Verifying installation..."
argocd version --client