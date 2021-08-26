param(
    [Parameter(Position = 0)]
    [System.EnvironmentVariableTarget]$VariableTarget,
    [Parameter(Position = 1)]
    [System.String[]]$Items
)

# Construct PATH string
$NewPath = [Environment]::GetEnvironmentVariable("Path", $VariableTarget)  

Write-Host $NewPath

foreach ($item in $Items) {
    $NewPath += ";$item"
}

# Change PATH variable
[Environment]::SetEnvironmentVariable("Path", $NewPath, $VariableTarget)  