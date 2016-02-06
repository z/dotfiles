# Based on Michele Bologna's theme
# http://michelebologna.net
#
# This a theme for oh-my-zsh. Features a colored prompt with:
# * username@host: [jobs] [git] workdir % 
# * hostname color is based on hostname characters. When using as root, the 
# prompt shows only the hostname in red color.
# * [jobs], if applicable, counts the number of suspended jobs tty
# * [git], if applicable, represents the status of your git repo (more on that
# later)
# * '%' prompt will be green if last command return value is 0, yellow otherwise.
# 
# git prompt is inspired by official git contrib prompt: 
# https://github.com/git/git/tree/master/contrib/completion/git-prompt.sh
# and it adds:
# * the current branch
# * '%' if there are untracked files
# * '$' if there are stashed changes
# * '*' if there are modified files
# * '+' if there are added files
# * '<' if local repo is behind remote repo
# * '>' if local repo is ahead remote repo
# * '=' if local repo is equal to remote repo (in sync)
# * '<>' if local repo is diverged
#
# RECOMMENDS: async-rprompt
# Configure your RPROMPT_MODE variable in your ~/.zshrc
# THREE RPROMPT MODES:
# 0 - no right prompt, all git info in the left
# 1 - right prompt with git info, not async
# 2 - right prompt with git info, async
#
# e.g. RPROMPT_MODE=2

# Support 256 colors
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'
#eval $(dircolors -b)

local green="%{$fg[green]%}"
local red="%{$fg[red]%}"
local cyan="%{$fg[cyan]%}"
local yellow="%{$fg[yellow]%}"
local blue="%{$fg[blue]%}"
local magenta="%{$fg[magenta]%}"
local white="%{$fg[white]%}"
local greenb="%{$fg_bold[green]%}"
local redb="%{$fg_bold[red]%}"
local cyanb="%{$fg_bold[cyan]%}"
local yellowb="%{$fg_bold[yellow]%}"
local blueb="%{$fg_bold[blue]%}"
local magentab="%{$fg_bold[magenta]%}"
local whiteb="%{$fg_bold[white]%}"
local reset="%{$reset_color%}"

local -a color_array
color_array=($greenb $redb $cyanb $yellowb $blueb $magentab $whiteb)

local username_normal_color=$greenb
local username_root_color=$redb
local hostname_root_color=$redb

# calculating hostname color with hostname characters
for i in `hostname`; local hostname_normal_color=$color_array[$[((#i))%7+1]]
local -a hostname_color
hostname_color=%(!.$hostname_root_color.$hostname_normal_color)

local current_dir_color=$blueb
local username_command="%n"
local hostname_command="%m"
local current_dir="%~"

local username_output="%(!..$username_normal_color$username_command$cyan@)"
local hostname_output="$hostname_color$hostname_command$reset"
local current_dir_output="$current_dir_color$current_dir$reset"
local jobs_bg="${red}[${redb}fg: %j$reset${red}]$reset"
local last_command_output="%(?.%(!.$redb.$greenb).$yellowb)"

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=blue,fg=white,bold'

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNTRACKED="$blueb%%"
ZSH_THEME_GIT_PROMPT_MODIFIED="$redb*"
ZSH_THEME_GIT_PROMPT_ADDED="$greenb+"
ZSH_THEME_GIT_PROMPT_STASHED="$blueb$"
ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE="$greenb="
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="$yellowb>"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="$yellowb<"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="$redb<>"

PROMPT='$username_output$hostname_output:$current_dir_output%1(j. $jobs_bg.)'
GIT_PROMPT='$(out=$(git_prompt_info)$(git_prompt_status)$(git_remote_status);if [[ -n $out ]]; then printf %s " $whiteb($reset$yellow$out$whiteb)$reset";fi)'

if [[ "${RPROMPT_MODE}" == 2 ]]; then
    # ASYNC Right-hand prompt
    ASYNC_RPROMPT="$GIT_PROMPT"
elif [[ "${RPROMPT_MODE}" == 1 ]]; then
    RPROMPT="$GIT_PROMPT"
else
    PROMPT+="$GIT_PROMPT"
fi

PROMPT+=" $last_command_output%#$reset "

# Autosuggest -- requires in order: zsh-syntax-highlighting zsh-autosuggestions
if [[ "${AUTOSUGGESTION}" == "true" ]]; then
    zle-line-init() {
        zle autosuggest-start
        echoti smkx
    }
    zle -N zle-line-init

    AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=008'
    AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=1
fi

# Completions
if [[ "${ENHANCED_COMPLETION}" == "true" ]]; then
    # Faster! (?)
    zstyle ':completion::complete:*' use-cache 1

    # generate descriptions with magic.
    zstyle ':completion:*' auto-description 'specify: %d'

    # man page completion (command params)
    zstyle ':completion:*:manuals'    separate-sections true
    zstyle ':completion:*:manuals.*'  insert-sections   true
    zstyle ':completion:*:man:*'      menu yes select

    # colored tab complete
    zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")';


fi

