#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "📌 Adding MongoDB 8.0 repository..."
echo "[mongodb-org-8.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/8.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://pgp.mongodb.com/server-8.0.asc" | sudo tee /etc/yum.repos.d/mongodb-org-8.0.repo > /dev/null

echo "🔄 Updating package lists..."
run_silent sudo yum update -y

echo "🚀 Installing MongoDB 8.0..."
run_silent sudo yum install -y mongodb-org

echo "▶️ Starting MongoDB service..."
run_silent sudo systemctl start mongod

echo "🔄 Reloading system daemon..."
run_silent sudo systemctl daemon-reload

# Verify service status
echo "✅ Verifying MongoDB service status..."
sudo systemctl status mongod --no-pager

echo "🎉 MongoDB 8.0 installation completed successfully!"