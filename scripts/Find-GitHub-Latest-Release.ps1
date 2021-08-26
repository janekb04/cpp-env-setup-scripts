param(
    [Parameter(Position = 0, Mandatory = $true)]
    [System.String]$User,
    [Parameter(Position = 1, Mandatory = $true)]
    [System.String]$Repository
)

((Invoke-WebRequest -URI "https://github.com/$User/$Repository/releases/latest" -Headers @{"Accept" = "application/json" }).Content | ConvertFrom-Json).tag_name