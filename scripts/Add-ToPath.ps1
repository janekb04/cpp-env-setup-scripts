param(
    [Parameter(Position = 0)]
    [System.String]$VariableSet,
    [Parameter(Position = 1)]
    [System.String[]]$Items
)

# Construct PATH string
$NewPath = "%path%"
foreach ($item in $Items) {
    $NewPath += ";$item"
}

# Change PATH variable
switch ($VariableSet) {
    'user' { 
        setx path $NewPath
    }
    'system' {
        setx path $NewPath /m
    }
}