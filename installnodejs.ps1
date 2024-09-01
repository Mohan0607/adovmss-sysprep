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

# Install Node.js
Write-Output "Installing Node.js..."
Start-Process msiexec.exe -ArgumentList "/I", "`"$nodeInstallerPath`"", "/quiet", "/norestart" -Wait

# Verify installation
Write-Output "Verifying Node.js installation..."
$nodeVersionInstalled = node -v
$npmVersionInstalled = npm -v

if ($nodeVersionInstalled -eq $null -or $npmVersionInstalled -eq $null) {
    Write-Output "Node.js installation failed. Exiting."
    Exit 1
} else {
    Write-Output "Node.js version: $nodeVersionInstalled"
    Write-Output "npm version: $npmVersionInstalled"
}

# Clean up
Write-Output "Cleaning up..."
Remove-Item $nodeInstallerPath -Force

Write-Output "Node.js installation completed successfully."
