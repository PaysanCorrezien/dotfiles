# # Check if on WSL
if [ -f /etc/wsl.conf ]; then
  # echo "This is WSL"

# Start ssh-agent
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s >/dev/null 2>&1)"
fi

#Mount network drive 
if [ -f ~/networkdrive.sh ]; then
    ~/networkdrive.sh
fi

# keepass windows key authen without password
export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
ss -a | grep -q $SSH_AUTH_SOCK
if [ $? -ne 0 ]; then
    rm -f $SSH_AUTH_SOCK
    (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$HOME/npiperelay/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
fi

fi
