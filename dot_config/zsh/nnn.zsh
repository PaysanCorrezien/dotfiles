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
export NNN_PLUG='f:finder;o:fzopen;p:preview-tabbed;P:preview-tui;d:diffs;i:imgview;z:autojump;m:~/.config/nnn/plugins/fzf_context_menu.sh'
export NNN_FIFO=/tmp/nnn.fifo
# H for hidden, d for detail 
export NNN_OPTS="Hd"
export NNN_ICONLOOKUP="1"
export NNN_BMS="d:/mnt/c/Users/dylan/Downloads/;t:/mnt/c/temp/;p:/mnt/c/Users/dylan/Documents/Projet/Work/Projet/;U:/mnt/c/userconfig/"

BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"


# this not needed , made change on script itself
# export NNN_PAGER="batcat"
# export NNN_BATSTYLE="header,grid,numbers"
# export NNN_BATTHEME="TwoDark"

