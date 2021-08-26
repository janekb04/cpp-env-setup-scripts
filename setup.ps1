param(
    [Parameter(Position = 0)]
    [System.Boolean]$ExcludeFromDefender = $false
)

$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

if ($ExcludeFromDefender) {
    $RunningAsAdmin = (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (-not $RunningAsAdmin) {
        Write-Host "To exclude the folder from Windows Defender, this script requires administrator privilages"
        Exit 1
    }

    Add-MpPreference -ExclusionPath $ScriptPath # security tradeoff for better performance
}

& "$ScriptPath\scripts\Setup.ps1"