# Hasta Radiologi PACS Viewer - Working Startup Scripts

## ✅ TESTED & WORKING Solutions

### 🎯 **RECOMMENDED: Use startup-simple.bat**
This is the **MOST RELIABLE** option - it has been tested and works perfectly.

```cmd
startup-simple.bat
```

**Why this works best:**
- ✅ Proper batch syntax throughout
- ✅ Reliable Orthanc connection check
- ✅ No hanging issues
- ✅ Good error handling

### 🔧 **Alternative: startup-minimal.bat**
For users who want the simplest possible startup:

```cmd
startup-minimal.bat
```

**Features:**
- ✅ Minimal checks, fast startup
- ✅ No hanging issues
- ✅ Direct to yarn dev

### 🏢 **Enterprise: startup-final.bat**
Updated version with comprehensive checks:

```cmd
startup-final.bat
```

**Features:**
- ✅ Complete dependency validation
- ✅ Automatic dependency installation
- ✅ Orthanc server detection
- ✅ Network information display

## 🚀 **Quick Start (Best Method)**

1. **Start Orthanc PACS Server:**
   ```cmd
   cd f:\PROJECT\hasta-pacs\orthanc-mwl
   startup.bat
   ```

2. **Start PACS Viewer:**
   ```cmd
   cd f:\PROJECT\hasta-pacs\pacs-viewer
   startup-simple.bat
   ```

3. **Access Viewer:**
   - Local: http://localhost:3000
   - Network: http://172.16.2.200:3000

## 🔍 **Troubleshooting Previous Issues**

### ❌ **Issue: PowerShell vs Batch Syntax**
**Problem:** Using PowerShell syntax in .bat files
```bat
# WRONG (PowerShell syntax in .bat file):
$env:NODE_ENV = "development"; $env:APP_CONFIG = "config/hasta_radiologi.js"; yarn dev

# CORRECT (Batch syntax):
set NODE_ENV=development
set APP_CONFIG=config/hasta_radiologi.js
yarn dev
```

### ✅ **Solution Applied:**
- Fixed all .bat files to use proper batch syntax
- Created separate .ps1 file for PowerShell users
- Tested working combinations

## 📋 **File Status & Recommendations**

| File | Status | Best For | Notes |
|------|--------|----------|-------|
| `startup-simple.bat` | ✅ **WORKING** | ⭐ **Most Users** | Tested, reliable |
| `startup-minimal.bat` | ✅ **WORKING** | Quick starts | Fastest option |
| `startup-final.bat` | ✅ **FIXED** | Enterprise use | Full validation |
| `startup-viewer.ps1` | ✅ **WORKING** | PowerShell users | For .ps1 preference |
| ~~startup-final.bat (old)~~ | ❌ Fixed | - | Had PowerShell syntax |

## ⚙️ **Environment Variables (Auto-set)**

All scripts automatically set:
```bat
NODE_ENV=development
APP_CONFIG=config/hasta_radiologi.js
```

This ensures your `hasta_radiologi.js` configuration is loaded correctly.

## 🎯 **Success Indicators**

When working correctly, you'll see:
```
✅ Hasta Radiologi PACS Viewer - Simple Startup
✅ OK: Node.js found
✅ OK: Yarn found
✅ OK: Configuration file found
✅ OK: Orthanc server is running
🚀 Starting OHIF Viewer...
```

Then the webpack dev server starts and shows:
```
✅ Project is running at: http://localhost:3000
✅ Proxy created: /dicom-web → http://localhost:8042
```

## 💡 **Pro Tips**

1. **Always use Command Prompt** (cmd) not PowerShell for .bat files
2. **Start Orthanc first** for best experience
3. **Use startup-simple.bat** unless you need specific features
4. **Check http://localhost:3000** once started

Your Hasta Radiologi PACS Viewer is now ready with reliable startup scripts! 🎉
