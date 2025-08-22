# Script to create a VSIX package tag and trigger GitHub Actions
# This will publish only the VSIX file to GitHub Packages

param(
    [string]$Version = $null
)

if (-not $Version) {
    $packageJson = Get-Content "package.json" | ConvertFrom-Json
    $Version = $packageJson.version
}

Write-Host "🏷️ Creating VSIX package tag: vsix-v$Version" -ForegroundColor Green

# Create and push the tag
git tag "vsix-v$Version"
git push origin "vsix-v$Version"

Write-Host "✅ Tag created and pushed!" -ForegroundColor Green
Write-Host "🚀 GitHub Actions will now publish the VSIX package" -ForegroundColor Cyan
Write-Host "📍 Monitor progress at: https://github.com/evinelias/CLINE-QWEN-CODE/actions" -ForegroundColor Blue
Write-Host "📦 Package will appear at: https://github.com/evinelias/CLINE-QWEN-CODE/packages" -ForegroundColor Magenta