#!/bin/bash

set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
shopt -s autocd

export PATH="$HOME/.local/bin:$PATH"
export LS_COLORS="fi=01;37:di=01;34:ex=01;32:ln=37\
:or=01;30:mi=00:mh=31\
:pi=33:so=43;30:do=35\
:bd=35;01:cd=35\
:su=37;41:sg=30;43:ca=30;41\
:tw=07;34:ow=30;44:st=30;44"
export EDITOR=nvim
export VISUAL="$EDITOR"
export LESSHISTFILE=-
export HISTFILE="$HOME/.dotfiles/bash/.bash_history"
export BC_ENV_ARGS="$HOME/.dotfiles/.bc"
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
export SHELL_SESSIONS_DISABLE=1
export PS1="\e[1;31m[\e[1;33m\u\e[1;37m@\e[1;34m\h \e[1;35m\w\e[1;31m]\e[m\$ \e[0m"

alias 'rm'='echo "This is not the command you are looking for."; false'
alias 'mv'='mv -i'
alias 'rg'='rg --smart-case'
alias 'grep'='grep --color=auto'
alias 'd'='del'
alias 'la'='ls -lAhG'
alias 'lad'='ls -lAhGd */'
alias 'vim'='/usr/local/bin/nvim'
alias 'scim'='sc-im'
alias 'mkdir'='mkdir -pv'
alias 'md5sum'='md5 -r'
alias 'pd'='pushd'
alias 'ppd'='popd'
alias 'dirs'='dirs -v'
alias 'tmm'='tmux new -s main -n main'
alias 'tml'='tmux ls'
alias 'tma'='tmux attach -t'
alias 'tmk'='tmux kill-session'
alias 'youtube-audio'='youtube-dl -f bestaudio -o "~/Desktop/%(creator)s-%(title)s.mp3"'

source "$HOME/.dotfiles/.fzf.bash"
source "$HOME/.dotfiles/bash/up.sh"
source "$HOME/.dotfiles/bash/volume.sh"
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS='--layout=reverse --info=inline --extended'
export DEL_DIR="$HOME/.Trash"

encrypt () { openssl enc -aes-256-cbc -a -salt -e -in "$1" ; } # -out "$2"
decrypt () { openssl enc -aes-256-cbc -a -salt -d -in "$1" ; } # -out "$2"
timeout () { perl -e 'alarm shift; exec @ARGV' "$@" ; }
tar-compress () { tar zcfv "$@" ; }
spiel      () { mpv --no-video --loop "$1" ; }
spielliste () { mpv --no-video "$1" ; }
R-mean () { R --no-echo -e 'x <- scan(file="stdin", quiet=TRUE); mean(x)' ; }
R-sd   () { R --no-echo -e 'x <- scan(file="stdin", quiet=TRUE); sd(x)' ; }
