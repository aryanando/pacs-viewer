# Hasta Radiologi PACS Viewer - PowerShell Startup Script
# PowerShell version for better compatibility

Write-Host ""
Write-Host "Hasta Radiologi PACS Viewer - PowerShell Startup" -ForegroundColor Cyan
Write-Host "=================================================="
Write-Host ""

# Check Node.js
Write-Host "[1/5] Checking Node.js..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version
    Write-Host "OK: Node.js found - $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Node.js not found! Please install Node.js first." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Check Yarn
Write-Host "[2/5] Checking Yarn..." -ForegroundColor Yellow
try {
    $yarnVersion = yarn --version
    Write-Host "OK: Yarn found - $yarnVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Yarn not found! Please install Yarn first." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Check configuration file
Write-Host "[3/5] Checking configuration file..." -ForegroundColor Yellow
$configPath = "platform\app\public\config\hasta_radiologi.js"
if (Test-Path $configPath) {
    Write-Host "OK: Configuration file found" -ForegroundColor Green
} else {
    Write-Host "ERROR: hasta_radiologi.js config not found!" -ForegroundColor Red
    Write-Host "Expected location: $configPath" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Check Orthanc server
Write-Host "[4/5] Checking Orthanc server..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8042/system" -UseBasicParsing -TimeoutSec 5
    Write-Host "OK: Orthanc server is running" -ForegroundColor Green
} catch {
    Write-Host "WARNING: Cannot connect to Orthanc server at http://localhost:8042" -ForegroundColor Yellow
    Write-Host "Please start your Orthanc PACS server first." -ForegroundColor Yellow
    Write-Host ""
    $continue = Read-Host "Continue anyway? [y/N]"
    if ($continue -ne "y" -and $continue -ne "Y") {
        exit 1
    }
}

# Start the viewer
Write-Host "[5/5] Starting OHIF Viewer..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Setting environment variables..." -ForegroundColor Cyan
$env:NODE_ENV = "development"
$env:APP_CONFIG = "config/hasta_radiologi.js"

Write-Host "NODE_ENV = $env:NODE_ENV" -ForegroundColor Gray
Write-Host "APP_CONFIG = $env:APP_CONFIG" -ForegroundColor Gray
Write-Host ""

Write-Host "Starting development server..." -ForegroundColor Cyan
Write-Host "URL: http://localhost:3000" -ForegroundColor Green
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Start yarn dev
try {
    yarn dev
} catch {
    Write-Host ""
    Write-Host "ERROR: Failed to start the viewer!" -ForegroundColor Red
    Write-Host "Check the error messages above for details." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "Development server stopped." -ForegroundColor Yellow
Read-Host "Press Enter to exit"
