#Fichier export 
export PATH=$HOME/.config/rofi/bin:$PATH
export PATH=$HOME/.config/rofi/applets/bin:$PATH
export PATH=$HOME/.config/rofi/scripts:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="/snap/bin:$PATH"

[[ $TMUX != "" ]] && export TERM="screen-256color"
export EDITOR="lvim"
export PATH="$PATH:/var/lib/snapd/desktop/applications"
export PATH="$PATH:$HOME/bin/"
export PATH="$PATH:/usr/bin/"
export PATH="$PATH:$HOME/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls"
# tmuxifier plugins setup
export PATH="$PATH:$HOME/.tmux/plugins/tmuxifier/bin"
export TMUXIFIER_LAYOUT_PATH="$HOME/.tmux/plugins/tmuxifier/layouts"

source /usr/share/doc/fzf/examples/key-bindings.zsh
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
  --preview 'batcat -n --color=always {}'"
  # configure default command
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
# export FZF_DEFAULT_COMMAND="rg --files --follow --no-ignore-vcs --hidden -g '!{**/node_modules/*,**/.git/*,**/snap/*,**/.icons/*,**/.themes/*}'"
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# node version manager
  export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
