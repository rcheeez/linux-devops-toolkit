#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo yum update -y

echo "📥 Installing required dependencies..."
run_silent sudo yum install -y wget

echo "📌 Downloading MySQL 8.0 repository package..."
run_silent sudo wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm

echo "📦 Installing MySQL repository..."
run_silent sudo rpm -Uvh mysql80-community-release-el7-3.noarch.rpm

echo "🚀 Installing MySQL Server..."
run_silent sudo yum install -y mysql-server

echo "▶️ Starting MySQL service..."
run_silent sudo systemctl start mysqld

echo "🔄 Enabling MySQL to start on boot..."
run_silent sudo systemctl enable mysqld

# Verify MySQL service status
echo "✅ Verifying MySQL service status..."
sudo systemctl status mysqld --no-pager

# Retrieve the temporary root password
MYSQL_TEMP_PASS=$(sudo grep 'password' /var/log/mysqld.log | awk '{print $NF}')
echo "🔑 Temporary MySQL root password: $MYSQL_TEMP_PASS"

# Secure MySQL installation
echo "🔒 Running MySQL secure installation..."
echo "⚠️ Please follow the on-screen instructions to set a new root password."
sudo mysql_secure_installation

# Restart MySQL service after configuration
echo "🔄 Restarting MySQL service..."
run_silent sudo systemctl restart mysqld

# Test MySQL root login
echo "🛠 Testing MySQL login..."
mysql -u root -p

echo "✅ MySQL 8.0 installation and configuration completed successfully!"