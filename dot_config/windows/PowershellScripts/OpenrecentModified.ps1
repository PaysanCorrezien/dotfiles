# Function to open files sorted by last modification time (from Windows Search Index)
function Open-LastModifiedFiles {
    # Initialize COM object for Windows Search
    $connection = New-Object -ComObject "ADODB.Connection"
    $recordSet = New-Object -ComObject "ADODB.Recordset"
    $connection.Open("Provider=Search.CollatorDSO;Extended Properties='Application=Windows';")
  
    # Get the date one week ago
    $oneWeekAgo = (Get-Date).AddDays(-7).ToString("yyyy-MM-ddTHH:mm:ss")
  
    # SQL query for files modified in the last week, limited to 100 results
    $query = "SELECT TOP 100 System.ItemPathDisplay, System.DateModified FROM SYSTEMINDEX WHERE System.DateModified >= '$oneWeekAgo' ORDER BY System.DateModified ASC"
  
    $recordSet.Open($query, $connection)
  
    # Initialize an array to hold file information
    $resultsArray = @()
  
    # Fetch and populate the array
    while(-not $recordSet.EOF) {
        $filePath = $recordSet.Fields.Item("System.ItemPathDisplay").Value
        $fileLastModified = $recordSet.Fields.Item("System.DateModified").Value
        $resultsArray += "$fileLastModified | $filePath"
      
        $recordSet.MoveNext()
    }
  
    # Close COM objects
    $recordSet.Close()
    $connection.Close()
  
    # Send the sorted results to fzf (most recent last)
    $selected = $resultsArray | fzf --tac
  
    # Print the selected file path to the terminal
    if ($selected) {
        $selected.Split('|')[1].Trim()
    }
}

