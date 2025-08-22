@echo off
echo Building Cline with Qwen Code integration...

echo Step 1: Change to project directory
cd /d "d:\QODER-CLINE\cline-3.26.2"

echo Step 2: Build webview (already done)
echo Webview build completed successfully

echo Step 3: Run esbuild for extension
echo Building extension with esbuild...
node esbuild.mjs --production

echo Step 4: Create VSIX package
echo Creating VSIX package...
npx vsce package --no-dependencies --out dist/cline-with-qwen.vsix

echo Build completed!
echo VSIX package created at: dist/cline-with-qwen.vsix
pause