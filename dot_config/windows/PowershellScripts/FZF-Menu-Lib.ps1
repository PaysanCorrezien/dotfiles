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
