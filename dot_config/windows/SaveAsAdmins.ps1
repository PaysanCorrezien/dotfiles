param (
    [string]$sourcePath,
    [string]$destinationPath
)

function IsNetworkPath($path) {
    $psDrive = Get-PSDrive -Name ($path -split ':', 2)[0]
    $isNetwork = $psDrive.Provider.Name -eq 'FileSystem' -and $psDrive.Root -match '\\\\'
    Write-Host "IsNetworkPath: $isNetwork"
    return $isNetwork
}

Write-Host "Source Path: $sourcePath"
Write-Host "Destination Path: $destinationPath"

$destinationIsNetwork = IsNetworkPath $destinationPath
Write-Host "Destination is network path: $destinationIsNetwork"

$commandString = @"
    try {
        Write-Host "Attempting to copy file..."
        Copy-Item -Path '$sourcePath' -Destination '$destinationPath' -Force -ErrorAction Stop
        Write-Host "File copied successfully."
        Write-Host "Attempting to remove source file..."
        Remove-Item -Path '$sourcePath' -Force -ErrorAction Stop
        Write-Host "Source file removed successfully."
        exit 0
    } catch {
        Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
"@

if ($destinationIsNetwork) {
    Write-Host "Prompting for credentials for remote access..."
    $credential = Get-Credential -Message "Enter credentials for remote access"
    Write-Host "Credentials received. Executing commands remotely..."
    $scriptBlock = [ScriptBlock]::Create($commandString)
    try {
        Invoke-Command -ScriptBlock $scriptBlock -Credential $credential -ArgumentList $sourcePath, $destinationPath -ErrorAction Stop
        Write-Host "Remote execution completed successfully."
    } catch {
        Write-Host "Error during remote execution: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Executing commands in a new, elevated PowerShell process..."
    $process = Start-Process PowerShell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command $commandString" -Verb RunAs -PassThru
    Write-Host "Waiting for elevated process to complete..."
    $process.WaitForExit()
    Write-Host "Elevated process completed with exit code: $($process.ExitCode)"
    exit $process.ExitCode
}

