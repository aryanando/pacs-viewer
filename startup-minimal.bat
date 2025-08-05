@echo off

REM Hasta Radiologi PACS Viewer - Super Simple Version
REM Minimal script that just works

echo.
echo Hasta Radiologi PACS Viewer
echo ===========================
echo.

REM Basic check
if not exist "platform\app\public\config\hasta_radiologi.js" (
    echo ERROR: hasta_radiologi.js not found!
    pause
    exit /b 1
)

echo Starting OHIF Viewer with Hasta Radiologi config...
echo URL: http://localhost:3000
echo.

REM Set environment
set NODE_ENV=development
set APP_CONFIG=config/hasta_radiologi.js

REM Start
yarn dev

echo.
echo Stopped.
pause
