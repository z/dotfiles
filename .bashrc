
# Check for an interactive session
[ -z "$PS1" ] && return

export EDITOR=vim
export VISUAL=vim

if [ -n "$DISPLAY" ]; then
     BROWSER=chromium
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/venv/venv ]; then
    . ~/venv/venv
fi
