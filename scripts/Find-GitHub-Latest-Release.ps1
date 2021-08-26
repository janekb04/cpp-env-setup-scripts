param(
    [Parameter(Position = 0, Mandatory = $true)]
    [System.String]$User,
    [Parameter(Position = 1, Mandatory = $true)]
    [System.String]$Repository
)

$WebClient = New-Object System.Net.WebClient
$WebClient.Headers.add('accept','application/json')
($WebClient.DownloadString("https://github.com/$User/$Repository/releases/latest") | ConvertFrom-Json).tag_name