@echo off
setlocal enabledelayedexpansion

REM Hasta Radiologi PACS Viewer - Simple Startup
REM Direct method using yarn scripts

echo.
echo Hasta Radiologi PACS Viewer - Simple Startup
echo ==============================================

REM Check basic requirements
echo Checking Node.js...
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js not found! Please install Node.js first.
    pause
    exit /b 1
)
echo OK: Node.js found

echo Checking Yarn...
yarn --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Yarn not found! Please install Yarn first.
    pause
    exit /b 1
)
echo OK: Yarn found

REM Check if config file exists
echo Checking configuration file...
if not exist "platform\app\public\config\hasta_radiologi.js" (
    echo ERROR: hasta_radiologi.js config not found!
    echo Expected location: platform\app\public\config\hasta_radiologi.js
    pause
    exit /b 1
)
echo OK: Configuration file found
echo.

REM Check Orthanc connection
echo Checking Orthanc server...
REM Check Orthanc connection
echo Checking Orthanc server...
powershell -Command "try { Invoke-WebRequest -Uri 'http://localhost:8042/system' -UseBasicParsing -TimeoutSec 5 | Out-Null; exit 0 } catch { exit 1 }" >nul 2>&1
if errorlevel 1 (
    echo WARNING: Orthanc server not responding at http://localhost:8042
    echo Please start your Orthanc PACS server first.
    echo.
    set /p CONTINUE="Continue anyway? [y/N]: "
    if /i not "!CONTINUE!"=="y" exit /b 1
) else (
    echo OK: Orthanc server is running
)

echo.
echo Starting OHIF Viewer with Hasta Radiologi config...
echo.
echo Access the viewer at: http://localhost:3000
echo Press Ctrl+C to stop the server
echo.

REM Set environment and start
set NODE_ENV=development
set APP_CONFIG=config/hasta_radiologi.js

echo Environment: NODE_ENV=!NODE_ENV!
echo Config: APP_CONFIG=!APP_CONFIG!
echo.

REM Use the dev script from the main package.json
yarn dev

echo.
echo Viewer stopped.
pause
