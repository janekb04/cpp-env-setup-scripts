$ScriptPath = split-path -parent $MyInvocation.MyCommand.Definition

$InstallLocation = "C:\msys64"

& "$ScriptPath\Create-Install-Location.ps1" $InstallLocation

# Download MSYS2 auto install script
(new-object System.Net.WebClient).DownloadFile('https://github.com/msys2/msys2-installer/raw/master/auto-install.js', "$scriptPath\temp\msys2_auto_install.js")

# Find latest MSYS2 release
$ExeName = (Invoke-WebRequest "https://repo.msys2.org/distrib/x86_64/").Content | Select-String -AllMatches -Pattern 'msys2-x86_64-\d*\.exe' | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value } | Select-Object -Last 1

# Download MSYS2 installer
(new-object System.Net.WebClient).DownloadFile("https://repo.msys2.org/distrib/x86_64/$ExeName", "$scriptPath\temp\msys2-installer.exe")

# Run MSYS2 installer using auto install script
& "$scriptPath\temp\msys2-installer.exe" --platform minimal --script "$scriptPath\temp\msys2_auto_install.js" -v InstallDir=$InstallLocation

# Update MSYS 2 packages
& "$InstallLocation\usr\bin\bash.exe" -l -c "pacman -Syu"
& "$InstallLocation\usr\bin\bash.exe" -l -c "pacman -Su"

# Install MinGW64
& "$InstallLocation\usr\bin\bash.exe" -l -c "pacman -S --needed base-devel mingw-w64-x86_64-toolchain"

# Add MinGW64 to PATH
& "$ScriptPath\Add-ToPath.ps1" -VariableSet System -Items "$InstallDir\mingw64\bin"

