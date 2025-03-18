#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "🔄 Downloading kubectl for Amazon EKS..."
run_silent curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.32.0/2024-12-20/bin/linux/amd64/kubectl

echo "🔑 Making kubectl executable..."
run_silent chmod +x ./kubectl

echo "📂 Creating a bin directory in home if not exists..."
run_silent mkdir -p $HOME/bin

echo "📦 Moving kubectl to \$HOME/bin..."
run_silent cp ./kubectl $HOME/bin/kubectl

echo "🛠️ Adding kubectl to PATH..."
export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc

echo "✅ kubectl installation completed successfully!"
echo "🔍 Verifying kubectl version..."
kubectl version --client || { echo "❌ kubectl installation failed!"; exit 1; }