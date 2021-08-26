param(
    [Parameter(Position = 0)]
    [System.String]$Command
)

try { 
    if (Get-Command $Command 2> $null) {
        return 1
    } 
}  
catch { 
    return 0
}

return 0
