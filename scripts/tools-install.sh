#!/bin/bash
set -euxo pipefail

# kubectl install
curl -fsSL "https://dl.k8s.io/release/$(curl -fsSL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  -o /usr/local/bin/kubectl

chmod +x /usr/local/bin/kubectl

kubectl version --client
