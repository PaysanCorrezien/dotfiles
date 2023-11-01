
# For zoxide v0.8.0+
Invoke-Expression (& {

    $hook = if ($PSVersionTable.PSVersion.Major -lt 6)

    { 'prompt'

    } else

    { 'pwd'

    }

    (zoxide init --hook $hook powershell | Out-String)

  })

## Configuration spécifique pour Psfzf

## Set https://github.com/kelleyma49/PSFzf/blob/master/docs/Set-PsFzfOption.md

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PsFzfOption -EnableAliasFuzzyHistory
Set-PsFzfOption -EnableAliasFuzzyScroop
Set-PsFzfOption -EnableAliasFuzzyEdit

## Tab expension

Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
Set-PSReadLineKeyHandler -Chord 'Ctrl+e' -ScriptBlock {

  $ast = $tokens = $errors = $cursor = $null

  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

  $line = $ast.Extent.Text

  # Add your custom behavior here

  Invoke-PsFzfRipgrep -SearchString $line

}

function grep

{Invoke-PsFzfRipgrep -SearchString @args

}

 

## alias pour l'equivalent de ls -al linux

function ll
{ Get-ChildItem -Force @args }


function c
{ Start-Process -FilePath "C:\VSCode\Code.exe" }


$env:LUNARVIM_CONFIG_DIR = "\\wsl.localhost\Debian\home\dylan\.config\lvim"

function Open-Lvim {
    & "$($env:USERPROFILE)\.local\bin\lvim.ps1" $args
}
Set-Alias -Name lvim -Value Open-Lvim
Set-Alias -Name v -Value Open-Lvim

Invoke-Expression (& { (zoxide init powershell | Out-String) })

Import-Module 'C:\Users\dylan\Documents\Projet\Work\Projet\WSLExplorer\OpenFileProperty.ps1'

# Function to open files sorted by last access time (from "Recent Items" folder)

$fzfOptions = @(
    '--bind', 'ctrl-e:execute(powershell Start-Process {2})+abort',
    '--bind', 'ctrl-x:execute(powershell Start-Process explorer /select,{2})+abort',
    '--tac'
)
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

# Install-Module -Name PSReadLine -Force -SkipPublisherCheck
Set-PSReadLineKeyHandler -Key Ctrl+o -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
    Open-RecentFiles
}

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

# Simple function to start a new elevated process. If arguments are supplied then 
# a single command is started with admin rights; if not then a new admin instance
# of PowerShell is started.
function admin {
    if ($args.Count -gt 0) {   
        $argList = "& '" + $args + "'"
        Start-Process "$psHome\pwsh.exe" -Verb runAs -ArgumentList $argList
    } else {
        Start-Process "$psHome\pwsh.exe" -Verb runAs
    }
}

# Set UNIX-like aliases for the admin command, so sudo <command> will run the command
# with elevated rights. 
Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin


function Get-PubIP {
    (Invoke-WebRequest http://ifconfig.me/ip ).Content
}
# Compute file hashes - useful for checking successful downloads 
function md5 { Get-FileHash -Algorithm MD5 $args }
function sha1 { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }

# Find out if the current user identity is elevated (has admin rights)
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# Set up command prompt and window title. Use UNIX-style convention for identifying 
# whether user is elevated (root) or not. Window title shows current version of PowerShell
# and appends [ADMIN] if appropriate for easy taskbar identification
function prompt { 
    if ($isAdmin) {
        "[" + (Get-Location) + "] # " 
    } else {
        "[" + (Get-Location) + "] $ "
    }
}

$Host.UI.RawUI.WindowTitle = "PowerShell {0}" -f $PSVersionTable.PSVersion.ToString()
if ($isAdmin) {
    $Host.UI.RawUI.WindowTitle += " [ADMIN]"
}
# We don't need these any more; they were just temporary variables to get to $isAdmin. 
# Delete them to prevent cluttering up the user profile. 
Remove-Variable identity
Remove-Variable principal
