# Get the date one week ago
$oneWeekAgo = (Get-Date).AddDays(-7)

# Get a list of recently used files within the last week
$recentItemsPath = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft\Windows\Recent')
$recentFiles = Get-ChildItem -Path $recentItemsPath |
               Where-Object { $_.LastWriteTime -ge $oneWeekAgo } |
               Sort-Object LastWriteTime -Descending

# Initialize an array to hold file information
$resultsArray = @()

# Initialize COM object for reading shortcuts
$shell = New-Object -ComObject WScript.Shell

# Populate the array
$recentFiles | ForEach-Object {
    $shortcut = $shell.CreateShortcut($_.FullName)
    $originalFilePath = $shortcut.TargetPath
    $fileLastAccess = $_.LastWriteTime

    if ($originalFilePath) {  # Exclude invalid shortcuts
        $resultsArray += "$fileLastAccess | $originalFilePath"
    }
}

# Output the array
$resultsArray -join "`n"

