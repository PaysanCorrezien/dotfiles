#!/bin/bash

# Get the argument passed to the script
session_name=$1

# Define the path based on the session name
if [[ $session_name == "Notes" ]]; then
    path="$HOME/Obsidian_Vault"
else
    # Default path if no recognized session name is provided
    path="$HOME"
fi

# Change to the desired directory and launch lvim
cd "$path" && lvim -c "Telescope find_files"

