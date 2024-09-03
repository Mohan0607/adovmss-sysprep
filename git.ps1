# Ensure the Temp directory exists
$tempDir = "C:\Temp"
if (-Not (Test-Path -Path $tempDir)) {
    Write-Output "Creating directory: $tempDir"
    New-Item -Path $tempDir -ItemType Directory
}

# Define the Git version and download URL
$gitVersion = "2.41.0"
$gitInstaller = "https://github.com/git-for-windows/git/releases/download/v$gitVersion.windows.1/Git-$gitVersion-64-bit.exe"
$gitInstallerPath = "$tempDir\git-installer.exe"

# Download the Git installer
Write-Output "Downloading Git installer to $gitInstallerPath..."
Invoke-WebRequest -Uri $gitInstaller -OutFile $gitInstallerPath -UseBasicParsing

# Check if download was successful
if (-Not (Test-Path -Path $gitInstallerPath)) {
    Write-Output "Failed to download Git installer. Exiting."
    Exit 1
}

# Install Git with logging
$installLogPath = "$tempDir\git_install.log"
Write-Output "Installing Git..."
Start-Process -FilePath $gitInstallerPath -ArgumentList "/VERYSILENT", "/NORESTART", "/LOG=`"$installLogPath`"" -Wait

# Verify installation
$gitPath = "C:\Program Files\Git\bin\git.exe"

if (Test-Path -Path $gitPath) {
    $gitVersionInstalled = & $gitPath --version
    Write-Output "Git version: $gitVersionInstalled"
} else {
    Write-Output "Git installation failed. Check the installation log at $installLogPath"
    Exit 1
}

# Clean up
Write-Output "Cleaning up..."
Remove-Item $gitInstallerPath -Force

Write-Output "Git installation completed successfully."
