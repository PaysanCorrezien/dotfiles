# Function to get monitor name
get_monitor_name() {
	ddcutil detect | awk '/Display 1/{f=1} /Model:/{if(f) {print $2, $3; f=0}}'
}

# Function to get current input source
get_current_input() {
	ddcutil getvcp 60 --display 1 | awk -F': ' '{print $2}' | awk '{print $1}'
}

# Function to list all input sources
list_inputs() {
	ddcutil capabilities --display 1 | sed -n '/Feature: 60 (Input Source)/,/Feature:/p' | grep "Values:" -A 100 | grep -v "Feature:" | grep -oP '\s+\K[0-9a-f]+: .*'
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
SELECTED_INPUT=$(list_inputs | sed "s/^$CURRENT_INPUT: /→ /" | fzf --header="Monitor: $MONITOR_NAME" --prompt="Select input source: ")

# If an input was selected, switch to it
if [ ! -z "$SELECTED_INPUT" ]; then
	INPUT_CODE=$(echo $SELECTED_INPUT | cut -d':' -f1)
	INPUT_NAME=$(echo $SELECTED_INPUT | cut -d':' -f2- | xargs)
	ddcutil setvcp 60 "0x$INPUT_CODE" --display 1
	echo "Switched to input: $INPUT_NAME (0x$INPUT_CODE)"
else
	echo "No input selected. Exiting."
fi
