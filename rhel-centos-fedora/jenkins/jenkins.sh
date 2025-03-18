#!/bin/bash

# Exit immediately if a command fails
set -e  

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

# Function to check if Java is installed
check_java() {
    if command -v java >/dev/null 2>&1 && command -v javac >/dev/null 2>&1; then
        echo "☕ Java is already installed."
    else
        echo "☕ Java not found. Installing Java 17 (JDK)..."
        run_silent sudo dnf install -y java-17-openjdk-devel
    fi
}

# Step 1: Update system packages
echo "🔄 Updating system packages..."
run_silent sudo dnf upgrade -y

# Step 2: Install wget (required for downloading the Jenkins repo)
echo "🌍 Installing wget..."
run_silent sudo dnf install -y wget

# Step 3: Check and install Java
check_java

# Step 4: Add Jenkins repository
echo "📥 Adding Jenkins repository..."
run_silent sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
run_silent sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Step 5: Install Jenkins
echo "⚙️ Installing Jenkins..."
run_silent sudo dnf install -y jenkins

# Step 6: Reload system daemon
echo "🔄 Reloading system daemon..."
run_silent sudo systemctl daemon-reload

# Step 7: Enable and start Jenkins service
echo "🚀 Enabling and starting Jenkins service..."
run_silent sudo systemctl enable --now jenkins

# Step 8: Show Jenkins status
echo "🔍 Checking Jenkins status..."
sudo systemctl status jenkins --no-pager

echo "✅ Jenkins installation completed successfully!"