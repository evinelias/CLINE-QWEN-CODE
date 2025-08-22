#!/bin/bash
# Script to publish VSIX package to GitHub Packages

set -e

echo "🚀 Publishing CLINE-QWEN-CODE VSIX to GitHub Packages..."

# Check if dist/CLINE-QWEN-CODE.vsix exists
if [ ! -f "dist/CLINE-QWEN-CODE.vsix" ]; then
    echo "❌ VSIX file not found at dist/CLINE-QWEN-CODE.vsix"
    echo "🔧 Run 'vsce package --out dist/CLINE-QWEN-CODE.vsix --no-dependencies' first"
    exit 1
fi

# Get version from package.json
VERSION=$(node -p "require('./package.json').version")
echo "📋 Version: $VERSION"

# Create temporary package directory
echo "📁 Creating package directory..."
rm -rf vsix-package-temp
mkdir -p vsix-package-temp
cp dist/CLINE-QWEN-CODE.vsix vsix-package-temp/

# Create package.json for GitHub Packages
echo "📝 Creating package.json..."
cat > vsix-package-temp/package.json << EOF
{
  "name": "@evinelias/cline-qwen-code-vsix",
  "version": "$VERSION",
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
EOF

# Create README
echo "📖 Creating README..."
cat > vsix-package-temp/README.md << 'EOF'
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
EOF

# Publish to GitHub Packages
echo "📦 Publishing to GitHub Packages..."
cd vsix-package-temp

# Check if logged in to GitHub Packages
if ! npm whoami --registry=https://npm.pkg.github.com >/dev/null 2>&1; then
    echo "❌ Not logged in to GitHub Packages"
    echo "🔑 Run: npm login --registry=https://npm.pkg.github.com"
    echo "   Use your GitHub username and personal access token"
    exit 1
fi

npm publish --registry=https://npm.pkg.github.com

cd ..
rm -rf vsix-package-temp

echo "✅ Successfully published VSIX package!"
echo "📦 Package: @evinelias/cline-qwen-code-vsix@$VERSION"
echo "🔗 View at: https://github.com/evinelias/CLINE-QWEN-CODE/packages"
echo "📥 Install: npm install @evinelias/cline-qwen-code-vsix"