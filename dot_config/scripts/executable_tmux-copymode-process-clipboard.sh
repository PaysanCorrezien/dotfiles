#!/bin/bash

# Log file
log_file="/tmp/filter-tmux-copymode.log"

# Clear the log file before appending to it
echo "" > $log_file

# Append date of execution to log file
echo "---- New Run ----" >> $log_file
echo "Execution Date: $(date)" >> $log_file

# Initialize full_modified_text variable
full_modified_text=""

# Read from standard input
while IFS= read -r line || [[ -n "$line" ]]; do
    # Log the original line
    echo "Original: $line" >> $log_file

    # Initialize modified_line as the original line
    modified_line="$line"

    # Check if line contains '-->'
    if [[ $line == *'-->'* ]]; then
        # Remove everything up to and including the '-->'
        modified_line=$(echo "$line" | sed 's/^.*-->//')
        echo "Matched: $line" >> $log_file
    elif [[ $line =~ PS\ .*\> ]]; then
        # Remove everything up to and including the PowerShell prompt
        modified_line=$(echo "$line" | sed 's/^PS .*>//')
    fi

    # Remove any leading white spaces from modified_line
    modified_line=$(echo "$modified_line" | sed -e 's/^[[:space:]]*//')

    # Log the modified line
    echo "Modified: $modified_line" >> $log_file

    # Append the modified line and a newline to full_modified_text, only if modified_line is not empty
    if [[ -n $modified_line ]]; then
        full_modified_text+="$modified_line"$'\n'
    fi
done

# Remove trailing newline from full_modified_text
full_modified_text=$(echo -n "$full_modified_text" | head -c -1)

# Log the full modified text
echo "Full Modified Text: $full_modified_text" >> $log_file

# Set the modified text as the new clipboard content
echo -n "$full_modified_text" | clip.exe

