function Open-RecentFiles {
    # Get the date one week ago
    $oneWeekAgo = (Get-Date).AddDays(-7)
  
    # Get a list of recently used files within the last week
    $recentItemsPath = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft\Windows\Recent')
    $recentFiles = Get-ChildItem -Path $recentItemsPath | 
                   Where-Object { $_.LastWriteTime -ge $oneWeekAgo } |
                   Sort-Object LastWriteTime |
                   Select-Object -First 100

    # Initialize an array to hold file information
    $resultsArray = @()

    # Populate the array
    $recentFiles | ForEach-Object {
        $filePath = $_.FullName
        $fileLastAccess = $_.LastWriteTime
        $resultsArray += "$fileLastAccess | $filePath"
    }
  
    # Send the sorted results to fzf (most recent last)
    $selected = $resultsArray | fzf --tac --no-clear

    # Print the selected file path to the terminal
    if ($selected) {
        $selected.Split('|')[1].Trim()
    }
}
