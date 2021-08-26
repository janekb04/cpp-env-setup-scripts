param(
    [Parameter(Position = 0, Mandatory = $true)]
    [System.String]$InstallLocation
)

if (Test-Path -Path $InstallLocation) {
    Throw "Installation location ($InstallLocation) already exists. Aborting install."
}
$Log = New-Item -ItemType "directory" -Path $InstallLocation | Out-String
if (-not $?) {
    Throw "Couldn't create installation folder ($InstallLocation). Aborting install. Full message: $Log"
}
