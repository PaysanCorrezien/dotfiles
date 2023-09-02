# # Check if on WSL
if [ -f /etc/wsl.conf ]; then
  # echo "This is WSL"

# Start ssh-agent
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
  ssh-add /home/dylan/.ssh/github_rsa
fi

# Start gpg-agent
if [ -z "$GPG_AGENT_INFO" ]; then
  eval "$(gpg-agent --daemon)"
fi
#Mount network drive 

if [ -f ~/networkdrive.sh ]; then
    ~/networkdrive.sh
fi

fi
