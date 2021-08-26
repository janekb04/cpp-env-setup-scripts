param(
    [Parameter(Position = 0)]
    [ValidateSet('user', 'system')]
    [System.String]$VariableSet
)

# Construct PATH string
$NewPath = "%path%"
foreach ($item in $args) {
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