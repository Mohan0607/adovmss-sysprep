# Ensure the Temp directory exists
$tempDir = "C:\Temp"
if (-Not (Test-Path -Path $tempDir)) {
    Write-Output "Creating directory: $tempDir"
    New-Item -Path $tempDir -ItemType Directory
}

# Define the Java version and download URL
$javaInstaller = "https://download.oracle.com/java/17/latest/jdk-17_windows-x64_bin.msi"
$javaInstallerPath = "$tempDir\java.msi"

# Download the Java installer
Write-Output "Downloading Java installer to $javaInstallerPath..."
Invoke-WebRequest -Uri $javaInstaller -OutFile $javaInstallerPath -UseBasicParsing

# Check if download was successful
if (-Not (Test-Path -Path $javaInstallerPath)) {
    Write-Output "Failed to download Java installer. Exiting."
    Exit 1
}

# Install Java with logging
$installLogPath = "$tempDir\java_install.log"
Write-Output "Installing Java..."
Start-Process msiexec.exe -ArgumentList "/I", "`"$javaInstallerPath`"", "/quiet", "/norestart", "/log", "`"$installLogPath`"" -Wait

# Verify installation
$javaPath = "C:\Program Files\Java\jdk-17\bin\java.exe"

if (Test-Path -Path $javaPath) {
    $javaVersionInstalled = & $javaPath -version
    Write-Output "Java version: $javaVersionInstalled"
} else {
    Write-Output "Java installation failed. Check the installation log at $installLogPath"
    Exit 1
}

# Clean up
Write-Output "Cleaning up..."
Remove-Item $javaInstallerPath -Force

Write-Output "Java installation completed successfully."
