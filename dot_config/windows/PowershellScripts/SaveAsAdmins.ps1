param (
    [string]$sourcePath,
    [string]$destinationPath
)
$LogPath = "c:\temp\saveasadmin.log"

function Log($message) {
    "$message" | Out-File $LogPath -Append
}

function IsNetworkPath($path) {
    $psDrive = Get-PSDrive -Name ($path -split ':', 2)[0]
    $isNetwork = $psDrive.Provider.Name -eq 'FileSystem' -and $psDrive.Root -match '\\\\'
    Log "IsNetworkPath: $isNetwork"
    return $isNetwork
}

Log "Source Path: $sourcePath"
Log "Destination Path: $destinationPath"

$destinationIsNetwork = IsNetworkPath $destinationPath
Log "Destination is network path: $destinationIsNetwork"

$commandString = @"
    try {
        Log "Attempting to copy file..."
        Copy-Item -Path '$sourcePath' -Destination '$destinationPath' -Force -ErrorAction Stop
        Log "File copied successfully."
        Log "Attempting to remove source file..."
        Remove-Item -Path '$sourcePath' -Force -ErrorAction Stop
        Log "Source file removed successfully."
        exit 0
    } catch {
        Log "Error: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
"@

if ($destinationIsNetwork) {
    Log "Prompting for credentials for remote access..."
    $credential = Get-Credential -Message "Enter credentials for remote access"
    Log "Credentials received. Executing commands remotely..."
    $scriptBlock = [ScriptBlock]::Create($commandString)
    try {
        Invoke-Command -ScriptBlock $scriptBlock -Credential $credential -ArgumentList $sourcePath, $destinationPath -ErrorAction Stop
        Log "Remote execution completed successfully."
    } catch {
        Log "Error during remote execution: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
} else {
    Log "Executing commands in a new, elevated PowerShell process..."
    $process = Start-Process PowerShell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command $commandString" -Verb RunAs -PassThru
    Log "Waiting for elevated process to complete..."
    $process.WaitForExit()
    Log "Elevated process completed with exit code: $($process.ExitCode)"
    exit $process.ExitCode
}

