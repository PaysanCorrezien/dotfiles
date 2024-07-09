# # Copy current prompt to clipboard with ctrl A
# # if [[ -n $DISPLAY ]]; then
# #     copy_line_to_x_clipboard() {
# #         echo -n $BUFFER | xclip -selection clipboard
# #         zle reset-prompt
# #     }
# #     zle -N copy_line_to_x_clipboard
# #     bindkey '^A' copy_line_to_x_clipboard
# # fi
# #
# # Move to the end of the current/next word
# bindkey '^F' forward-word

# # Move to the start of the current/previous word
# bindkey '^B' backward-word

# # Delete the word before the cursor
# bindkey '^W' backward-kill-word

# # Clear the current line
# bindkey '^U' kill-whole-line

# # Delete the word after the cursor
# bindkey '^D' kill-word

# # bindkey '^T' 
# # FZF search

# # bindkey R
# # fzf history
# #
# # bindkey C
# # cancel action 
# #
# # CTRL S not available block screen

# # Undo the last editing command
# bindkey '^Z' undo

# # Redo the last undone editing command (might depend on your Zsh version/configuration)
# bindkey '^Y' redo

# bindkey '^O' down-line-or-history
# bindkey '^P' up-line-or-history

# # Move to the end of the line
# bindkey '^E' end-of-line


# # TODO: 
# autoload -Uz push-line
# zle -N push-line
# bindkey '^G' push-line

# bindkey '^_' beginning-of-line
# bindkey '^A' beginning-of-line
# Updated Key Bindings

# # Unbind Ctrl+I (Tab)
# bindkey -r '^I'
# Move to the beginning of the line
# bindkey '^I' beginning-of-line
#
# bindkey '^N' edit-command-line
# Undo the last editing command
bindkey '^U' undo

# Open line in editor
# #  Best Shortcut EDIT IN NEOVIM current line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line

# Up in history
bindkey '^K' up-line-or-history

# Down in history
bindkey '^J' down-line-or-history

# Clear the current line
bindkey '^D' kill-whole-line

# Move to the start of the previous word (originally on 'H')
bindkey '^B' backward-word

# Move to the end of the next word (originally on 'L')
bindkey '^F' forward-word

# Delete the word after the cursor
bindkey '^W' kill-word

# Delete the word before the cursor
bindkey '^X' backward-kill-word

# Redo the last undone editing command
bindkey '^Y' redo

# List choices for completion based on current input
bindkey '^O' beginning-of-line

# work but we cant do anything with it
# select-whole-line() {
#   zle beginning-of-line
#   zle set-mark-command
#   zle end-of-line
# }
# zle -N select-whole-line
# bindkey '^A' select-whole-line
#
