@echo off
setlocal enabledelayedexpansion

REM Hasta Radiologi PACS Viewer Startup Script (Alternative Method)
REM Starts OHIF viewer with custom Hasta Radiologi configuration from platform/app

set SCRIPT_DIR=%~dp0
set VIEWER_PORT=3000
set CONFIG_FILE=hasta_radiologi.js
set ORTHANC_URL=http://localhost:8042

echo.
echo 🏥 Hasta Radiologi PACS Viewer Startup (Platform/App Method)
echo ==========================================================
echo Viewer Port: %VIEWER_PORT%
echo Config File: %CONFIG_FILE%
echo Orthanc Server: %ORTHANC_URL%
echo.

REM Check if Node.js is available
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Error: Node.js is not installed or not in PATH!
    echo Please install Node.js and try again.
    pause
    exit /b 1
)

echo ✅ Node.js found:
node --version

REM Check if Yarn is available
yarn --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Error: Yarn is not installed or not in PATH!
    echo Please install Yarn and try again.
    pause
    exit /b 1
)

echo ✅ Yarn found:
yarn --version

REM Check if we're in the correct directory structure
if not exist "platform\app\package.json" (
    echo ❌ Error: platform\app\package.json not found!
    echo Please run this script from the OHIF viewer root directory.
    pause
    exit /b 1
)

if not exist "platform\app\public\config\%CONFIG_FILE%" (
    echo ❌ Error: Configuration file not found!
    echo Expected: platform\app\public\config\%CONFIG_FILE%
    pause
    exit /b 1
)

echo ✅ Configuration file found: %CONFIG_FILE%

REM Check if dependencies are installed
if not exist "node_modules" (
    echo 📦 Installing root dependencies...
    yarn install
    if errorlevel 1 (
        echo ❌ Error: Failed to install root dependencies!
        pause
        exit /b 1
    )
)

echo ✅ Root dependencies are ready

REM Check if Orthanc server is running
echo 🔗 Checking Orthanc server connection...
curl -s "%ORTHANC_URL%/system" >nul 2>&1
if not errorlevel 1 (
    echo ✅ Orthanc server is accessible at %ORTHANC_URL%

    REM Get and display system info
    echo 📊 Orthanc System Info:
    curl -s "%ORTHANC_URL%/system" | findstr "Name\|Version"
) else (
    echo ⚠️  Warning: Cannot connect to Orthanc server at %ORTHANC_URL%
    echo Make sure your Orthanc PACS server is running before using the viewer.
    echo You can start it using startup.bat in the orthanc-mwl directory.
    echo.
    echo Do you want to continue anyway? [y/N]
    set /p CONTINUE=
    if /i not "!CONTINUE!"=="y" if /i not "!CONTINUE!"=="yes" (
        echo Startup cancelled.
        pause
        exit /b 1
    )
)

REM Check if port is available
netstat -an | findstr ":%VIEWER_PORT% " | findstr "LISTENING" >nul 2>&1
if not errorlevel 1 (
    echo ❌ Error: Port %VIEWER_PORT% is already in use!
    echo Please stop the service using this port or change VIEWER_PORT in this script.
    pause
    exit /b 1
)

echo ✅ Port %VIEWER_PORT% is available

echo.
echo 🚀 Starting Hasta Radiologi PACS Viewer...
echo.
echo Configuration: %CONFIG_FILE%
echo URL: http://localhost:%VIEWER_PORT%
echo.
echo ⚡ The viewer will start in development mode
echo ⚡ Press Ctrl+C to stop the server
echo ⚡ Access the viewer at: http://localhost:%VIEWER_PORT%
echo.

REM Change to platform/app directory and start with the specific config
cd platform\app

REM Start the development server with custom config using cross-env
yarn cross-env NODE_ENV=development APP_CONFIG=config/%CONFIG_FILE% yarn dev

if errorlevel 1 (
    echo.
    echo ❌ Error: Failed to start the viewer!
    echo Trying alternative method...
    echo.

    REM Try alternative method without cross-env
    set NODE_ENV=development
    set APP_CONFIG=config/%CONFIG_FILE%
    yarn dev

    if errorlevel 1 (
        echo ❌ Error: Both startup methods failed!
        echo Check the error messages above for details.
        pause
        exit /b 1
    )
)

echo.
echo 🎉 Hasta Radiologi PACS Viewer stopped.
pause
