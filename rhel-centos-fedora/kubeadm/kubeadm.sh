#!/bin/bash

# Function to run commands silently
run_silent() { 
    "$@" >/dev/null 2>&1 
}

echo "🔄 Disabling SELinux temporarily..."
run_silent sudo setenforce 0

echo "⚙️ Setting SELinux to permissive mode permanently..."
run_silent sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

echo "📦 Adding Kubernetes repository..."
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo >/dev/null
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.31/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.31/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF

echo "🚀 Installing Kubernetes components (kubelet, kubeadm, kubectl)..."
run_silent sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

echo "🔄 Enabling and starting kubelet service..."
run_silent sudo systemctl enable --now kubelet

echo "✅ Kubernetes setup completed successfully!"