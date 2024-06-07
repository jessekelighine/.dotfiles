#!/usr/bin/env bash

alias mv='mv -i'
alias la='ls -lAhG'
alias lad='ls -lAhGd */'
alias mkdir='mkdir -pv'
alias grep='grep --color=auto'
alias md5sum='md5 -r'
alias rg='rg --smart-case'

alias 'd'='del'
alias 'd-restore'="del -l | fzf | sed \"s/\(.*\)/'\\1'/\" | xargs -J % mv % $HOME/Desktop"
alias 'vim'='nvim'
alias 'scim'='sc-im'
alias 'youtube-audio'='yt-dlp -f bestaudio -o "~/Desktop/%(creator)s-%(title)s.mp3"'

alias pd='pushd'
alias ppd='popd'
alias dirs='dirs -v'

alias tmm='tmux new -s main -n main'
alias tml='tmux ls'
alias tma='tmux attach -t'
# alias tmk='tmux kill-session'
# alias tin='tmux new -s "$(pwd | xargs basename)" -n main'
tmn () { tmux new -s "$1" -n "$1"; }

alias 'opencc-2t'='opencc -c s2tw.json'
alias 'opencc-2s'='opencc -c t2s.json'

alias wordsegment='python -m wordsegment'

alias ':q'='cowsay  -e xx -T U "You are not in Vim!"'
alias ':w'='cowsay  -e xx -T U "You are not in Vim!"'
alias ':x'='cowsay  -e xx -T U "You are not in Vim!"'
alias ':wq'='cowsay -e xx -T U "You are not in Vim!"'
