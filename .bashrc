# z.bashrc is used to setup basic environment settings and load other files

# Check for an interactive session
[ -z "$PS1" ] && return

export EDITOR=vim
export VISUAL=vim

if [ -n "$DISPLAY" ]; then
     BROWSER=chromium-browser
fi

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

shopt -s extglob

# load all my bash functions and aliases
if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi
