# PowerShell Build and Deploy Script for Java Monorepo to Kubernetes

Write-Host "=== Building and Deploying Java Monorepo to Kubernetes ===" -ForegroundColor Green

# Exit on any error
$ErrorActionPreference = "Stop"

try {
    Write-Host "`nBuilding Docker image..." -ForegroundColor Yellow
    docker build -t java-monorepo-app:latest .
    Write-Host "✅ Docker image built successfully" -ForegroundColor Green

    Write-Host "`nApplying Kubernetes manifests..." -ForegroundColor Yellow
    kubectl apply -f k8s/namespace.yaml
    kubectl apply -f k8s/deployment.yaml -n java-monorepo
    kubectl apply -f k8s/service.yaml -n java-monorepo
    Write-Host "✅ Kubernetes manifests applied" -ForegroundColor Green

    Write-Host "`nWaiting for deployment to be ready..." -ForegroundColor Yellow
    kubectl wait --for=condition=available --timeout=300s deployment/java-monorepo-app -n java-monorepo
    Write-Host "✅ Deployment is ready!" -ForegroundColor Green

    Write-Host "`n🎉 Deployment completed successfully!" -ForegroundColor Green
    Write-Host "`nUseful commands:" -ForegroundColor Cyan
    Write-Host "  Check pods:     kubectl get pods -n java-monorepo" -ForegroundColor White
    Write-Host "  Check services: kubectl get services -n java-monorepo" -ForegroundColor White
    Write-Host "  View logs:      kubectl logs -f deployment/java-monorepo-app -n java-monorepo" -ForegroundColor White
    Write-Host "  Port forward:   kubectl port-forward service/java-monorepo-service 8080:80 -n java-monorepo" -ForegroundColor White
    Write-Host "  Clean up:       kubectl delete namespace java-monorepo" -ForegroundColor White
}
catch {
    Write-Host "`n❌ Deployment failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Please check the error above and ensure all dependencies are installed." -ForegroundColor Red
    Write-Host "Run .\setup-check.ps1 to verify your setup." -ForegroundColor Red
    exit 1
} 