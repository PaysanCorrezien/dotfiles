
alias v="nvim"
alias n="nvim"
# alias icat="kitty +kitten icat"
# alias obsidian='sudo -- sh -c ~/.local/bin/Obsidian.AppImage'
# alias obsidian="/home/dylan/share/applications/Obsidian.AppImage"
alias ai="sgpt --repl temp --shell"
# alias ll='ls -l'
# alias la='ls -A'
# alias l='ls -CF'
alias md="mkdir"
alias mcd='f() { mkdir -p "$1" && cd "$1"; unset -f f; }; f'
# alias cat='bat'
# alias h='lvim $HISTFILE'

# general use
# alias l='exa -lbF --git --icons'                                               # list, size, type, git
# alias ll='exa -lbGF --git --icons'                                             # long list
# alias ls='exa -lbGF --git --sort=modified --icons'                            # long list, modified date sort
alias ls='lsd'

# alias llm='exa -lbGF --git --sort=modified --icons'                            # long list, modified date sort
# alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale --icons'  # all list
# alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --icons' # all + extended list
alias s='sudo'

# speciality views
alias lS='exa -1 --icons'			                                                  # one column, just names
alias lt='exa --tree --level=2 --icons'                                         # tree
# apt part
alias apti="sudo apt install"
alias apts="apt search"
alias aptr="sudo apt remove"
alias aptq="apt show"
alias aptu="sudo apt update && sudo apt upgrade"

alias aran="autorandr -l"
# git 
alias ga="git add"
alias gc="git commit -m"
alias gl="git pull --rebase --autostash"
alias gp="git push"
alias gss="git status -s"
alias gbrr="git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format='%(refname:short)'"
alias gcm='git checkout $(git_main_branch)'
alias gcma="git commit --amend -m"
alias gcman="git commit --amend --no-edit"
alias gcmn="git add . && git commit --amend --no-edit"
alias gdh="git diff HEAD"
alias gg="lazygit"
alias ghpc="gh pr create"
alias ghrc="gh repo clone"
alias ghrd="gh repo edit -d"
alias ghrh="gh repo edit -h"
alias ghrr="gh repo rename"
alias ghrs="gh release create"
alias ghrt="gh repo edit --add-topic "
alias ghrv="gh repo edit --visibility "
alias gmv="git mv"
alias gmx="git merge -X ours"
alias gsv="git status -v"
alias gtop='cd "$(git rev-parse --show-toplevel)"'
alias grep="grep --color=auto"
# kitty
# alias icat="kitty +kitten icat"
# alias s="kitty +kitten ssh"

alias q="exit"
alias rm="rm -irv"
alias rmf="rm -rf"

alias x="chmod +x"

# systemd
alias sysd="sudo systemctl disable"
alias syse="sudo systemctl enable"
alias sysr="sudo systemctl restart"
alias syss="systemctl status"
alias systa="sudo systemctl start"
alias systo="sudo systemctl stop"
# tmux
# alias tmux="tmux -u"
# alias tmuxm="tmux new-session \; split-window -h \; split-window -v \; attach"
alias t="todoist"
alias ta="todoist add"

alias dk="lazydocker"

# BUG:
alias sync='chezmoi apply && tmux source-file ~/.tmux.conf && source ~/.zshrc'

alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
# chezmoi commands
alias cmu='chezmoi update && chezmoi diff'
alias cma='chezmoi add --apply'
alias cmp='chezmoi apply'
alias cml='chezmoi managed'
alias cme='chezmoi edit'
alias cmi='chezmoi init'

