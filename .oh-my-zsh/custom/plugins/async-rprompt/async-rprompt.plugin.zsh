## Async RPROMPT: http://www.anishathalye.com/2015/02/07/an-asynchronous-shell-prompt/

# don't define functions if $RPROMPT_MODE isn't 2 and async-rprompt plugin is loaded
if [[ "${RPROMPT_MODE}" != 2 ]]; then
    return
fi

function RCMD() {
    echo $ASYNC_RPROMPT
}

RPROMPT='' # no initial prompt, set dynamically

ASYNC_PROC=0
function precmd() {
    function async() {
        # save to temp file
        printf "%s" "$(RCMD)" > "${HOME}/.zsh_tmp_prompt"

        # signal parent
        kill -s USR1 $$
    }

    # do not clear RPROMPT, let it persist

    # kill child if necessary
    if [[ "${ASYNC_PROC}" != 0 ]]; then
        kill -s HUP $ASYNC_PROC >/dev/null 2>&1 || :
    fi

    # start background computation
    async &!
    ASYNC_PROC=$!
}

function TRAPUSR1() {
    # read from temp file
    RPROMPT="$(cat ${HOME}/.zsh_tmp_prompt)"

    # reset proc number
    ASYNC_PROC=0

    # redisplay
    zle && zle reset-prompt
}
