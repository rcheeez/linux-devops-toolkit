#!/bin/bash

# Function to execute commands silently
run_silent() {
    "$@" >/dev/null 2>&1
}

echo "📦 Updating system packages..."
run_silent sudo apt update && sudo apt upgrade -y

echo "📥 Installing required dependencies..."
run_silent sudo apt install -y apt-transport-https curl containerd

echo "⚙️ Configuring containerd..."
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
run_silent sudo systemctl restart containerd

echo "🔑 Adding Kubernetes repository..."
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list >/dev/null

echo "📦 Installing Kubernetes components..."
run_silent sudo apt update
run_silent sudo apt install -y kubelet kubeadm kubectl
run_silent sudo apt-mark hold kubelet kubeadm kubectl

echo "🛑 Disabling swap..."
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo "🖧 Configuring networking..."
run_silent sudo modprobe overlay
run_silent sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf >/dev/null
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

run_silent sudo sysctl --system

echo "✅ Kudeadm setup completed!"
