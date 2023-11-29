<#
.SYNOPSIS
Starts a custom terminal with a specified window title and runs a PowerShell script.

.DESCRIPTION
The Start-CustomTerm function starts a custom terminal with a specified window title and runs a PowerShell script. It creates a temporary script file with the provided script content and opens a new terminal window to execute the script.

.PARAMETER windowTitle
Specifies the title of the custom terminal window. Default value is "FZF-TEST".

.PARAMETER ScriptContent
Specifies the content of the PowerShell script to be executed in the custom terminal.

.EXAMPLE
Start-CustomTerm -windowTitle "Custom Terminal" -ScriptContent "Write-Host 'Hello, World!'"
This example starts a custom terminal with the window title "Custom Terminal" and runs the PowerShell script "Write-Host 'Hello, World!'".
$commandStr = 'FzF-FilePath -folderPaths @("C:\userconfig", "C:\temp")'
Start-CustomTerm -Command $commandStr

.INPUTS
None

.OUTPUTS
None
#>
function Start-CustomTerm {
    param(
        [string]$windowTitle = "FZF-TEST",
        [string]$ScriptContent
    )

    $pwshPath = 'C:\Program Files\PowerShell\7\pwsh.exe'
    if (-Not (Test-Path -Path $pwshPath)) {
        $pwshPath = 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
    }

    # Create a temporary script file
    $tempScriptPath = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "tempScript.ps1")
    $ScriptContent | Out-File -FilePath $tempScriptPath

    $terminalCommand = @(
        "--title", "`"$windowTitle`"",
        $pwshPath,
        "-NoExit",
        "-ExecutionPolicy", "Bypass",
        "-File", "`"$tempScriptPath`""
    )

    Start-Process wt -ArgumentList $terminalCommand -NoNewWindow

}
# Start-FzfPathTerm -Paths @("C:\userconfig", "C:\temp")
function Start-FzfPathTerm {
    param(
        [string[]]$Paths
    )

    # Define FzF-FilePath function as a string
    $fzfFunctionDef = @'
function FzF-FilePath {
    param(
        [string[]]$folderPaths
    )

    $env:PATH = [System.Environment]::GetEnvironmentVariable('PATH', 'Machine') + ';' + 
                 [System.Environment]::GetEnvironmentVariable('PATH', 'User')

    $files = $folderPaths | ForEach-Object { Get-ChildItem -Path $_ } 
    $selectedFile = $files | ForEach-Object { $_.FullName } | fzf

    if ($selectedFile) {
        Start-Process -FilePath $selectedFile
    }
}
'@

    # Convert the array of paths to a string representation for the command
    $pathsArg = $Paths -join '", "'

    # Build the command string for FzF-FilePath
    $commandStr = "FzF-FilePath -folderPaths @(`"$pathsArg`")"

    # Combine the function definition and the command string
    $scriptContent = $fzfFunctionDef + $commandStr

    # Call Start-CustomTerm with the combined script content
    Start-CustomTerm -ScriptContent $scriptContent
}

<#
.SYNOPSIS
Starts a custom terminal to run fzf with specified options and performs an action on the selected item.

.DESCRIPTION
The Start-FZFCustomTerm function starts a custom terminal, runs fzf with specified options, and executes a provided action script block on the selected item.

.PARAMETER windowTitle
Specifies the title of the custom terminal window.

.PARAMETER FzfArgumentList
Specifies the arguments for fzf command.

.PARAMETER List
Specifies the items to be listed in fzf.

.PARAMETER ActionCommand
Specifies a script block to run on the selected item.

.EXAMPLE
Start-FZFCustomTerm -windowTitle "Custom Terminal" -FzfArgumentList "--reverse" -List $(Get-ChildItem) -Action { param($item) Start-Process $item }

.INPUTS
None

.OUTPUTS
None
#>
function Start-FZFCustomTerm
{
    param(
        [string]$windowTitle = "Custom FZF Terminal",
        [string]$FzfArgumentList,
        [System.Collections.IEnumerable]$List,
        [string]$ActionCommand
    )

    # Convert the list to a newline-separated string
    $ListAsString = $List | Out-String

    # Define the script content
    $scriptContent = @"
        `$ListAsString = 'LIST_AS_STRING_PLACEHOLDER'
        `$List = `$ListAsString -split "`r`n" | Where-Object {`$_ -ne ''}
        `$selectedItem = `$List | fzf $FzfArgumentList
        if (`$selectedItem) {
            `$commandToRun = "{0} '{1}'" -f "$ActionCommand", `$selectedItem
            Invoke-Expression `$commandToRun
        }
"@

    # Replace placeholder with actual list string
    $scriptContent = $scriptContent.Replace('LIST_AS_STRING_PLACEHOLDER', $ListAsString)

    # Call Start-CustomTerm with the script content
    Start-CustomTerm -windowTitle $windowTitle -ScriptContent $scriptContent
}
