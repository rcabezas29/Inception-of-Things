#!/bin/bash

# Update and setup VM
apt-get update
apt-get install -y curl

# Install K3s
curl -sfL https://get.k3s.io | K3S_TOKEN=password K3S_KUBECONFIG_MODE="644" sh -s - --node-ip "192.168.56.110"

# Configure k command
echo 'alias k="sudo k3s kubectl"' >> /root/.bashrc
echo 'alias k="sudo k3s kubectl"' >> /home/vagrant/.bashrc

# Deploy kubernetes infrastructure
kubectl apply -f /vagrant/manifests/app-one.yaml
kubectl apply -f /vagrant/manifests/app-two.yaml
kubectl apply -f /vagrant/manifests/app-three.yaml
kubectl apply -f /vagrant/manifests/ingress.yaml