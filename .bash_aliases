# Reload .bashrc
alias bashrc='clear; . $HOME/.bashrc'


## Vars
DISTRO='unknown'
DISTRO=$(lsb_release -i | awk -F ":" '{ print $2 }' | sed -e 's/^[ \t]*//')

# define colors
Black='\e[0;30m'    # Black / Regular
Red='\e[0;31m'      # Red
Green='\e[0;32m'    # Green
Yellow='\e[0;33m'   # Yellow
Blue='\e[0;34m'     # Blue
Purple='\e[0;35m'   # Purple
Cyan='\e[0;36m'     # Cyan
White='\e[0;37m'    # White

BBlack='\e[1;30m'   # BBlack / Bold
BRed='\e[1;31m'     # BRed
BGreen='\e[1;32m'   # BGreen
BYellow='\e[1;33m'  # BYellow
BBlue='\e[1;34m'    # BBlue
BPurple='\e[1;35m'  # BPurple
BCyan='\e[1;36m'    # BCyan
BWhite='\e[1;37m'   # BWhite

UBlack='\e[4;30m'   # UBlack / Underline
URed='\e[4;31m'     # URed
UGreen='\e[4;32m'   # UGreen
UYellow='\e[4;33m'  # UYellow
UBlue='\e[4;34m'    # UBlue
UPurple='\e[4;35m'  # UPurple
UCyan='\e[4;36m'    # UCyan
UWhite='\e[4;37m'   # UWhite

BGBlack='\e[40m'    # BGBlack / Background
BGRed='\e[41m'      # BGRed
BGGeeen='\e[42m'    # BGGreen
BGYellow='\e[43m'   # BGYellow
BGBlue='\e[44m'     # BGBlue
BGPurple='\e[45m'   # BGPurple
BGCyan='\e[46m'     # BGCyan
BGWhite='\e[47m'    # BGWhite

NC='\e[0m'          # Text Reset / No Color


## Aliases

# yay colors
alias tmux="tmux -2" # vim full color
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=always'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'


## Functions
colortest() { for c in {,B,U,BG}{Black,Red,Green,Yellow,Blue,Purple,Cyan,White}; do echo -e ${!RWhite}${!c}$c${NC}; done; echo -e "${NC}"; }

# simple apache log view
logview() {
    awk '{ print $1 " " $2 " " $3 " " $4 " " $5 " " $6 " " $7 " " $8 }'
}

# make directory and move into it
mkcdr() { mkdir -p $1 && cd $1; }

# unix times
unix2date() {
    date -d @$1 +'%Y-%m-%d %H:%M:%S'
}
date2unix() {
    date -d "$1" "+%s"
}

# move "type"
# touch file.{jpg,bmp,gif} && ls
# mvt "file.jpg file.bmp file.gif" png && ls
mvt() { for f in $1; do mv $f ${f%.*}.$2; done }
findtypes() { find . -type f | awk -F'.' '{print $NF}' | sort| uniq -c | sort -g; }

# create backup
backup() { cp -i $1{,.bak.$(date +%Y%m%d%H%M%S)}; }

# math
? () { echo "$*" | bc -l; }

set_titlebar() {
    case $TERM in
        *xterm*|ansi|rxvt)
            printf "\033]0;%s\007" "$*"
            ;;
    esac
}

# git
get_dir() {
    printf "%s" $(pwd | sed "s:$HOME:~:")
}
get_sha() {
    git rev-parse --short HEAD 2>/dev/null
}

# svn
svn_addr() { for file in $(svn status |grep ^\? |awk '{ print $2 }'); do svn add $file; done; }
svn_rmr() { for file in $(svn status |grep ^\! |awk '{ print $2 }'); do svn rm $file; done; }
svn_cleanup() { for file in $(find -name .svn); do rm -rf $file; done; }

# extract
extract() {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xjf $1 ;;
			*.tar.gz)    tar xzf $1 ;;
			*.bz2)       bunzip2 $1 ;;
			*.rar)       rar x $1 ;;
			*.gz)        gunzip $1 ;;
			*.tar)       tar xf $1 ;;
			*.tbz2)      tar xjf $1 ;;
			*.tgz)       tar xzf $1 ;;
			*.zip)       unzip $1 ;;
			*.Z)         uncompress $1 ;;
			*.7z)        7z x $1 ;;
			*)           echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
        echo "'$1' is not a valid file"
	fi
}

# tar
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# add clock
addclock() { while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done & }
showkeys() { echo -e "Terminal shortcut keys\n" && sed -e 's/\^/Ctrl+/g;s/M-/Shift+/g' <(stty -a 2>&1| sed -e 's/;/\n/g' | grep "\^" | tr -d ' '); }

## Distro specific
if [[ "$DISTRO" == "Ubuntu" || "$DISTRO" == "LinuxMint" ]]; then
    PS1="${debian_chroot:+($debian_chroot)}\[${BWhite}\]\u\[${NC}\]\[${Yellow}\]@\[${White}\]\h\[${NC}\]:\[${BBlue}\]\w\[${NC}\]\[${White}\]$ \[${NC}\]"
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_DESCRIBE_STYLE="branch"
    PROMPT_COMMAND='__git_ps1 "${debian_chroot:+($debian_chroot)}\[${BWhite}\]\u\[${NC}\]\[${Yellow}\]@\[${White}\]\h\[${NC}\]:\[${BBlue}\]\w\[${NC}\]" "\[${White}\]\\\$ \[${NC}\]" " (%s $(get_sha))"; set_titlebar "$USER@${HOSTNAME%%.*} $(get_dir)"'

    # functions
    cowtune() { fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1); }

    # aliases
    alias apti='sudo apt-get install'
    alias apts='apt-cache search'
    alias nemo='caja'
else
    PS1="\[\e[1;34m\]\u\[\e[0;36m\]@\[\e[1;34m\]\h\[\e[0m\]:\[\e[0;34m\]\w\[\e[0;36m\]$ \[\e[0m\]"
fi

if [ -f $HOME/.private_aliases ]; then
    . $HOME/.private_aliases
fi
