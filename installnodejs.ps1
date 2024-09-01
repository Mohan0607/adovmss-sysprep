# Download the Node.js installer
$nodeInstaller = "https://nodejs.org/dist/v18.17.1/node-v18.17.1-x64.msi"
$nodeInstallerPath = "C:\Temp\nodejs.msi"

Invoke-WebRequest -Uri $nodeInstaller -OutFile $nodeInstallerPath

# Install Node.js
Start-Process msiexec.exe -ArgumentList "/I", $nodeInstallerPath, "/quiet", "/norestart" -Wait

# Verify installation
node -v
npm -v

# Clean up
Remove-Item $nodeInstallerPath -Force
