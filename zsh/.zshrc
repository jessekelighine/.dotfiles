#!/bin/zsh

setopt autocd
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

set -o vi
autoload -U colors && colors
export PATH="$HOME/.local/bin:$PATH"
export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
export LSCOLORS='exfxcxdxbxegedabagacad'
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
export SHELL_SESSIONS_DISABLE=1
export CLICOLOR=1
export EDITOR=nvim
export VISUAL="$EDITOR"
export LESSHISTFILE=-
export PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$reset_color%}%B@%{$fg[blue]%}%m %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}%%%b "

alias 'mv'='mv -i'
alias 'rg'='rg --smart-case'
alias 'grep'='grep --color=auto'
alias 'd'='del'
alias 'd-restore'="del -l | fzf | xargs -J % mv % $HOME/Desktop"
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
alias 'spiel'='mpv --no-video --loop' # --audio-channels=mono
alias 'spielliste'='mpv --no-video'
alias 'weather'='curl "wttr.in/Taipei"'
alias 'R-mean'='R --no-echo -e '\''x <- scan(file="stdin", quiet=TRUE); mean(x)'\'''
alias 'R-sd'='R --no-echo -e '\''x <- scan(file="stdin", quiet=TRUE); sd(x)'\'''

source "$HOME/.dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.dotfiles/zsh/up.sh"
source "$HOME/.dotfiles/zsh/volume.sh"
source "$HOME/.dotfiles/.fzf.zsh"
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS='--layout=reverse --info=inline --extended'
export DEL_DIR="$HOME/.Trash"
export BC_ENV_ARGS="$HOME/.dotfiles/.bc"
export B2_ACCOUNT_INFO="$HOME/.dotfiles/b2/.b2_account_info"
export B2_APPLICATION_KEY_ID="$(<$HOME/.dotfiles/b2/file-with-key-id.txt)"
export B2_APPLICATION_KEY="$(<$HOME/.dotfiles/b2/file-with-key.txt)"

encrypt () { openssl enc -aes-256-cbc -a -salt -e -in "$1" } # -out "$2"
decrypt () { openssl enc -aes-256-cbc -a -salt -d -in "$1" } # -out "$2"
timeout () { perl -e 'alarm shift; exec @ARGV' "$@" }
tar-compress () { tar zcfv "$@" }
tar-extract  () { tar zxfv "$@" }

# PROMPT='%B%F{196}%1~%f%b %# '
# export PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# PATH=/usr/local/texlive/2022/bin/universal-darwin:"${PATH}"
# cwtex () { python3 /usr/local/texlive/texmf-local/bin/cwtex51b.py "$1"; pdflatex $(echo "$1" | sed -E 's/\.ctx$/.tex/g'); }