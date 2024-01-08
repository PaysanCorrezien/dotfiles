# Define the path to your repository
$repoPath = "C:\Users\dylan\Documents\KnowledgeBase"

# NOTE: to run, schedule a task :
# program : "C:\Program Files\PowerShell\7\pwsh.exe" 
# Arguments : -windowstyle hidden -ExecutionPolicy Bypass -File "C:\Users\dylan\Documents\PowerShell\FileWatcher.ps1"
# Function to get the daily log file path
function Get-DailyLogFilePath
{
  $logDir = Join-Path $env:APPDATA "PowerShellFileWatcherLogs"
  if (-not (Test-Path $logDir))
  {
    New-Item $logDir -ItemType Directory | Out-Null
  }
  $logFileName = "watcher_" + (Get-Date -Format "yyyy-MM-dd") + ".log"
  return Join-Path $logDir $logFileName
}

# Create a new FileSystemWatcher object
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $repoPath
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true
$watcher.NotifyFilter = [System.IO.NotifyFilters]'FileName, LastWrite'

# Function to perform auto-commit
function PersonalAutoCommit
{
  param($repoPath, $logFile)

  try
  {
    $lockFilePath = Join-Path $repoPath ".git\index.lock"
    if (Test-Path $lockFilePath)
    {
      Add-Content -Path $logFile -Value "[$(Get-Date -Format "yyyy-MM-dd HH:mm:ss")] Git index lock file exists. Skipping Git operations."
      return
    }

    cd $repoPath
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $status = git status --short 2>&1
    Add-Content -Path $logFile -Value "[$timestamp] Git Status Output: $status"

    if ($status)
    {
      $commitMessage = "Auto-commit: $timestamp | Changes: $($status -replace '^\?\? ', 'New File: ' -replace '^ M ', 'Modified: ' -replace '^ D ', 'Deleted: ' -replace '\s+', ' ')"
      git add . 2>&1 | Add-Content -Path $logFile
      $commitResult = git commit -m "`"$commitMessage`"" 2>&1
      Add-Content -Path $logFile -Value "[$timestamp] Commit Result: $commitResult"
    }
  } catch
  {
    Add-Content -Path $logFile -Value "[$timestamp] Error in PersonalAutoCommit: $_"
  }
}


# Define the action to be taken when a file change is detected
$action = {
  param($source, $e)

  try
  {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $relativePath = $e.FullPath -replace [regex]::Escape($repoPath), ''

    # Ignore changes in the .git directory
    if ($relativePath -notlike '\.git*')
    {
      $logFile = Get-DailyLogFilePath
      Add-Content -Path $logFile -Value "[$timestamp] Change detected: $($e.ChangeType) in $relativePath"

      # Perform the auto-commit
      PersonalAutoCommit -repoPath $repoPath -logFile $logFile
    }
  } catch
  {
    $logFile = Get-DailyLogFilePath
    Add-Content -Path $logFile -Value "[$timestamp] Error: $_"
  }
}

# Register the event handlers
$handlers = @(
  Register-ObjectEvent $watcher "Changed" -Action $action
  Register-ObjectEvent $watcher "Created" -Action $action
  Register-ObjectEvent $watcher "Deleted" -Action $action
  Register-ObjectEvent $watcher "Renamed" -Action $action
)

# Start message
$startTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logFile = Get-DailyLogFilePath
Add-Content -Path $logFile -Value "[$startTime] Watching for changes in $repoPath..."

# Check for and commit any pending changes on startup
PersonalAutoCommit -repoPath $repoPath -logFile $logFile

# Wait for events
try
{
  while ($true)
  {
    Wait-Event -Timeout 1
  }
} finally
{
  $handlers | ForEach-Object { Unregister-Event -SourceIdentifier $_.Name }
  $handlers | ForEach-Object { Remove-Job -Job $_ }
}







