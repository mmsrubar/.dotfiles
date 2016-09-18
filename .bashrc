#!/bin/sh

# use vim as VISUAL editor
export VISUAL=vim
export SVN_EDITOR=gvim

source ~/.git-completion.bash

# save path on cd
function cd {
    builtin cd $@
    pwd > ~/.last_dir
}

# restore last saved path
if [ -f ~/.last_dir ]
    then cd `cat ~/.last_dir`
fi

# More Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underlineo

export PERL_LOCAL_LIB_ROOT="/home/hitxh/perl5";
export PERL_MB_OPT="--install_base /home/hitxh/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/hitxh/perl5";
export PERL5LIB="/home/hitxh/perl5/lib/perl5/x86_64-linux-thread-multi:/home/hitxh/perl5/lib/perl5";
export PATH="/home/hitxh/perl5/bin:$PATH:$HOME/bin:$HOME/work/bin";
export GREP_COLOR="1;31"
export LD_LIBRARY_PATH=/usr/local/lib/

WWW="www.stud.fit.vutbr.cz/~xsruba03"

# for 256b term :)
# ncurses-term requires
if [ -e /usr/share/terminfo/x/xterm-256color ] && [ "$COLORTERM" == "xfce4-terminal" ]; then
    export TERM=xterm-256color
fi

# bash completion after sudo
complete -cf sudo

# vi-like mode for bash
set -o vi

# ^l clear screen
bind -m vi-insert "\C-l":clear-screen

# Check for an interactive session
[ -z "$PS1" ] && return

# color ls
if [ -f ~/.dircolors ]; then
	eval $(dircolors -b ~/.dircolors)
fi

# Aliases
alias vi="vim"
alias pwd="pwd -P"							#avoid all symlinks
alias cdd="cd .."								#upper directory
alias cddd="cdd"								#more upper
alias cdddd="cddd"							#the upperest :-)
alias df="df -h"								#human readable
alias rm="rm -irv"							#verbose + recursive + ask before you do
alias cp="cp -iv"								#verbose + ask before you do
alias du="du -h"								#human readable
alias l="ls --color=auto -lph"	#set colors from ~/.dircolors
alias l.="ls -lah --color=auto"
alias mkdir="mkdir -p"		 
alias unrar="unrar e"
alias bunzip2="bunzip2 -kv"
alias bzip2="bzip2 -kv"
alias p1="ping www.stud.fit.vutbr.cz"
alias toff="synclient TouchPadOff=1"
alias ton="synclient TouchPadOff=0"
alias grep="grep --color=auto"
alias valgrind="valgrind --track-fds=yes"

#if [ "`id -u`" == "0" ]; then
#	export PS1='\[\e[0;31m\]\[\e[1;32m\]\u\[\e[0;39m\]:\[\e[1;33m\]\W\[\e[0;39m\]\[\e[1;35m\]\[\e[0;39m\] \[\e[1;37m\]\[\e[0;39m\]\# '
#elif [ "`id -un`" == "$USER" ]; then
#	export PS1='\[\e[0;31m\]:\[\e[1;33m\]\W\[\e[0;39m\]\[\e[1;35m\]\[\e[0;39m\] \[\e[1;37m\]\[\e[0;39m\]\$ '
#fi
#
## \[\e[1;31m\] color
## I'm root
#if [ "`id -u`" == "mmsrubar" ]; then
#	# disable pc speaker in X 
#	xset b off
#	export PS1="\[\e[0;31m\]\u\[\e[0;0m\]@\[\e[0m\]\[\e[0;32m\]\h\[\e[0m\]\[\e[0m\]:\W\[\e[0;31m\]#\[\e[0m\] "
## vut servers
#elif [ `id -u` == "9288" ]; then
#	export PS1="\[\e[1;33m\]\h\[\e[0m\]:\W$ "
#else
#	export PS1="\[\e[1;32m\]\u\[\e[0m\]:\W$ "
#fi

function _update_ps1() {
    PS1="$(~/.powerline-shell.py $? 2> /dev/null)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# useful functions
ex() {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)	tar xvf 	$1;;
			*.tar.gz)    tar xvf 	$1;;
			*.bz2)       bunzip2 	$1;;
			*.rar)       unrar -e 	$1;;
			*.gz)        gunzip 	$1;;
			*.tar)       tar xvf 	$1;;
			*.tbz2)      tar xvf 	$1;;
			*.tgz)       tar xvf 	$1;;
			*.zip)       unzip 		$1;;
			*.Z)         uncompress $1;;
			*.7z)        7z x 		$1;;
			*)           echo "$1 cannot be extracted via >extract<";;
		esac
	else
		echo "$1 is not a valid file"
	fi
}
