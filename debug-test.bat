@echo off

echo Testing individual components...

echo 1. Node version:
node --version

echo 2. Yarn version:
yarn --version

echo 3. Config file check:
if exist "platform\app\public\config\hasta_radiologi.js" (
    echo Config file EXISTS
) else (
    echo Config file NOT FOUND
)

echo 4. Package.json check:
if exist "package.json" (
    echo package.json EXISTS
) else (
    echo package.json NOT FOUND
)

echo 5. Current directory:
cd

echo 6. Directory contents:
dir /b

pause
