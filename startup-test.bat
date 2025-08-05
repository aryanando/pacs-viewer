@echo off
setlocal

REM Hasta Radiologi PACS Viewer - Test Version
echo.
echo Hasta Radiologi PACS Viewer - Test Startup
echo ===========================================

REM Basic checks
echo [1/5] Checking Node.js...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Node.js not found
    pause
    exit /b 1
)
echo OK: Node.js available

echo [2/5] Checking Yarn...
yarn --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Yarn not found
    pause
    exit /b 1
)
echo OK: Yarn available

echo [3/5] Checking config file...
if not exist "platform\app\public\config\hasta_radiologi.js" (
    echo ERROR: Config file not found
    pause
    exit /b 1
)
echo OK: Configuration file exists

echo [4/5] Checking Orthanc server...
timeout /t 1 /nobreak >nul
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:8042/system' -UseBasicParsing -TimeoutSec 3; Write-Output 'OK' } catch { Write-Output 'FAILED' }" >temp_result.txt 2>&1
set /p orthanc_status=<temp_result.txt
del temp_result.txt >nul 2>&1

if "%orthanc_status%"=="OK" (
    echo OK: Orthanc server is running
) else (
    echo WARNING: Cannot connect to Orthanc at http://localhost:8042
    echo Make sure to start your Orthanc server first
    echo.
    set /p continue_choice="Continue anyway? [y/N]: "
    if /i not "%continue_choice%"=="y" exit /b 1
)

echo [5/5] Starting viewer...
echo.
echo Setting environment variables...
set NODE_ENV=development
set APP_CONFIG=config/hasta_radiologi.js

echo NODE_ENV = %NODE_ENV%
echo APP_CONFIG = %APP_CONFIG%
echo.
echo Starting development server...
echo URL: http://localhost:3000
echo Press Ctrl+C to stop
echo.

yarn dev

echo.
echo Development server stopped.
pause
