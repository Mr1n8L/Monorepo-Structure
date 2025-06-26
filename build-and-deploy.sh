#!/bin/bash

# Build and Deploy Script for Java Monorepo to Kubernetes

set -e

echo "Building Docker image..."
docker build -t java-monorepo-app:latest .

echo "Applying Kubernetes manifests..."
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml -n java-monorepo
kubectl apply -f k8s/service.yaml -n java-monorepo

echo "Waiting for deployment to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/java-monorepo-app -n java-monorepo

echo "Deployment completed successfully!"
echo "To check the status:"
echo "  kubectl get pods -n java-monorepo"
echo "  kubectl get services -n java-monorepo"
echo "  kubectl logs -f deployment/java-monorepo-app -n java-monorepo" 