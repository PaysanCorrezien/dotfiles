TARGET_WORKSPACE=11 # Workspace 12 is actually 11 in zero-based indexing
PREV_WORKSPACE_FILE="/tmp/prev_workspace"

# Function to get current workspace
get_current_workspace() {
	xdotool get_desktop
}

# Function to switch to workspace
switch_to_workspace() {
	xdotool set_desktop "$1"
}

# Function to save current workspace
save_current_workspace() {
	get_current_workspace >"$PREV_WORKSPACE_FILE"
}

# Function to restore previous workspace
restore_previous_workspace() {
	if [[ -f "$PREV_WORKSPACE_FILE" ]]; then
		switch_to_workspace $(cat "$PREV_WORKSPACE_FILE")
		rm "$PREV_WORKSPACE_FILE"
	fi
}

# Updated function to focus the active window on the current workspace
focus_active_window() {
	local current_workspace=$(xdotool get_desktop)
	local window_id=$(xdotool search --desktop $current_workspace --onlyvisible "" 2>/dev/null | head -n 1)

	if [[ -n "$window_id" ]]; then
		xdotool windowactivate $window_id
		echo "Focused window $window_id on workspace $current_workspace"
	else
		echo "No visible window found on workspace $current_workspace"
	fi
}

# Main logic
main() {
	local CURRENT_WORKSPACE=$(get_current_workspace)
	if [[ $CURRENT_WORKSPACE -eq $TARGET_WORKSPACE ]]; then
		# We're on the target workspace, go back to previous workspace
		restore_previous_workspace
	else
		# We're not on the target workspace, switch to it
		save_current_workspace
		switch_to_workspace $TARGET_WORKSPACE
		sleep 0.2 # Add a small delay to ensure workspace switch is complete
		focus_active_window
	fi
}

# Run the main function
main
