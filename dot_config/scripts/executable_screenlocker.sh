#!/bin/bash
#screenlocker.sh script

# Set the wallpaper directory
WALLPAPER_DIR="/home/dylan/Images/wp/"

# Select a random wallpaper from the directory
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name '*.jpg' -o -name '*.png' \) | shuf -n1)

# Copy the wallpaper to /usr/share/images/desktop-base/ and replace default.jpg
sudo cp "$WALLPAPER" /usr/share/images/desktop-base/default.jpg

# Lock the screen
dm-tool lock
