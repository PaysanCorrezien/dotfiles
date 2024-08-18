#NOTE: top tier aliases
alias q="exit"
alias rm="rm -irv"
alias rmf="rm -rf"
alias x="chmod +x"
alias s='sudo'
alias n="nvim"
alias mcd='f() { mkdir -p "$1" && cd "$1"; unset -f f; }; f'
alias l='lsd -l --size default --classify --icon auto'
alias lg="lazygit"
alias dk="lazydocker"


alias md="mkdir -p"
# general use
alias ll='lsd -l --classify --icon auto'
alias ls='lsd -l --classify --icon auto --sort time'
alias lS='lsd -1 --icon=never'			                                                  # one column, just names
alias lt='lsd --tree --depth=2 --icon=auto'                                         # tree

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
# alias t="todoist"
# alias ta="todoist add"


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

alias ssh-with-passwd='ssh -o IdentitiesOnly=yes -o PreferredAuthentications=password -o PubkeyAuthentication=no'
alias scp-with-passwd='scp -o IdentitiesOnly=yes -o PreferredAuthentications=password -o PubkeyAuthentication=no'
