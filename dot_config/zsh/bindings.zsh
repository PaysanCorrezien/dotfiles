# Ctrl + E: Move to the end of the current/next word
bindkey '^E' forward-word

# Ctrl + B: Move to the start of the current/previous word
bindkey '^B' backward-word

# # TODO : make those work
# # Change to a different combination if Ctrl + A doesn't work
# bindkey '^[a' beginning-of-line  # Ctrl + Shift + A

# # Alternative for moving to the end of the line if Ctrl + I doesn't work
# # Change to a different combination if needed
# bindkey '^[I' end-of-line  # Ctrl + Shift + I

# Additional Bindings

# Ctrl + W: Delete the word before the cursor
bindkey '^W' backward-kill-word

# Ctrl + U: Clear the current line
bindkey '^U' kill-whole-line

