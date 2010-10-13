# reload .bashrc
alias bashrc='clear; . $HOME/.bashrc'

# define colors
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NONE='\e[0m' # No Color / No Bold
BOLD='\e[1m' # Bold
UNDERLINE='\e[1m' # Bold


#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;37m\]\u\[\033[00;33m\]@\[\033[00;37m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1="${debian_chroot:+($debian_chroot)}${BOLD}${WHITE}\u${NONE}${BROWN}@${LIGHTGRAY}\h${NONE}:${LIGHTBLUE}\w${NONE}$ "

# directory navigation
alias explore='nautilus --browser .'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# make directory and move into it
mkcdr () { mkdir -p -v $1 && cd $1; }

# math
? () { python -c "from math import *; print $1"; }

# svn
svn_addr () { for file in $(svn status |grep ^\? |awk '{ print $2 }'); do svn add $file; done; }
svn_rmr () { for file in $(svn status |grep ^\! |awk '{ print $2 }'); do svn rm $file; done; }
alias svn_cleanup='for file in $(find -name .svn); do rm -rf $file; done'

# extract
extract () {
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
mktar () { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz () { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz () { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }
