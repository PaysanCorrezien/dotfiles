# # Check if on WSL
if [ -f /etc/wsl.conf ]; then
  # echo "This is WSL"

# Start ssh-agent
# if [ -z "$SSH_AUTH_SOCK" ]; then
#   eval "$(ssh-agent -s >/dev/null 2>&1)"
# fi

#Mount network drive 
if [ -f ~/networkdrive.sh ]; then
  sudo ~/networkdrive.sh
fi

# keepass windows key authen without password
# export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
# ss -a | grep -q $SSH_AUTH_SOCK
# if [ $? -ne 0 ]; then
#     rm -f $SSH_AUTH_SOCK
#     (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$HOME/npiperelay/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
# fi

#NOTE: SSH ON WSL with keepassxc
# Path to npiperelay executable
# export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
# NPIPERELAY_PATH="$HOME/npiperelay/npiperelay.exe"
# # Check if npiperelay and socat are available
# if [[ -f "$NPIPERELAY_PATH" ]] && command -v socat > /dev/null; then
#     rm -f /home/dylan/.ssh/agent.sock 
#     # Run the command to set up the SSH agent
#     # (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$NPIPERELAY_PATH -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
#     # Debug version with log
#     (setsid socat -d -d UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$HOME/npiperelay/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/tmp/socat.log 2>&1
# fi

fi
