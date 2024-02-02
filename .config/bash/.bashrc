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

alias 'mv'='mv -i'
alias 'rg'='rg --smart-case'
alias 'grep'='grep --color=auto'
alias 'd'='del'
alias 't'='todo'
alias 'd-restore'="del -l | fzf | sed \"s/\(.*\)/'\\1'/\" | xargs -J % mv % $HOME/Desktop"
alias 'la'='ls -lAhG'
alias 'lad'='ls -lAhGd */'
alias 'mkdir'='mkdir -pv'
alias 'md5sum'='md5 -r'
alias pd='pushd'
alias ppd='popd'
alias dirs='dirs -v'
alias 'vim'='nvim'
alias 'scim'='sc-im'
alias 'youtube-audio'='yt-dlp -f bestaudio -o "~/Desktop/%(creator)s-%(title)s.mp3"'
alias 'weather'='curl "wttr.in/Taipei"'
alias tmm='tmux new -s main -n main'
alias tml='tmux ls'
alias tma='tmux attach -t'
alias tmk='tmux kill-session'
alias tin='tmux new -s "$(pwd | xargs basename)" -n main'
alias 'cmatrix'='cmatrix -ab -u 2'
alias 'pipes.sh'='pipes.sh -r 5000 -R -f 100 -s 10'
alias 'opencc-2t'='opencc -c s2tw.json'
alias 'opencc-2s'='opencc -c t2s.json'
alias ':q'='cowsay "You are not in Vim!"'
alias ':w'='cowsay "You are not in Vim!"'
alias ':x'='cowsay "You are not in Vim!"'
alias ':wq'='cowsay "You are not in Vim!"'

[[ -d "$HOME/.config/bash"      ]] && source "$HOME/.config/bash/up.sh"
[[ -f "$HOME/.config/.fzf.bash" ]] && source "$HOME/.config/.fzf.bash"

export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS='--layout=reverse --info=inline --extended'
export BC_ENV_ARGS="$HOME/.config/.bc"
export B2_ACCOUNT_INFO="$HOME/.config/b2/.b2_account_info"
export B2_APPLICATION_KEY_ID="$(<$HOME/.config/b2/file-with-key-id.txt)"
export B2_APPLICATION_KEY="$(<$HOME/.config/b2/file-with-key.txt)"
export HOMEBREW_NO_AUTO_UPDATE=1

encrypt () { openssl aes-256-cbc -a -salt -pbkdf2 -in "$1" ; } # -out "$2"
decrypt () { openssl aes-256-cbc -d -a    -pbkdf2 -in "$1" ; } # -out "$2"

R-mean  () { R --no-echo -e 'x <- scan(file="stdin", quiet=TRUE); mean(x)' ; }
R-sd    () { R --no-echo -e 'x <- scan(file="stdin", quiet=TRUE);   sd(x)' ; }
