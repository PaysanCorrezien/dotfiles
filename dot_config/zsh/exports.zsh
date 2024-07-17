#Fichier export
export PATH=$HOME/.config/rofi/bin:$PATH
export PATH=$HOME/.config/rofi/applets/bin:$PATH
export PATH=$HOME/.config/rofi/scripts:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="/snap/bin:$PATH"

export TERM=xterm-256color
export COLORTERM=truecolor
# [[ $TMUX != "" ]] && export TERM="screen-256color"
export EDITOR="nvim"
export PATH="$PATH:/var/lib/snapd/desktop/applications"
export PATH="$PATH:$HOME/bin/"
export PATH="$PATH:/usr/bin/"
export PATH="$PATH:/usr/local/nvim-linux64/bin"
export PATH="$PATH:$HOME/.config/scripts/"
export PATH="$PATH:$HOME/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls"
# tmuxifier plugins setup
# export PATH="$PATH:$HOME/.tmux/plugins/tmuxifier/bin"
# export TMUXIFIER_LAYOUT_PATH="$HOME/.tmux/plugins/tmuxifier/layouts"

# Rust environment setup
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"
export PATH="$CARGO_HOME/bin:$PATH"

# enable fzf ctrl R ctrl T etc
# source /usr/share/doc/fzf/examples/key-bindings.zsh

export FZF_DEFAULT_OPTS="
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'"
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
# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv virtualenv-init -)"
# eval "$(pyenv init -)"

# NOTE: Open pwsh process on windows from withing tmux in wsl 
# p() {
# # Full path to PowerShell executable
# tmux new-window -n powershell "cmd.exe /K \\\\\\\\wsl.localhost\\\\Debian\\\\home\\\\dylan\\\\.config\\\\windows\\\\launchpwsh.bat"
# }

function y() {
	tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

if ! pgrep -u "$USER" gpg-agent > /dev/null; then
  eval "$(gpg-agent --daemon)"
fi

export GPG_TTY=$(tty)

# Check if running inside WSL (Windows Subsystem for Linux)
if grep -qEi "(Microsoft|WSL)" /proc/version &>/dev/null; then
    echo "Setting up for WSL environment..."

    # Set DISPLAY variable to use the host Windows IP
    # export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0
    # FIXME: done because i hardocst router nameserver in resolv.conf
    export DISPLAY=$(hostname -I | awk '{print $1}'):0

    # Force XFCE and other applications to use X11 instead of Wayland
    export GDK_BACKEND=x11

fi

