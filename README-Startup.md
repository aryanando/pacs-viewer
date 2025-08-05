# Hasta Radiologi PACS Viewer - Startup Guide

## Overview
This directory contains startup scripts for the OHIF-based Hasta Radiologi PACS Viewer with custom configuration.

## Configuration File
- **Location**: `platform/app/public/config/hasta_radiologi.js`
- **Purpose**: Custom configuration for Hasta Radiologi workflow
- **Features**:
  - Connects to Orthanc server at `localhost:8042`
  - Custom hotkeys for radiology workflow
  - Hasta Radiologi branding
  - Optimized for DICOM viewing

## Startup Scripts

### 1. `startup-simple.bat` ⭐ **RECOMMENDED**
**Best for: Most users**
- Simple, reliable startup
- Minimal dependencies
- Direct yarn dev execution
- Good error handling

```cmd
startup-simple.bat
```

### 2. `startup-viewer.bat`
**Best for: Advanced users**
- Comprehensive checks
- Detailed logging
- Cross-environment support
- Dependency validation

```cmd
startup-viewer.bat
```

### 3. `startup-viewer-alt.bat`
**Best for: Troubleshooting**
- Alternative startup method
- Multiple fallback options
- Platform/app directory focus

```cmd
startup-viewer-alt.bat
```

## Prerequisites

### 1. Node.js & Yarn
```cmd
# Check if installed
node --version    # Should be >= 18
yarn --version    # Should be >= 1.20.0

# Install if missing
# Download Node.js from https://nodejs.org
# Yarn will be installed automatically with Node.js
```

### 2. Dependencies
```cmd
# Install once (done automatically by startup scripts)
yarn install
```

### 3. Orthanc PACS Server
```cmd
# Start Orthanc server first (in orthanc-mwl directory)
cd ../orthanc-mwl
startup.bat
```

## Quick Start Guide

### Step 1: Start Orthanc PACS Server
```cmd
# Navigate to orthanc-mwl directory
cd f:\PROJECT\hasta-pacs\orthanc-mwl

# Start Orthanc server
startup.bat
```

### Step 2: Start PACS Viewer
```cmd
# Navigate to pacs-viewer directory
cd f:\PROJECT\hasta-pacs\pacs-viewer

# Start viewer (recommended method)
startup-simple.bat
```

### Step 3: Access the Viewer
- Open browser to: http://localhost:3000
- The viewer will automatically use the Hasta Radiologi configuration
- Connect to your Orthanc server for DICOM studies

## Configuration Details

### Orthanc Integration
- **Server URL**: `http://localhost:8042`
- **DICOMweb Root**: `/dicom-web`
- **WADO URI Root**: `/dicom-web/wado`
- **Upload Enabled**: Yes

### Custom Hotkeys
- **Arrow Keys**: Navigate viewports and images
- **R/L**: Rotate right/left
- **I**: Invert image
- **H/V**: Flip horizontal/vertical
- **+/-**: Zoom in/out
- **Space**: Reset viewport
- **=**: Fit to window

### UI Customization
- Hospital logo: 🏥
- Title: "Hasta Radiologi PACS"
- Custom error handling for Orthanc
- Optimized for radiology workflow

## Troubleshooting

### Port Already in Use
```cmd
# Check what's using port 3000
netstat -an | findstr ":3000"

# Kill process or change port in startup script
```

### Orthanc Connection Issues
```cmd
# Test Orthanc manually
curl http://localhost:8042/system

# Start Orthanc if not running
cd ../orthanc-mwl && startup.bat
```

### Dependencies Issues
```cmd
# Clean install
yarn clean:deep
yarn install
```

### Build Issues
```cmd
# Try different startup method
startup-viewer-alt.bat

# Or manual start
yarn dev
```

## Manual Commands

### Development Mode
```cmd
# Standard development
yarn dev

# With specific config
set APP_CONFIG=config/hasta_radiologi.js
yarn dev

# Fast development (if available)
yarn dev:fast
```

### Production Build
```cmd
# Build for production
yarn build

# Build with custom config
set APP_CONFIG=config/hasta_radiologi.js
yarn build
```

## Network Access

### Local Access
- Viewer: http://localhost:3000
- Orthanc: http://localhost:8042

### Network Access (Optional)
To allow network access from other computers:
1. Update firewall settings
2. Change localhost to 0.0.0.0 in development config
3. Access via: http://[your-ip]:3000

## Support

### Common Issues
1. **"Config file not found"** - Ensure `hasta_radiologi.js` exists in `platform/app/public/config/`
2. **"Port in use"** - Stop other services or change port
3. **"Cannot connect to Orthanc"** - Start Orthanc server first
4. **Build failures** - Try `yarn clean:deep && yarn install`

### Log Files
- Check browser console for client-side errors
- Check terminal output for server-side errors
- Orthanc logs available via `docker logs hasta-pacs`

## Development Notes

### File Structure
```
pacs-viewer/
├── platform/app/public/config/
│   └── hasta_radiologi.js          # Main config
├── startup-simple.bat              # Recommended startup
├── startup-viewer.bat              # Advanced startup
├── startup-viewer-alt.bat          # Alternative startup
└── README-Startup.md               # This file
```

### Environment Variables
- `NODE_ENV=development` - Development mode
- `APP_CONFIG=config/hasta_radiologi.js` - Config file
- `PORT=3000` - Viewer port

### Integration Points
- Orthanc DICOMweb API
- WADO-URI for image retrieval
- Study list and patient management
- Custom measurement tools
