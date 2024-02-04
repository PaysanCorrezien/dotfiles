#!/bin/bash
# Chezmoi in WSL directly install few windows config files
# Directly obtaining the username using whoami
# windowsUsername=$(whoami)
# Because im stupid and cant use same wsl user name as my windows user
windowsUsername=$(cmd.exe /C "echo %USERNAME%" 2>/dev/null | tr -d '\r')
# Dynamic path construction to handle different usernames
windowsPath="/mnt/c/Users/${windowsUsername}"

# Function to check and create directory if it doesn't exist
check_and_create_dir() {
	if [[ ! -d $1 ]]; then
		mkdir -p "$1"
	fi
}

# Sync PowerShell Core Profile
sourceDir="$HOME/.local/share/chezmoi/dot_windows/powershellcore"
destDir="${windowsPath}/Documents/PowerShell"
check_and_create_dir "$destDir"
# cp ~/.local/share/chezmoi/dot_windows/powershellcore/Microsoft.PowerShell_profile.ps1 "${destDir}/Microsoft.PowerShell_profile.ps1"
# cp ~/.local/share/chezmoi/dot_windows/powershellcore/bindings.ps1 "${destDir}/bindings.ps1"
# cp ~/.local/share/chezmoi/dot_windows/powershellcore/psreadlinebindings.ps1 "${destDir}/psreadlinebindings.ps1"
# # Sync Autocommit script to windows location
# cp ~/.local/share/chezmoi/dot_config/windows/PowershellScripts/FileWatcher.ps1 "${destDir}/FileWatcher.ps1"
rsync -au "${sourceDir}/" "${destDir}/"

# Sync Windows Terminal settings
destDir="${windowsPath}/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
check_and_create_dir "$destDir"
cp ~/.local/share/chezmoi/dot_windows/windowsterminal/settings.json "${destDir}/settings.json"

# Sync Glaze-WM config
sourceDir="$HOME/.local/share/chezmoi/dot_windows/Glaze-WM"
destDir="${windowsPath}/.glaze-wm"
check_and_create_dir "$destDir"
cp "${sourceDir}/config.yaml" "${destDir}/config.yaml"

#Startship Prompt
sourceDir="$HOME/.local/share/chezmoi/dot_windows/starship"
destDir="${windowsPath}/.config/starship"
check_and_create_dir "$destDir"
rsync -au "${sourceDir}/" "${destDir}/"

# New section to copy Desktop Shortcuts
sourceDir="$HOME/.local/share/chezmoi/dot_windows/DesktopShortcut"
destDir="${windowsPath}/Desktop"
check_and_create_dir "$destDir"
cp "${sourceDir}"/* "${destDir}/"

sourceDir="$HOME/.local/share/chezmoi/dot_windows/Wezterm"
destDir="${windowsPath}/.config/wezterm"
check_and_create_dir "$destDir"
# Find all directories in the source directory and replicate them in the destination
# mkdir -p "${destDir}/Fonts"
rsync -au "${sourceDir}/" "${destDir}/"

# Define source and destination directories
sourceDir="$HOME/.config/nvim"
destDir="${windowsPath}/AppData/Local/nvim"
# Call the function for the destination directory
check_and_create_dir "$destDir"
# Use rsync to synchronize, excluding the session folder
rsync -au --exclude 'session' "${sourceDir}/" "${destDir}/"
#yazi file explorer
sourceDir="$HOME/.local/share/chezmoi/dot_windows/yazi"
destDir="${windowsPath}/AppData/roaming/yazi"
# Call the function for the destination directory
check_and_create_dir "$destDir"
# Use rsync to synchronize, excluding the session folder
rsync -au --exclude 'session' "${sourceDir}/" "${destDir}/"
