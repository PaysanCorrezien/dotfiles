## Configuration spécifique pour Psfzf

# replace with good Ripgrep
function grep
{Invoke-PsFzfRipgrep -SearchString @args

}

## alias pour l'equivalent de ls -al linux
function ll
{ Get-ChildItem -Force @args }


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

function c
{ Start-Process -FilePath "C:\VSCode\Code.exe" }

$env:LUNARVIM_CONFIG_DIR = "\\wsl.localhost\Debian\home\dylan\.config\lvim"

function Open-Lvim {
    & "$($env:USERPROFILE)\.local\bin\lvim.ps1" $args
}
Set-Alias -Name lvim -Value Open-Lvim
Set-Alias -Name v -Value Open-Lvim

$env:EDITOR = "$env:USERPROFILE\.local\bin\lvim.ps1"

if (Test-Path -Path "$env:USERPROFILE\Documents\Projet\Work\Projet\WSLExplorer\OpenFileProperty.ps1") {
Import-Module "$env:USERPROFILE\Documents\Projet\Work\Projet\WSLExplorer\OpenFileProperty.ps1"
}
# Key
if (Test-Path -Path "$env:USERPROFILE\Documents\PowerShell\.secret.ps1") {
Import-Module "$env:USERPROFILE\Documents\PowerShell\.secret.ps1"
}
#Bindings 
if (Test-Path -Path "$env:USERPROFILE\Documents\PowerShell\Bindings.ps1") {
Import-Module "$env:USERPROFILE\Documents\PowerShell\Bindings.ps1"
}

if (Test-Path -Path "$env:USERPROFILE\Documents\PowerShell\Bindings.ps1") {
Import-Module "$env:USERPROFILE\Documents\PowerShell\psreadlinebindings.ps1"
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
        "PS [" + (Get-Location) + "] # -->" 
    } else {
        "PS [" + (Get-Location) + "] $ -->"
    }
}
$Host.UI.RawUI.WindowTitle = "PowerShell {0}" -f $PSVersionTable.PSVersion.ToString()
if ($isAdmin) {
    $Host.UI.RawUI.WindowTitle += " [ADMIN]"
}
# Yazi cd on quit
function ya
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

# We don't need these any more; they were just temporary variables to get to $isAdmin. 
# Delete them to prevent cluttering up the user profile. 
Remove-Variable identity
Remove-Variable principal

Invoke-Expression (& { (zoxide init powershell | Out-String) })

