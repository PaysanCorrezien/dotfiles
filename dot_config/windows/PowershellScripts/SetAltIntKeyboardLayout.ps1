# Function to find the registry key path for the custom keyboard layout
function Get-CustomKeyboardLayoutID
{
  param (
    [string]$layoutText = "United States (International) - Alt Gr dead keys",
    [string]$layoutFile = "intl-alt.dll"
  )
    
  Write-Host "Searching for custom keyboard layout with Layout Text: $layoutText or Layout File: $layoutFile"

  $keyboardLayoutsPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\*"
  $layouts = Get-ItemProperty -Path $keyboardLayoutsPath
    
  foreach ($layout in $layouts)
  {
    # Search by Layout Text
    if ($layout.'Layout Text' -eq $layoutText)
    {
      Write-Host "Matching Layout Text found: $($layout.'Layout Text')"
      return $layout.PSChildName
    }
    # Alternatively, search by Layout File
    elseif ($layout.'Layout File' -eq $layoutFile)
    {
      Write-Host "Matching Layout File found: $($layout.'Layout File')"
      return $layout.PSChildName
    }
  }
  Write-Host "Custom layout not found in registry."
  return $null
}

# Function to set the default keyboard layout
function Set-DefaultKeyboardLayout
{
  param (
    [string]$layoutText = "United States (International) - Alt Gr dead keys",
    [string]$layoutFile = "intl-alt.dll"
  )
    
  Write-Host "Setting Default Keyboard Layout to: $layoutText or $layoutFile"
  
  $layoutID = Get-CustomKeyboardLayoutID -layoutText $layoutText -layoutFile $layoutFile
  Write-Host "Layout ID: $layoutID"
  
  if ($null -ne $layoutID)
  {
    # Define a helper function to update a registry key
    function Update-RegistryKey ($keyPath)
    {
      # Check if the specified registry key path exists
      if (-not (Test-Path $keyPath))
      {
        Write-Host "The specified registry key path $keyPath does not exist."
        return
      }

      # Get the current list of keyboard layouts
      $currentLayouts = Get-ItemProperty -Path $keyPath | Get-Member -MemberType NoteProperty | Where-Object { $_.Name -match '^\d+$' } | ForEach-Object { $_.Name }

      # Store the previous first entry if it exists
      $previousFirstEntry = $null
      if ($currentLayouts -contains "1")
      {
        $previousFirstEntry = (Get-ItemProperty -Path $keyPath).1
      }

      # Set the desired layout as the default
      New-ItemProperty -Path $keyPath -Name "1" -Value $layoutID -PropertyType String -Force

      # Remove any duplicate entries for the desired layout
      foreach ($position in $currentLayouts)
      {
        $existingLayoutID = (Get-ItemProperty -Path $keyPath).$position
        if ($existingLayoutID -eq $layoutID && $position -ne "1")
        {
          Remove-ItemProperty -Path $keyPath -Name $position
        }
      }

      # Move the previous first entry to the position of the desired layout, if it wasn't already present
      if ($null -eq $currentLayouts -or $currentLayouts -notcontains $layoutID)
      {
        $layoutPosition = [string]([int]$currentLayouts[-1] + 1)
        New-ItemProperty -Path $keyPath -Name $layoutPosition -Value $previousFirstEntry -PropertyType String -Force
      }
    }
    # Update the HKEY_CURRENT_USER key
    Update-RegistryKey "HKCU:\Keyboard Layout\Preload"
        
    # Update the HKEY_USERS key for the logged-in user
    $sid = [System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value
    Write-Host "SID: $sid"  # Debugging line to output the SID
    $registryPath = "Registry::HKEY_USERS\$sid\Keyboard Layout\Preload"
    Write-Host "Registry Path: $registryPath"  # Debugging line to output the registry path

    Update-RegistryKey $registryPath
        
    # Notify the user to log off and log back on for the changes to take effect
    Write-Host "Default keyboard layout set. Please log off and log back on for the changes to take effect."
  } else
  {
    Write-Host "Custom layout not found."
  }
}

# Ensure HKU: drive is mapped
if (-not (Get-PSDrive -Name HKU -ErrorAction SilentlyContinue))
{
  Write-Host "Mapping HKU: drive"
  New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS
}

# Invoke the function to set the default keyboard layout
Set-DefaultKeyboardLayout -layoutText "United States (International) - Alt Gr dead keys" -layoutFile "intl-alt.dll"

