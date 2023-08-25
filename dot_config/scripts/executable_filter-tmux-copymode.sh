#!/bin/bash

# Read from standard input
while IFS= read -r line; do
  # Initialize modified_line as the original line
  modified_line="$line"
  
  # Check if line contains '-->'
  if [[ $line == *'-->'* ]]; then
    # Remove everything up to and including the '-->'
    modified_line=$(echo "$line" | sed 's/^.*-->//')
  fi
  
  # Check if line contains PowerShell prompt pattern "PS .*>"
  if [[ $line =~ PS\ .*\> ]]; then
    # Remove everything up to and including the PowerShell prompt
    modified_line=$(echo "$line" | sed 's/^PS .*>//')
  fi

  # Write the modified line to stdout
  echo "$modified_line"
done

