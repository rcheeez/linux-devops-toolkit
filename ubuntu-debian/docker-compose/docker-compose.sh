#!/bin/bash

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

# Function to execute commands with progress messages
run_cmd() {
    echo "🔹 $1..."
    shift
    run_silent "$@"
}

run_cmd "Updating package list" sudo apt update
run_cmd "Installing Docker Compose v2" sudo apt install -y docker-compose-v2

echo "✅ Docker Compose v2 installation completed!"
echo 'alias docker-compose="docker compose"' >> ~/.bashrc
source ~/.bashrc

echo "Setting up the docker-compose command from 'docker compose to 'docker-compose'"

echo "🔍 Verifying Docker Compose version..."
docker-compose version
