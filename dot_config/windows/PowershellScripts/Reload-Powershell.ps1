function Reload-Powershell {
    # Blacklist of module names that should not be removed
    $moduleBlacklist = @(
        'Microsoft.PowerShell.Commands.Management',
        'Microsoft.PowerShell.Commands.Utility',
        'Microsoft.PowerShell.Management',
        'Microsoft.PowerShell.PSReadLine2',
        'Microsoft.PowerShell.Security',
        'Microsoft.PowerShell.Utility',
        'PSReadLine'
        # ... add any other module names that should not be removed
    )
    
    # Get a list of all currently loaded modules along with their paths
    $currentModules = Get-Module -All | Select-Object Name, Path

    # Remove all currently loaded modules except those on the blacklist
    $currentModules | ForEach-Object { 
        if ($moduleBlacklist -notcontains $_.Name) {
            Write-Host "Removing module $($_.Name)"
            Remove-Module -Name $_.Name 
        } else {
            Write-Host "Skipping removal of blacklisted module $($_.Name)"
        }
    }

    # Re-import all modules using their full paths
    $currentModules | ForEach-Object { 
        if ($moduleBlacklist -notcontains $_.Name) {
            if ($_.Path) {
                Write-Host "Importing module $($_.Name) from $($_.Path)"
                Import-Module -Name $_.Path 
            } else {
                Write-Host "Unable to find path for module $($_.Name), attempting to import by name"
                Import-Module -Name $_.Name 
            }
        } else {
            Write-Host "Skipping re-import of blacklisted module $($_.Name)"
        }
    }

    # Get a list of all profiles
    $profiles = @(
        $profile.AllUsersAllHosts,
        $profile.AllUsersCurrentHost,
        $profile.CurrentUserAllHosts,
        $profile.CurrentUserCurrentHost
    )

    # Dot-source each profile if it exists
    foreach ($profilePath in $profiles) {
        if (Test-Path -Path $profilePath) {
            Write-Host "Reloading profile $profilePath"
            . $profilePath
        }
    }
}

# Call the function to reload PowerShell environment
# Reload-Powershell

