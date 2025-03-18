#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "📦 Updating package list..."
sudo dnf makecache --refresh -y >/dev/null 2>&1 || { echo "❌ Failed to update package list."; exit 1; }

echo "🚀 Installing Ansible Core..."
if sudo dnf install -y ansible-core >/dev/null 2>&1; then
    echo "✅ Ansible Core installed successfully!"
else
    echo "❌ Ansible Core installation failed. Exiting..."
    exit 1
fi

echo "🔍 Verifying Ansible installation..."
if ansible --version >/dev/null 2>&1; then
    echo "✅ Ansible version: $(ansible --version | head -n 1)"
else
    echo "❌ Ansible verification failed."
    exit 1
fi