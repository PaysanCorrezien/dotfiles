VM_NAME="windows-11" # Changed to match the actual window name
WORKSPACE="12"
PREV_WORKSPACE_FILE="/tmp/prev_workspace"

# Function to check if VM window exists
vm_window_exists() {
	xdotool search --name "$VM_NAME" >/dev/null 2>&1
}

# Function to focus VM window
focus_vm() {
	local window_ids=$(xdotool search --name "$VM_NAME")
	if [ -n "$window_ids" ]; then
		# Activate the last (likely the main) window
		xdotool windowactivate --sync $(echo "$window_ids" | tail -n 1)
	else
		echo "VM window not found." >&2
		return 1
	fi
}

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

# Main logic
main() {
	local CURRENT_WORKSPACE=$(get_current_workspace)
	if [[ $CURRENT_WORKSPACE -eq $((WORKSPACE - 1)) ]]; then
		# We're on the VM workspace, go back to previous workspace
		restore_previous_workspace
	else
		# We're not on the VM workspace
		if vm_window_exists; then
			save_current_workspace
			switch_to_workspace $((WORKSPACE - 1))
			focus_vm || switch_to_workspace "$CURRENT_WORKSPACE"
		else
			echo "VM window does not exist. Please ensure the VM is running." >&2
		fi
	fi
}

# Run the main function
main
