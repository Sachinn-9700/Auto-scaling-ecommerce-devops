#!/bin/bash
set -e

NAMESPACE="monitoring"

kubectl get ns ${NAMESPACE} || kubectl create ns ${NAMESPACE}

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack --namespace ${NAMESPACE} --wait

kubectl get svc -n ${NAMESPACE} | grep grafana
kubectl get svc -n ${NAMESPACE} | grep prometheus
