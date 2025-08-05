@echo off
setlocal enabledelayedexpansion

REM Hasta Radiologi PACS Viewer - Final Working Version
REM Reliable startup script based on successful testing

echo.
echo Hasta Radiologi PACS Viewer - Final Startup
echo ============================================

REM Check Node.js
echo Checking Node.js...
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js not found! Install from https://nodejs.org
    pause
    exit /b 1
)
echo OK: Node.js available

REM Check Yarn
echo Checking Yarn...
yarn --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Yarn not found! Run: npm install -g yarn
    pause
    exit /b 1
)
echo OK: Yarn available

REM Check config file
echo Checking configuration...
if not exist "platform\app\public\config\hasta_radiologi.js" (
    echo ERROR: hasta_radiologi.js config not found!
    echo Expected: platform\app\public\config\hasta_radiologi.js
    pause
    exit /b 1
)
echo OK: Configuration file found

REM Check dependencies
echo Checking dependencies...
if not exist "node_modules" (
    echo Installing dependencies... This may take a few minutes.
    yarn install
    if errorlevel 1 (
        echo ERROR: Failed to install dependencies
        pause
        exit /b 1
    )
)
echo OK: Dependencies ready

REM Optional Orthanc check
echo Checking Orthanc server...
powershell -Command "try { Invoke-WebRequest -Uri 'http://localhost:8042/system' -UseBasicParsing -TimeoutSec 3 | Out-Null; Write-Host 'OK: Orthanc server running' } catch { Write-Host 'WARNING: Orthanc not responding - start it first' }" 2>nul

echo.
echo Starting OHIF Viewer with Hasta Radiologi configuration...
echo.
echo - Configuration: hasta_radiologi.js
echo - URL: http://localhost:3000
echo - Network: http://172.16.2.200:3000
echo - Press Ctrl+C to stop
echo.

REM Set environment variables
set NODE_ENV=development
set APP_CONFIG=config/hasta_radiologi.js

REM Start the viewer
yarn dev

echo.
echo Viewer stopped.
pause
setlocal enabledelayedexpansion

REM Hasta Radiologi PACS Viewer - Simple Startup
REM Working version for Command Prompt

echo.
echo Hasta Radiologi PACS Viewer - Simple Startup
echo ==============================================

REM Check basic requirements
echo [1/4] Checking Node.js...
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js not found! Please install Node.js first.
    echo Download from: https://nodejs.org
    pause
    exit /b 1
)
echo OK: Node.js is available

echo [2/4] Checking Yarn...
yarn --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Yarn not found! Please install Yarn first.
    echo Run: npm install -g yarn
    pause
    exit /b 1
)
echo OK: Yarn is available

echo [3/4] Checking configuration...
if not exist "platform\app\public\config\hasta_radiologi.js" (
    echo ERROR: hasta_radiologi.js config not found!
    echo Expected: platform\app\public\config\hasta_radiologi.js
    pause
    exit /b 1
)
echo OK: Configuration file found

echo [4/4] Checking dependencies...
if not exist "node_modules" (
    echo WARNING: node_modules not found. Installing dependencies...
    yarn install
    if errorlevel 1 (
        echo ERROR: Failed to install dependencies
        pause
        exit /b 1
    )
)
echo OK: Dependencies ready

echo.
echo Starting OHIF Viewer with Hasta Radiologi configuration...
echo.
echo Configuration: hasta_radiologi.js
echo Server will start at: http://localhost:3000
echo.
echo NOTE: Make sure Orthanc PACS server is running at http://localhost:8042
echo Press Ctrl+C to stop the viewer
echo.

REM Set environment variables
set NODE_ENV=development
set APP_CONFIG=config/hasta_radiologi.js

REM Start the development server
yarn dev

echo.
echo Viewer stopped.
pause
