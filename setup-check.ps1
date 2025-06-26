# Kubernetes POC Setup Checker for Windows
# Run this script to verify all dependencies are installed

Write-Host "=== Kubernetes POC Dependency Checker ===" -ForegroundColor Green

# Check Docker
Write-Host "`nChecking Docker..." -ForegroundColor Yellow
try {
    $dockerVersion = docker --version
    Write-Host "✅ Docker found: $dockerVersion" -ForegroundColor Green
    
    # Check if Docker is running
    try {
        docker ps | Out-Null
        Write-Host "✅ Docker is running" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Docker is installed but not running. Please start Docker Desktop." -ForegroundColor Red
    }
}
catch {
    Write-Host "❌ Docker not found. Please install Docker Desktop:" -ForegroundColor Red
    Write-Host "   https://docs.docker.com/desktop/install/windows-install/" -ForegroundColor Red
}

# Check kubectl
Write-Host "`nChecking kubectl..." -ForegroundColor Yellow
try {
    $kubectlVersion = kubectl version --client --short 2>$null
    Write-Host "✅ kubectl found: $kubectlVersion" -ForegroundColor Green
}
catch {
    Write-Host "❌ kubectl not found. Install using:" -ForegroundColor Red
    Write-Host "   choco install kubernetes-cli" -ForegroundColor Red
    Write-Host "   OR download from: https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/" -ForegroundColor Red
}

# Check Kubernetes cluster
Write-Host "`nChecking Kubernetes cluster..." -ForegroundColor Yellow
try {
    $clusterInfo = kubectl cluster-info 2>$null
    if ($clusterInfo) {
        Write-Host "✅ Kubernetes cluster is accessible" -ForegroundColor Green
        kubectl get nodes --no-headers 2>$null | ForEach-Object {
            Write-Host "   Node: $_" -ForegroundColor Green
        }
    }
}
catch {
    Write-Host "❌ No Kubernetes cluster found. Options:" -ForegroundColor Red
    Write-Host "   1. Enable Kubernetes in Docker Desktop (Settings → Kubernetes)" -ForegroundColor Red
    Write-Host "   2. Install minikube: choco install minikube && minikube start" -ForegroundColor Red
}

# Check Git
Write-Host "`nChecking Git..." -ForegroundColor Yellow
try {
    $gitVersion = git --version
    Write-Host "✅ Git found: $gitVersion" -ForegroundColor Green
}
catch {
    Write-Host "❌ Git not found. Install using:" -ForegroundColor Red
    Write-Host "   winget install Git.Git" -ForegroundColor Red
}

# Check Java (optional)
Write-Host "`nChecking Java (optional for local development)..." -ForegroundColor Yellow
try {
    $javaVersion = java -version 2>&1 | Select-String "version"
    Write-Host "✅ Java found: $javaVersion" -ForegroundColor Green
}
catch {
    Write-Host "⚠️  Java not found (optional). Install using:" -ForegroundColor Orange
    Write-Host "   winget install Microsoft.OpenJDK.21" -ForegroundColor Orange
}

Write-Host "`n=== Summary ===" -ForegroundColor Green
Write-Host "If all checks passed, you can run the POC with:" -ForegroundColor Cyan
Write-Host "   .\build-and-deploy.sh" -ForegroundColor Cyan
Write-Host "`nIf using PowerShell, you might need to run:" -ForegroundColor Cyan
Write-Host "   bash .\build-and-deploy.sh" -ForegroundColor Cyan 