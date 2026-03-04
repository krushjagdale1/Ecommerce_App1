#!/bin/bash

set -e

echo "===== Initialize Cluster ====="
kubeadm init --pod-network-cidr=192.168.0.0/16

echo "===== Configure kubectl ====="
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

echo "===== Install Calico Network Plugin ====="
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.3/manifests/calico.yaml

echo "===== Cluster Initialized Successfully ====="
echo "Run this command on worker nodes:"
kubeadm token create --print-join-command
