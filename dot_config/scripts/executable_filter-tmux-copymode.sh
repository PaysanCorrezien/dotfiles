#!/bin/bash

# Log file
log_file="/tmp/filter-tmux-copymode.log"

# Initialize log file
echo "---- New Run ----" >> $log_file

# Read from standard input
while IFS= read -r line || [[ -n "$line" ]]; do
  # Initialize modified_line as the original line
  modified_line="$line"
  
  # Check if line contains '-->'
  if [[ $line == *'-->'* ]]; then
    # Remove everything up to and including the '-->'
    modified_line=$(echo "$line" | sed 's/^.*-->//')
  elif [[ $line =~ PS\ .*\> ]]; then
    # Remove everything up to and including the PowerShell prompt
    modified_line=$(echo "$line" | sed 's/^PS .*>//')
  fi

  # Write the modified line to stdout and flush stdout immediately
  echo -n "$modified_line" | awk '{ print $0; fflush(); }'

  # Append a newline
  echo ""
done
