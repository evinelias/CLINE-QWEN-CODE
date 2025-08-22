# Manual GitHub Release Creation Script
# This script creates a GitHub release with the CLINE-QWEN-CODE.vsix package

# Release Information
RELEASE_TAG="v3.26.3"
RELEASE_NAME="CLINE-QWEN-CODE v3.26.3"
RELEASE_BODY="## 🚀 Cline AI Assistant with Qwen Code API Integration

This release includes the enhanced Cline VS Code extension with **Qwen Code API support** for advanced AI-powered coding assistance.

### ✨ Key Features
- **Qwen Code Integration**: Specialized AI models for coding tasks
- **Multi-Provider Support**: Switch between Qwen, Claude, GPT, Gemini
- **Enhanced Code Generation**: 40+ programming languages supported
- **VSIX Package**: Ready-to-install VS Code extension (8.46 MB)

### 📦 Installation
1. Download \`CLINE-QWEN-CODE.vsix\` from this release
2. Install via VS Code: Extensions → Install from VSIX
3. Configure Qwen API in Cline settings
4. Start coding with enhanced AI assistance!

### 🔧 What's Included
- Complete Cline AI assistant with all original features
- Qwen Code API provider in settings
- Comprehensive documentation and guides
- 24 language localizations
- Advanced syntax highlighting support

**Package Details:**
- Size: 8.46 MB (124 files)
- Version: 3.26.3
- Compatibility: VS Code 1.84.0+
- Publisher: evinelias"

# Manual upload commands (run these manually):
# 1. Go to: https://github.com/evinelias/CLINE-QWEN-CODE/releases/new
# 2. Tag: v3.26.3
# 3. Title: CLINE-QWEN-CODE v3.26.3
# 4. Description: Copy the release body above
# 5. Upload: dist/CLINE-QWEN-CODE.vsix
# 6. Click "Publish release"