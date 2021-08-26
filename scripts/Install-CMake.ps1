$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

$InstallLocation = "C:\Program Files\CMake"

& "$ScriptPath\Create-Install-Location.ps1" $InstallLocation

# Download the latest CMake release zip from GitHub
$latestReleaseTag = (& "$scriptPath\Find-GitHub-Latest-Release.ps1" "Kitware" "CMake") -replace 'v', ''
(New-Object System.Net.WebClient).DownloadFile("https://github.com/Kitware/CMake/releases/download/v$latestReleaseTag/cmake-$latestReleaseTag-windows-x86_64.zip", "$scriptPath\temp\cmake.zip")

# Extract downloaded zip archive
Add-Type -Assembly "System.IO.Compression.Filesystem"
[System.IO.Compression.ZipFile]::ExtractToDirectory("$scriptPath\temp\cmake.zip", "$scriptPath\temp")

# Move CMake files to install directory
$Log = Move-Item -Path "$scriptPath\temp\cmake-$latestReleaseTag-windows-x86_64\*" -Destination $InstallLocation | Out-String
if (-not $?) {
    Throw "Failed to move CMake files to installation location ($InstallLocation). Aborting install. Full message: $Log"
}

# Add CMake to PATH
& "$ScriptPath\Add-ToPath.ps1" -VariableTarget Machine -Items "$InstallLocation\bin"