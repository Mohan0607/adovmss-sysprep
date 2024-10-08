# # Installing choclatey
# Write-Output "Downloading and Installing the chocolatey packager manager"
# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Write-Host "Installing Azcopy tool"
# choco install azcopy10 -y

# Write-Host "Installing Azure CLI, GIT CLI and Nuget Tools"
# choco install azure-cli -y
# choco install git -params '"/GitAndUnixToolsOnPath"' -y
# choco install nuget.commandline --version=6.9.1 -y

# Write-Host "Install Node js 22.6.0"
# choco install nodejs -y

# -------------
# Installing Chocolatey
Write-Output "Downloading and Installing the Chocolatey package manager"
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Ensure .NET Framework 4.8 is installed (You may add this as a pre-step in Image Builder if necessary)

# Installing AzCopy tool
Write-Host "Installing AzCopy tool"
choco install azcopy10 -y --ignore-checksums

# Installing Azure CLI, Git, and NuGet tools
Write-Host "Installing Azure CLI, Git CLI, and NuGet Tools"
choco install azure-cli -y --ignore-checksums
choco install git -params '"/GitAndUnixToolsOnPath"' -y --ignore-checksums
choco install nuget.commandline --version=6.9.1 -y --ignore-checksums

# Install Node.js
Write-Host "Installing Node.js 22.6.0"
choco install nodejs -y --ignore-checksums

Write-Output "Installation of tools completed."

