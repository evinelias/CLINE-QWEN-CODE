# Script to publish VSIX package to GitHub Packages
# PowerShell version for Windows

Write-Host "🚀 Publishing CLINE-QWEN-CODE VSIX to GitHub Packages..." -ForegroundColor Green

# Check if dist/CLINE-QWEN-CODE.vsix exists
if (-not (Test-Path "dist/CLINE-QWEN-CODE.vsix")) {
    Write-Host "❌ VSIX file not found at dist/CLINE-QWEN-CODE.vsix" -ForegroundColor Red
    Write-Host "🔧 Run 'vsce package --out dist/CLINE-QWEN-CODE.vsix --no-dependencies' first" -ForegroundColor Yellow
    exit 1
}

# Get version from package.json
$packageJson = Get-Content "package.json" | ConvertFrom-Json
$version = $packageJson.version
Write-Host "📋 Version: $version" -ForegroundColor Cyan

# Create temporary package directory
Write-Host "📁 Creating package directory..." -ForegroundColor Yellow
if (Test-Path "vsix-package-temp") {
    Remove-Item -Recurse -Force "vsix-package-temp"
}
New-Item -ItemType Directory -Path "vsix-package-temp" | Out-Null
Copy-Item "dist/CLINE-QWEN-CODE.vsix" "vsix-package-temp/"

# Create package.json for GitHub Packages
Write-Host "📝 Creating package.json..." -ForegroundColor Yellow
$packageJsonContent = @"
{
  "name": "@evinelias/cline-qwen-code-vsix",
  "version": "$version",
  "description": "CLINE-QWEN-CODE VS Code Extension Package - Direct VSIX Download",
  "main": "CLINE-QWEN-CODE.vsix",
  "files": [
    "CLINE-QWEN-CODE.vsix",
    "README.md"
  ],
  "keywords": [
    "vscode",
    "extension", 
    "vsix",
    "ai",
    "cline",
    "qwen",
    "coding-assistant",
    "artificial-intelligence",
    "code-generation",
    "developer-tools"
  ],
  "author": {
    "name": "evinelias",
    "url": "https://github.com/evinelias"
  },
  "license": "Apache-2.0",
  "repository": {
    "type": "git",
    "url": "https://github.com/evinelias/CLINE-QWEN-CODE.git"
  },
  "homepage": "https://github.com/evinelias/CLINE-QWEN-CODE",
  "bugs": {
    "url": "https://github.com/evinelias/CLINE-QWEN-CODE/issues"
  },
  "publishConfig": {
    "registry": "https://npm.pkg.github.com"
  },
  "engines": {
    "vscode": "^1.84.0"
  }
}
"@

$packageJsonContent | Out-File -FilePath "vsix-package-temp/package.json" -Encoding UTF8

# Create README
Write-Host "📖 Creating README..." -ForegroundColor Yellow
$readmeContent = @'
# CLINE-QWEN-CODE VS Code Extension

🚀 **Enhanced AI Coding Assistant with Qwen Code API Integration**

## Quick Installation

1. Download the VSIX file: `CLINE-QWEN-CODE.vsix`
2. Install via VS Code: Extensions → Install from VSIX
3. Configure Qwen API in Cline settings
4. Start coding with enhanced AI assistance!

## Features

- **Qwen Code Integration**: Specialized AI models for coding tasks
- **Multi-Provider Support**: Switch between Qwen, Claude, GPT, Gemini  
- **Enhanced Code Generation**: 40+ programming languages supported
- **Terminal Integration**: Execute commands with AI monitoring
- **Browser Automation**: Web testing and debugging capabilities
- **MCP Support**: Extensible via Model Context Protocol

## Installation from Package

```bash
# Install from GitHub Packages
npm install @evinelias/cline-qwen-code-vsix

# Extract VSIX file and install
code --install-extension CLINE-QWEN-CODE.vsix
```

## Repository

Source code: https://github.com/evinelias/CLINE-QWEN-CODE
'@

$readmeContent | Out-File -FilePath "vsix-package-temp/README.md" -Encoding UTF8

# Setup npm registry for GitHub Packages
Write-Host "🔧 Setting up npm registry..." -ForegroundColor Yellow
$env:NODE_AUTH_TOKEN = $env:GITHUB_TOKEN

# Publish to GitHub Packages
Write-Host "📦 Publishing to GitHub Packages..." -ForegroundColor Green
Set-Location "vsix-package-temp"

try {
    npm publish --registry=https://npm.pkg.github.com
    Write-Host "✅ Successfully published VSIX package!" -ForegroundColor Green
    Write-Host "📦 Package: @evinelias/cline-qwen-code-vsix@$version" -ForegroundColor Cyan
    Write-Host "🔗 View at: https://github.com/evinelias/CLINE-QWEN-CODE/packages" -ForegroundColor Blue
    Write-Host "📥 Install: npm install @evinelias/cline-qwen-code-vsix" -ForegroundColor Magenta
}
catch {
    Write-Host "❌ Failed to publish package: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "💡 Make sure you have a GitHub Personal Access Token with packages:write scope" -ForegroundColor Yellow
    Write-Host "💡 Set it as GITHUB_TOKEN environment variable" -ForegroundColor Yellow
}
finally {
    Set-Location ".."
    if (Test-Path "vsix-package-temp") {
        Remove-Item -Recurse -Force "vsix-package-temp"
    }
}