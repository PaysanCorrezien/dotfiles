n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn -PP "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
  }
nnn_cd()                                                                                                   
{
    if ! [ -z "$NNN_PIPE" ]; then
        printf "%s\0" "0c${PWD}" > "${NNN_PIPE}" !&
    fi  
}
export NNN_PLUG='f:finder;o:fzopen;P:preview-tui;d:diffs;i:imgview;z:autojump;m:wsl_contextmenu;'
export NNN_FIFO=/tmp/nnn.fifo
# H for hidden, d for detail 
export NNN_OPTS="Hd"
export NNN_ICONLOOKUP="1"
export NNN_BMS_PERSONAL="d:/mnt/c/Users/dylan/Downloads/;t:/mnt/c/temp/;p:/mnt/c/Users/dylan/Documents/Projet/Work/Projet/;U:/mnt/c/userconfig/;o:/mnt/c/Users/dylan/Documents/Obsidian Vault/;c:~/.config/"

BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

# Check the value of the SITUATION environment variable and set NNN_BMS accordingly
# Allow to use different bookmark depending on workstation or home
# NOTE: on secret.zsh the following need to be set :
# export NNN_BMS_WORK=""
# export SITUATION="work" # or personnal
if [[ "$SITUATION" == "work" ]]; then
  if [[ -n "$NNN_BMS_WORK" ]]; then
    export NNN_BMS=$NNN_BMS_WORK
  else
    echo "NNN_BMS_WORK is not set."
  fi
elif [[ "$SITUATION" == "personal" ]]; then
  if [[ -n "$NNN_BMS_PERSONAL" ]]; then
    export NNN_BMS=$NNN_BMS_PERSONAL
  else
    echo "NNN_BMS_PERSONAL is not set."
  fi
else
  echo "SITUATION variable is not set to 'work' or 'personal'. NNN_BMS will not be updated."
fi



# Personal-related drive map
declare -A drive_map_personal
drive_map_personal["C:"]="/mnt/c"
drive_map_personal["D:"]="/mnt/d"
#Serialize array as local env variable
export DRIVE_MAP_PERSONAL_STR=$(declare -p drive_map_personal)

