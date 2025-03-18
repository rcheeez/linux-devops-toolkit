#!/bin/bash

set -e  # Exit on any error

# Function to run commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "📦 Installing EPEL repository..."
run_silent sudo dnf install -y epel-release

echo "🚀 Installing Apache (httpd)..."
run_silent sudo dnf install -y httpd

echo "🔄 Starting Apache service..."
run_silent sudo systemctl start httpd

echo "📌 Enabling Apache to start on boot..."
run_silent sudo systemctl enable httpd

echo "🔍 Updating Apache..."
run_silent sudo dnf update -y httpd

echo "✅ Apache installation and setup completed!"
echo "🔍 Checking Apache status..."
sudo systemctl status httpd --no-pager