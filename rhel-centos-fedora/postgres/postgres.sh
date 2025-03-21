#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "🔄 Updating package lists..."
run_silent sudo dnf update -y

echo "📦 Adding PostgreSQL 17 repository..."
run_silent sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm

echo "🚫 Disabling default PostgreSQL module..."
run_silent sudo dnf -qy module disable postgresql

echo "🚀 Installing PostgreSQL 17 server..."
run_silent sudo dnf install -y postgresql17-server

echo "🛠 Initializing PostgreSQL database..."
run_silent sudo /usr/pgsql-17/bin/postgresql-17-setup initdb

echo "▶️ Enabling PostgreSQL service..."
run_silent sudo systemctl enable postgresql-17

echo "▶️ Starting PostgreSQL service..."
run_silent sudo systemctl start postgresql-17

# Verify PostgreSQL service status
echo "✅ Verifying PostgreSQL service status..."
sudo systemctl status postgresql-17 --no-pager

echo "🎉 PostgreSQL 17 is now fully installed!"