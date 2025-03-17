#!/bin/bash

# Exit immediately if a command fails
set -e

run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent  sudo apt update -y

echo "📦 Installing required dependencies..."
run_silent sudo apt install -y software-properties-common

echo "➕ Adding Ansible PPA repository..."
run_silent sudo apt-add-repository --yes --update ppa:ansible/ansible

echo "🚀 Installing Ansible..."
run_silent sudo apt install -y ansible

# Verify installation
echo "✅ Ansible installed successfully!"
ansible --version