## Configuration spécifique pour Psfzf

# replace with good Ripgrep
function grep
{Invoke-PsFzfRipgrep -SearchString @args

}

## alias pour l'equivalent de ls -al linux
function ll
{ Get-ChildItem -Force @args 
}


$ENV:FZF_DEFAULT_OPTS=@"
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796
"@

$env:FZF_DEFAULT_OPTS+=" --height 60%"
# Configure CTRL+T options
$env:FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
$env:FZF_CTRL_T_OPTS=@"
  --preview 'bat -n --color=always {}'
"@

# Configure default command
$env:FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

#BUG: copy dont work for now
# Configure CTRL+R options
$env:FZF_CTRL_R_OPTS=@"
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | Set-Clipboard)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'
"@


# $env:GIT_SSH_COMMAND = '"C:\\Program Files\\OpenSSH\\ssh.exe"'


#BUG: GH cli completions
# Dont work properly
# $profileDir = Split-Path -Parent $PROFILE
# . (Join-Path $profileDir 'completions/gh-cli.ps1')
function c
{ Start-Process -FilePath "C:\VSCode\Code.exe" 
}

$env:LUNARVIM_CONFIG_DIR = "\\wsl.localhost\Debian\home\dylan\.config\lvim"
# Neovim
$configPath = "\\wsl.localhost\Debian\home\dylan\.config\nvim\init.lua"
function Open-NvimWithConfig
{
  nvim -u $configPath $args
}
set-alias -name n -value Open-NvimWithConfig

function Open-Lvim
{
  & "$($env:USERPROFILE)\.local\bin\lvim.ps1" $args
}
Set-Alias -Name lvim -Value Open-Lvim
Set-Alias -Name v -Value Open-Lvim
function ai {
    sgpt --repl temp --shell $args
}

$env:EDITOR = "$env:USERPROFILE\.local\bin\lvim.ps1"

if (Test-Path -Path "$env:USERPROFILE\Documents\Projet\Work\Projet\WSLExplorer\OpenFileProperty.ps1")
{
  Import-Module "$env:USERPROFILE\Documents\Projet\Work\Projet\WSLExplorer\OpenFileProperty.ps1"
}
# Key
if (Test-Path -Path "$env:USERPROFILE\Documents\PowerShell\.secret.ps1")
{
  Import-Module "$env:USERPROFILE\Documents\PowerShell\.secret.ps1"
}
#Bindings 
if (Test-Path -Path "$env:USERPROFILE\Documents\PowerShell\Bindings.ps1")
{
  Import-Module "$env:USERPROFILE\Documents\PowerShell\Bindings.ps1"
}

if (Test-Path -Path "$env:USERPROFILE\Documents\PowerShell\Bindings.ps1")
{
  Import-Module "$env:USERPROFILE\Documents\PowerShell\psreadlinebindings.ps1"
}

function which($name)
{
  Get-Command $name | Select-Object -ExpandProperty Definition
}

# Simple function to start a new elevated process. If arguments are supplied then 
# a single command is started with admin rights; if not then a new admin instance
# of PowerShell is started.
function admin
{
  if ($args.Count -gt 0)
  {   
    $argList = "& '" + $args + "'"
    Start-Process "$psHome\pwsh.exe" -Verb runAs -ArgumentList $argList
  } else
  {
    Start-Process "$psHome\pwsh.exe" -Verb runAs
  }
}

# Set UNIX-like aliases for the admin command, so sudo <command> will run the command
# with elevated rights. 
Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin


function Get-PubIP
{
    (Invoke-WebRequest http://ifconfig.me/ip ).Content
}
# Compute file hashes - useful for checking successful downloads 
function md5
{ Get-FileHash -Algorithm MD5 $args 
}
function sha1
{ Get-FileHash -Algorithm SHA1 $args 
}
function sha256
{ Get-FileHash -Algorithm SHA256 $args 
}

# Find out if the current user identity is elevated (has admin rights)
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# Set up command prompt and window title. Use UNIX-style convention for identifying 
# whether user is elevated (root) or not. Window title shows current version of PowerShell
# and appends [ADMIN] if appropriate for easy taskbar identification
# function prompt
# {
#   $p = $executionContext.SessionState.Path.CurrentLocation
#   $ansi_escape = [char]27
#   $osc7 = ""
#   $osc2 = ""
# 
#   if ($p.Provider.Name -eq "FileSystem")
#   {
#     # Get the current directory and its parent
#     $provider_path = $p.ProviderPath -Replace "\\", "/"
#     $currentDir = Split-Path $provider_path -Leaf
#     $parentDir = Split-Path $provider_path -Parent | Split-Path -Leaf
# 
#     # Concatenate parent and current directory
#     $dirDisplay = "$parentDir\$currentDir"
# 
#     # Prepare OSC 7 sequence for current directory
#     $osc7_path = "file://${env:COMPUTERNAME}/${provider_path}"
#     $osc7 = "$ansi_escape]7;$osc7_path$ansi_escape\"
# 
#     # Prepare OSC 2 sequence for window title
#     $windowTitle = "PWSH - $dirDisplay"
#     if ($isAdmin)
#     {
#       $windowTitle += " [ADMIN]"
#       $osc7_path += " [ADMIN]"
#       $adminTag = "[ADMIN]"
#     }
# 
#     $osc2 = "$ansi_escape]2;$windowTitle$ansi_escape\"
# 
#     # Update OSC 7 sequence with admin tag if necessary
#     $osc7 = "$ansi_escape]7;$osc7_path$ansi_escape\"
#   }
# 
#   # Output OSC 7 and OSC 2 sequences
#   # Custom prompt format: PS parentdir\currentdir -->
#   $osc7 + $osc2 + "PS ($dirDisplay)$adminTag --> "
# }

#   # Wezterm need osc7 to set the current directory
#   # https://wezfurlong.org/wezterm/shell-integration.html#osc-7-on-windows-with-cmdexe 
#   # dont work with starship
#   $p = $executionContext.SessionState.Path.CurrentLocation
#   $osc7 = ""
#   if ($p.Provider.Name -eq "FileSystem")
#   {
#     $ansi_escape = [char]27
#     $provider_path = $p.ProviderPath -Replace "\\", "/"
#     $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
#   }
#   "${osc7}PS $p$('>' * ($nestedPromptLevel + 1)) ";
#   # Custom logic for admins for the prompt for the prompt for the prompt for the prompt
#
#   if ($isAdmin)
#   {
#     "PS [" + (Get-Location) + "] # -->" 
#   } else
#   {
#     "PS [" + (Get-Location) + "] $ -->"
#   }
#   $host.UI.RawUI.WindowTitle = "PowerShell - " + (Get-Location).Path
#   "PS " + (Get-Location).Path + ">"
# }
# $Host.UI.RawUI.WindowTitle = "PowerShell {0}" -f $PSVersionTable.PSVersion.ToString()
# if ($isAdmin)
# {
#   $Host.UI.RawUI.WindowTitle += " [ADMIN]"
# }
# Yazi cd on quit
# For nvim ! command
# function Invoke-PlainCommand {
#     param([string]$Command)
#     $output = & pwsh -Command $Command
#     $output -replace '\e\[\d+;?\d*m', ''
# }

function y
{
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path)
  {
    Set-Location -Path $cwd
  }
  Remove-Item -Path $tmp
}

function Reload-Powershell
{
  # Blacklist of module names that should not be removed
  $moduleBlacklist = @(
    'Microsoft.PowerShell.Commands.Management',
    'Microsoft.PowerShell.Commands.Utility',
    'Microsoft.PowerShell.Management',
    'Microsoft.PowerShell.PSReadLine2',
    'Microsoft.PowerShell.Security',
    'Microsoft.PowerShell.Utility',
    'PSReadLine'
  )
    
  # Get a list of all currently loaded modules along with their paths
  $currentModules = Get-Module -All | Select-Object Name, Path

  # Remove all currently loaded modules except those on the blacklist
  $currentModules | ForEach-Object { 
    if ($moduleBlacklist -notcontains $_.Name)
    {
      Write-Host "Removing module $($_.Name)"
      Remove-Module -Name $_.Name 
    } else
    {
      Write-Host "Skipping removal of blacklisted module $($_.Name)"
    }
  }

  # Re-import all modules using their full paths
  $currentModules | ForEach-Object { 
    if ($moduleBlacklist -notcontains $_.Name)
    {
      if ($_.Path)
      {
        Write-Host "Importing module $($_.Name) from $($_.Path)"
        Import-Module -Name $_.Path 
      } else
      {
        Write-Host "Unable to find path for module $($_.Name), attempting to import by name"
        Import-Module -Name $_.Name 
      }
    } else
    {
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
  foreach ($profilePath in $profiles)
  {
    if (Test-Path -Path $profilePath)
    {
      Write-Host "Reloading profile $profilePath"
      . $profilePath
    }
  }
}

# make windows git cli use SSH AGENT correctly :
$env:GIT_SSH_COMMAND = '"C:\\Program Files\\OpenSSH\\ssh.exe"'

# Set the location of the Starship configuration
$ENV:STARSHIP_CONFIG = "$env:USERPROFILE\.config\starship\starship.toml"

# Define the function to set OSC 7 escape sequence
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
        $host.ui.Write($prompt)
    }
}

# Define a custom Prompt function that integrates Starship and sets OSC 7
function Prompt {
    # Call the function to set OSC 7 before Starship renders the prompt
    Invoke-Starship-PreCommand

    # Let Starship render the prompt
    $global:LASTEXITCODE = $?
    Invoke-Expression (&starship prompt --status=$LASTEXITCODE --jobs=(Get-Job -State Running).Count)
}

# Initialize Starship
Invoke-Expression (&starship init powershell)

# We don't need these any more; they were just temporary variables to get to $isAdmin. 
# Delete them to prevent cluttering up the user profile. 
Remove-Variable identity
Remove-Variable principal

Invoke-Expression (& { (zoxide init powershell | Out-String) })
