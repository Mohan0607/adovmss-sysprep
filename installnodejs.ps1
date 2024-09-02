# Ensure the Temp directory exists
$tempDir = "C:\Temp"
if (-Not (Test-Path -Path $tempDir)) {
    Write-Output "Creating directory: $tempDir"
    New-Item -Path $tempDir -ItemType Directory
}

# Define the Node.js version and download URL
$nodeVersion = "v18.17.1"
$nodeInstaller = "https://nodejs.org/dist/$nodeVersion/node-$nodeVersion-x64.msi"
$nodeInstallerPath = "$tempDir\nodejs.msi"

# Download the Node.js installer
Write-Output "Downloading Node.js installer to $nodeInstallerPath..."
Invoke-WebRequest -Uri $nodeInstaller -OutFile $nodeInstallerPath -UseBasicParsing

# Check if download was successful
if (-Not (Test-Path -Path $nodeInstallerPath)) {
    Write-Output "Failed to download Node.js installer. Exiting."
    Exit 1
}

# Install Node.js with logging
$installLogPath = "$tempDir\nodejs_install.log"
Write-Output "Installing Node.js..."
Start-Process msiexec.exe -ArgumentList "/I", "`"$nodeInstallerPath`"", "/quiet", "/norestart", "/log", "`"$installLogPath`"" -Wait

# Verify installation
$nodePath = "C:\Program Files\nodejs\node.exe"
$npmPath = "C:\Program Files\nodejs\npm.cmd"

if (Test-Path -Path $nodePath) {
    $nodeVersionInstalled = & $nodePath -v
    Write-Output "Node.js version: $nodeVersionInstalled"
} else {
    Write-Output "Node.js installation failed. Check the installation log at $installLogPath"
    Exit 1
}

if (Test-Path -Path $npmPath) {
    $npmVersionInstalled = & $npmPath -v
    Write-Output "npm version: $npmVersionInstalled"
} else {
    Write-Output "npm installation failed. Check the installation log at $installLogPath"
    Exit 1
}

# Clean up
Write-Output "Cleaning up..."
Remove-Item $nodeInstallerPath -Force

Write-Output "Node.js installation completed successfully."
