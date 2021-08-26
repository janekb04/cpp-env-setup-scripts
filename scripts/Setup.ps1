$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

function Initialize-Tool {
    param (
        [System.String]$ToolName
    )

    if (& "$ScriptPath/Check-Command-Exists.ps1" $ToolName) {
        Write-Host "${ToolName}: Found" -ForegroundColor Green
    }
    else {
        # Install missing tool
        Write-Host "${ToolName}: Not Found... Installing"
        & "$ScriptPath/Install-$ToolName.ps1"

        # Reload PATH
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

        # Check if installation succeded
        if (& "$ScriptPath/Check-Command-Exists.ps1" $ToolName) {
            Write-Host "Installation succeded" -ForegroundColor Green
        }
        else {
            Write-Host "Installation failed" -ForegroundColor Red
        }
    }


    
Write-Host "Installation Done"
}

# Create Temporary Directory
New-Item -ItemType Directory -Force -Path "$ScriptPath/temp" | Out-Null

Initialize-Tool -ToolName CMake
Initialize-Tool -ToolName GCC
