<#
.SYNOPSIS
Restarts the Windows Subsystem for Linux (WSL).

.DESCRIPTION
This function restarts the specified WSL distribution by terminating it and then starting it again.

.PARAMETER distroName
The name of the WSL distribution to restart. The default value is "Debian".

.EXAMPLE
Restart-WSL -distroName "Ubuntu"
Restarts the Ubuntu WSL distribution.

.NOTES
#>

function Restart-WSL {
    param (
        [string]$distroName = "Debian"
    )

    try {
        Write-Host "Restarting WSL"
        wsl.exe --terminate $distroName
        Start-Sleep -Seconds 2
        wsl.exe -d $distroName
    }
    catch {
        Write-Host "Error restarting WSL: $_"
    }
}

Restart-WSL

