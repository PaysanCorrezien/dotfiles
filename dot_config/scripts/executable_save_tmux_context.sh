#!/bin/bash

# Path to the file where the current tmux context will be stored
CONTEXT_FILE="$HOME/.tmux_saved_context"

# Get the current tmux session and window
CURRENT_CONTEXT=$(tmux display-message -p '#S:#I')

# Save it to the context file
echo "$CURRENT_CONTEXT" > "$CONTEXT_FILE"

