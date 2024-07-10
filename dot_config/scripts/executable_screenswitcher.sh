# NOTE:
# this script allow automatic detect of compatible with ddcutil display,
# check its input sources list and display them in fzf
# this allow for quick switch directly from the display input directly from the terminal
#
# Function to check if the display is compatible
is_display_compatible() {
	local display_num=$1
	ddcutil capabilities --display "$display_num" &>/dev/null
}

# Function to get the first compatible display
get_compatible_display() {
	local displays=$(ddcutil detect | awk '/^Display/ {print $2}')
	for display in $displays; do
		if is_display_compatible "$display"; then
			echo "$display"
			return
		fi
	done
	echo ""
}

# Get the compatible display
DISPLAY_NUM=$(get_compatible_display)

if [ -z "$DISPLAY_NUM" ]; then
	echo "Error: No compatible display found."
	exit 1
fi

# Function to get monitor name
get_monitor_name() {
	ddcutil detect | awk '/Display '"$DISPLAY_NUM"'/{f=1} /Model:/{if(f) {print $2, $3; f=0}}'
}

# Function to get current input source
get_current_input() {
	ddcutil getvcp 60 --display "$DISPLAY_NUM" | awk -F': ' '{print $2}' | awk '{print $1}'
}

# Function to list all input sources
list_inputs() {
	ddcutil capabilities --display "$DISPLAY_NUM" | sed -n '/Feature: 60 (Input Source)/,/Feature:/p' | grep "Values:" -A 100 | grep -v "Feature:" | grep -oP '\s+\K[0-9a-f]+: .*'
}

# Get monitor name and current input
MONITOR_NAME=$(get_monitor_name)
CURRENT_INPUT=$(get_current_input)

if [ -z "$MONITOR_NAME" ]; then
	echo "Error: Unable to detect monitor. Make sure ddcutil is properly configured."
	exit 1
fi

if [ -z "$CURRENT_INPUT" ]; then
	echo "Error: Unable to get current input. Make sure ddcutil is properly configured."
	exit 1
fi

# List inputs and pass to fzf
SELECTED_INPUT=$(list_inputs | sed "s/^$CURRENT_INPUT: /→ /" | fzf --header="Monitor: $MONITOR_NAME (Display $DISPLAY_NUM)" --prompt="Select input source: ")

# If an input was selected, switch to it
if [ ! -z "$SELECTED_INPUT" ]; then
	INPUT_CODE=$(echo "$SELECTED_INPUT" | cut -d':' -f1)
	INPUT_NAME=$(echo "$SELECTED_INPUT" | cut -d':' -f2- | xargs)
	ddcutil setvcp 60 "0x$INPUT_CODE" --display "$DISPLAY_NUM"
	echo "Switched to input: $INPUT_NAME (0x$INPUT_CODE)"
else
	echo "No input selected. Exiting."
fi
