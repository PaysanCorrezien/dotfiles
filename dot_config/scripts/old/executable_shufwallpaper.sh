#!/bin/bash
#shufwallpaper.sh script
# Set the wallpaper directory
WALLPAPER_DIR="$HOME/Images/wp/"

# Select a random wallpaper from the directory
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

DISPLAY=:0
# Set the wallpaper using feh
feh --bg-scale "$WALLPAPER"
