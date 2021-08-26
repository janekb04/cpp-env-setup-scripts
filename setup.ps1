$ScriptPath = split-path -parent $MyInvocation.MyCommand.Definition

$wantToExcludeFromDefender = $false

if ($wantToExcludeFromDefender) {
    $runningAsAdmin = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (-not $runningAsAdmin) {
        Write-Host "To exclude the folder from Windows Defender, this script requires administrator privilages"
        Exit 1
    }

    Add-MpPreference -ExclusionPath . # security tradeoff for better performance
}

& "$ScriptPath\tools\Setup.ps1"