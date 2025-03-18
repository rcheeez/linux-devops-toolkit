#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "🔄 Updating package lists..."
run_silent sudo apt update

echo "📦 Installing Java 17 (Headless)..."
run_silent sudo apt install -y openjdk-17-jdk-headless

echo "🔑 Adding Jenkins repository key..."
run_silent sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "➕ Adding Jenkins repository..."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

echo "🔄 Updating package lists again..."
run_silent sudo apt-get update

echo "🚀 Installing Jenkins..."
run_silent sudo apt-get install -y jenkins

echo "⚙️ Enabling Jenkins service..."
sudo systemctl enable jenkins

echo "▶️ Starting Jenkins service..."
sudo systemctl start jenkins

echo "✅ Jenkins installation completed!"

# Verifying Jenkins service status
echo ""
echo "🔍 Checking Jenkins status..."
sudo systemctl status jenkins --no-pager