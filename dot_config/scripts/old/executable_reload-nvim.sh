#!/bin/bash

# This script is used for reload_config() nvim function , 
# reload auto lvim after change

# Define a temporary file to log debugging information
# debug_log="/tmp/restart_nvim_debug.log"

# Log the start of the script
# echo "Script started at $(date)" > "$debug_log"

# Get the identifier of the current tmux pane
tmux_pane=$(tmux display-message -p '#{pane_id}')
# echo "tmux_pane: $tmux_pane" >> "$debug_log"

# If the script is being run within a tmux session
if [ -n "$tmux_pane" ]; then
    # echo "Starting lvim in existing tmux pane" >> "$debug_log"
    sleep 1
    tmux send-keys -t $tmux_pane 'lvim -c "lua require(\"persistence\").load()"' 
    tmux send-keys -t $tmux_pane C-m
else
    # If the script is not being run within a tmux session, just start a new lvim instance
    # echo "Starting lvim in new session" >> "$debug_log"
    lvim -c 'lua require("persistence\").load()'
fi

# Log the end of the script
# echo "Script ended at $(date)" >> "$debug_log"

