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

#BUG: GH cli completions
# Dont work properly
# $profileDir = Split-Path -Parent $PROFILE
# . (Join-Path $profileDir 'completions/gh-cli.ps1')
function c
{ Start-Process -FilePath "C:\VSCode\Code.exe" 
}

# Neovim
$configPath = "\\wsl.localhost\Debian\home\dylan\.config\nvim\init.lua"
function Open-NvimWithConfig
{
  nvim -u $configPath $args
}
set-alias -name n -value Open-NvimWithConfig

function ai {
    sgpt --repl temp --shell $args
}
function s {
  gsudo --copyNS $args
}
function ss {
gsudo status
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
if ($PSVersionTable.Platform -eq "Unix") {
    $bindingsPath = "/home/dylan/.local/share/chezmoi/dot_windows/powershellcore/bindings.ps1"
    $psreadlinebindingsPath = "/home/dylan/.local/share/chezmoi/dot_windows/powershellcore/psreadlinebindings.ps1"
} else {
    $bindingsPath = "$env:USERPROFILE\Documents\PowerShell\Bindings.ps1"
    $psreadlinebindingsPath = "$env:USERPROFILE\Documents\PowerShell/psreadlinebindings.ps1"
}

if (Test-Path -Path $bindingsPath) {
    Import-Module $bindingsPath
}

if (Test-Path -Path $psreadlinebindingsPath) {
    Import-Module $psreadlinebindingsPath
}
function which($name)
{
  Get-Command $name | Select-Object -ExpandProperty Definition
}

# Simple function to start a new elevated process. If arguments are supplied then 
# a single command is started with admin rights; if not then a new admin instance
# of PowerShell is started.
function admin {
    # Define the path to WezTerm executable
    $wezTermPath = "C:\Program Files\WezTerm\wezterm-gui.exe"

    # Check if arguments are passed
    if ($args.Count -gt 0) {
        # Concatenate arguments for PowerShell
        $argList = $args -join ' '
        # Prepare the command to run inside WezTerm
        $commandToRun = "pwsh.exe -NoExit -Command $argList"
    } else {
        # Default to just opening PowerShell if no arguments are provided
        $commandToRun = "pwsh.exe -NoExit"
    }

    # Launch WezTerm as an administrator with the specified command
    Start-Process $wezTermPath -Verb RunAs -ArgumentList "start --always-new-process -- $commandToRun"
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

function Invoke-LsDeluxe {
    lsd @args
}

Set-Alias -Name ls -Value Invoke-LsDeluxe -Option AllScope

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

# NOTE: The function executes the 'ls -alt' command when called.
# 'ls -alt' lists all files and directories in the current directory,
# sorted by modification time, with the most recently modified items first.
function l {
    ls -alt
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

#NOTE: create an automatic variables to reach psreadlines history file
$history = (Get-PSReadLineOption).HistorySavePath

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
#NOTE: Command completion
# Get the directory of the current script
$currentScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition
$completionsDirectory = Join-Path $currentScriptDirectory "completions"
if (Test-Path $completionsDirectory) {
    $completionFiles = Get-ChildItem -Path $completionsDirectory -Filter *.ps1
    # Iterate over each file and dot-source it
    foreach ($file in $completionFiles) {
        . $file.FullName
    }
} else {
    Write-Host "Completions directory not found: $completionsDirectory"
}

# Initialize Starship
Invoke-Expression (&starship init powershell)

# We don't need these any more; they were just temporary variables to get to $isAdmin. 
# Delete them to prevent cluttering up the user profile. 
Remove-Variable identity
Remove-Variable principal

Invoke-Expression (& { (zoxide init powershell | Out-String) })
