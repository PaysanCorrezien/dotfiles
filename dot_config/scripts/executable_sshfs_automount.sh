#!/usr/bin/env bash

# sshfs_automount.sh
#
# Description:
#   This script provides an interactive way to mount remote directories using SSHFS.
#   It uses fzf for host selection, automatically determines the appropriate username,
#   and changes to the mounted directory upon successful mount.
#
# Usage:
#   source ./sshfs_automount.sh
#   sshfs_automount
#
# Dependencies:
#   - fzf: for interactive host selection
#   - sshfs: for mounting remote directories
#   - ssh: for querying SSH configurations
#
# Notes:
#   - Ensure you have SSH key-based authentication set up for passwordless login.
#   - The script creates mount points in ~/mount/ directory.
#   - It reads known hosts from both ~/.ssh/known_hosts and ~/.ssh/config.
#   - After successful mount, it changes the current directory to the mount point.

# Function to get known hosts
get_known_hosts() {
	if [[ -f ~/.ssh/known_hosts ]]; then
		awk '{print $1}' ~/.ssh/known_hosts | sort | uniq
	fi
	if [[ -f ~/.ssh/config ]]; then
		awk '/^Host / {print $2}' ~/.ssh/config
	fi
}

# Function to get username for a host
get_username_for_host() {
	local host=$1
	local username

	# Use ssh -G to get the effective SSH configuration
	username=$(ssh -G "$host" | awk '$1 == "user" {print $2; exit}')

	# If not found, use the current user
	if [[ -z $username ]]; then
		username=$USER
	fi

	echo "$username"
}

# Main function
sshfs_automount() {
	# Create mount directory if it doesn't exist
	mkdir -p ~/mount

	# Get list of known hosts
	known_hosts=$(get_known_hosts)

	# Use fzf to select host
	selected_host=$(echo "$known_hosts" | fzf --prompt="Select host to mount: ")

	if [ -z "$selected_host" ]; then
		echo "No host selected. Exiting."
		return 1
	fi

	# Get username for the selected host
	username=$(get_username_for_host "$selected_host")

	# Create mount point
	mount_point=~/mount/${selected_host//[.:]/\_}
	mkdir -p "$mount_point"

	# Mount using sshfs
	sshfs "${username}@${selected_host}:" "$mount_point"

	if [ $? -eq 0 ]; then
		echo "Successfully mounted ${selected_host} to ${mount_point}"
		echo "Changing directory to ${mount_point}"
		cd "$mount_point"
	else
		echo "Failed to mount ${selected_host}"
		rmdir "$mount_point"
	fi
}

sshfs_automount
