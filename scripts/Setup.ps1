$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

function Initialize-Tool {
    param (
        [System.String]$ToolName
    )

    if ("$ScriptPath/Check$ToolName.ps1") {
        Write-Host "${ToolName}: Found"
    }
    else {
        Write-Host "${ToolName}: Not Found... Installing"
        "$ScriptPath/Install$ToolName.ps1"
    }
}

Initialize-Tool -ToolName CMake
Initialize-Tool -ToolName GCC

# Create Temporary Directory
New-Item -ItemType Directory -Force -Path "$ScriptPath/temp" | Out-Null
