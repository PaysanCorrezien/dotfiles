#!/bin/bash
# Chezmoi in WSL directly install few windows config files 

# Directly obtaining the username using whoami
windowsUsername=$(whoami)

# Dynamic path construction to handle different usernames
windowsPath="/mnt/c/Users/${windowsUsername}"

# Function to check and create directory if it doesn't exist
check_and_create_dir() {
    if [[ ! -d $1 ]]; then
        mkdir -p "$1"
    fi
}

# Sync PowerShell Core Profile
destDir="${windowsPath}/Documents/PowerShell"
check_and_create_dir "$destDir"
cp ~/.local/share/chezmoi/dot_windows/powershellcore/Microsoft.PowerShell_profile.ps1 "${destDir}/Microsoft.PowerShell_profile.ps1"

# Sync Windows Terminal settings
destDir="${windowsPath}/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
check_and_create_dir "$destDir"
cp ~/.local/share/chezmoi/dot_windows/windowsterminal/settings.json "${destDir}/settings.json"


# Sync Glaze-WM config
sourceDir="$HOME/.local/share/chezmoi/dot_windows/Glaze-WM"
destDir="${windowsPath}/.glaze-wm"
check_and_create_dir "$destDir"
cp "${sourceDir}/config.yaml" "${destDir}/config.yaml"

