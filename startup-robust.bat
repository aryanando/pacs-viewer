@echo off
setlocal enabledelayedexpansion

REM Hasta Radiologi PACS Viewer - Robust Final Version
REM Fixed version that avoids hanging issues

echo.
echo Hasta Radiologi PACS Viewer - Robust Startup
echo =============================================

REM Quick checks without hanging
echo [1/4] Node.js:
node --version 2>nul || (echo ERROR: Node.js not found & pause & exit /b 1)

echo [2/4] Yarn:
yarn --version 2>nul || (echo ERROR: Yarn not found & pause & exit /b 1)

echo [3/4] Config:
if exist "platform\app\public\config\hasta_radiologi.js" (echo OK) else (echo ERROR: Config not found & pause & exit /b 1)

echo [4/4] Dependencies:
if exist "node_modules" (echo OK) else (echo Installing... & yarn install)

echo.
echo Checking Orthanc server...
powershell -Command "try { Invoke-WebRequest -Uri 'http://localhost:8042/system' -UseBasicParsing -TimeoutSec 3 | Out-Null; Write-Host 'OK: Orthanc running' } catch { Write-Host 'WARNING: Orthanc not responding' }" 2>nul

echo.
echo Starting OHIF Viewer...
echo URL: http://localhost:3000
echo Config: hasta_radiologi.js
echo.

REM Set environment and start
set NODE_ENV=development
set APP_CONFIG=config/hasta_radiologi.js

echo Starting development server...
yarn dev

pause
