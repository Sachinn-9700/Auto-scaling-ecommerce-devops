#!/bin/bash
set -euxo pipefail

AWS_REGION="us-east-1"
CLUSTER_NAME="auto-scaling-ecommerce-eks"

# Jenkins kube directory
mkdir -p /var/lib/jenkins/.kube

aws eks update-kubeconfig \
  --region "$AWS_REGION" \
  --name "$CLUSTER_NAME" \
  --kubeconfig /var/lib/jenkins/.kube/config

chown -R jenkins:jenkins /var/lib/jenkins/.kube
chmod 600 /var/lib/jenkins/.kube/config

# Validate access (do not fail pipeline if cluster not ready yet)
sudo -u jenkins kubectl get nodes || true
