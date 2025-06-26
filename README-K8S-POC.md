# Kubernetes POC for Java Monorepo

This is a simple Proof of Concept (POC) for deploying the Java monorepo application to Kubernetes.

## Overview

The POC includes:
- **Dockerfile**: Multi-stage build for the Java application
- **Kubernetes Manifests**: Basic deployment, service, and namespace configurations
- **Deployment Script**: Automated build and deployment process

## Prerequisites

- Docker installed and running
- Kubernetes cluster (minikube, kind, or cloud provider)
- kubectl configured to connect to your cluster

## Quick Start

1. **Make the deployment script executable:**
   ```bash
   chmod +x build-and-deploy.sh
   ```

2. **Build and deploy:**
   ```bash
   ./build-and-deploy.sh
   ```

## Manual Deployment Steps

If you prefer to run commands manually:

1. **Build the Docker image:**
   ```bash
   docker build -t java-monorepo-app:latest .
   ```

2. **Deploy to Kubernetes:**
   ```bash
   kubectl apply -f k8s/namespace.yaml
   kubectl apply -f k8s/deployment.yaml -n java-monorepo
   kubectl apply -f k8s/service.yaml -n java-monorepo
   ```

3. **Check deployment status:**
   ```bash
   kubectl get pods -n java-monorepo
   kubectl get services -n java-monorepo
   ```

4. **View application logs:**
   ```bash
   kubectl logs -f deployment/java-monorepo-app -n java-monorepo
   ```

## Architecture

- **Replicas**: 2 pods for basic high availability
- **Resources**: Conservative CPU/memory limits suitable for development
- **Health Checks**: Basic process-based liveness and readiness probes
- **Service**: ClusterIP service for internal cluster communication

## Configuration Details

### Deployment (`k8s/deployment.yaml`)
- 2 replicas for redundancy
- Resource limits: 512Mi memory, 500m CPU
- Health probes to ensure application stability

### Service (`k8s/service.yaml`)
- Exposes the application on port 80
- Routes traffic to container port 8080
- ClusterIP type for internal access

### Namespace (`k8s/namespace.yaml`)
- Isolated namespace: `java-monorepo`
- Labeled for development environment

## Monitoring and Troubleshooting

### Common Commands

```bash
# Check pod status
kubectl get pods -n java-monorepo

# View pod details
kubectl describe pod <pod-name> -n java-monorepo

# Check logs
kubectl logs <pod-name> -n java-monorepo

# Port forward for local testing
kubectl port-forward service/java-monorepo-service 8080:80 -n java-monorepo
```

### Scaling

```bash
# Scale up/down replicas
kubectl scale deployment java-monorepo-app --replicas=3 -n java-monorepo
```

## Cleanup

To remove all resources:

```bash
kubectl delete namespace java-monorepo
```

## Next Steps for Production

For a production-ready deployment, consider:
- Ingress controller for external access
- Persistent volumes for data storage
- ConfigMaps and Secrets for configuration
- Resource quotas and limits
- Monitoring and logging solutions
- CI/CD pipeline integration
- Security policies and RBAC

## Notes

- This POC uses `imagePullPolicy: IfNotPresent` for local development
- For production, use a proper image registry and versioning strategy
- Health checks are basic; implement proper HTTP endpoints for better monitoring 