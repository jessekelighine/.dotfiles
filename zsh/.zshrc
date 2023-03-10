#!/bin/zsh

setopt autocd
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

set -o vi
autoload -U colors && colors
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"
export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$ZDOTDIR/.zsh_history"
export LSCOLORS='exfxcxdxbxegedabagacad'
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
export SHELL_SESSIONS_DISABLE=1
export CLICOLOR=1
export EDITOR=nvim
export VISUAL="$EDITOR"
export LESSHISTFILE=-
export PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$reset_color%}%B@%{$fg[blue]%}%m %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}%%%b "
autoload -Uz compinit && compinit

alias 'mv'='mv -i'
alias 'rg'='rg --smart-case'
alias 'grep'='grep --color=auto'
alias 'd'='del'
alias 'd-restore'="del -l | fzf | xargs -J % mv % $HOME/Desktop"
alias 'la'='ls -lAhG'
alias 'lad'='ls -lAhGd */'
alias 'mkdir'='mkdir -pv'
alias 'md5sum'='md5 -r'
alias pd='pushd'
alias ppd='popd'
alias dirs='dirs -v'
alias 'vim'='/usr/local/bin/nvim'
alias 'scim'='sc-im'
alias 'youtube-audio'='youtube-dl -f bestaudio -o "~/Desktop/%(creator)s-%(title)s.mp3"'
alias 'weather'='curl "wttr.in/Taipei"'
alias tmm='tmux new -s main -n main'
alias tml='tmux ls'
alias tma='tmux attach -t'
alias tmk='tmux kill-session'

source "$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.config/zsh/up.sh"
source "$HOME/.config/.fzf.zsh"
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS='--layout=reverse --info=inline --extended'
export DEL_DIR="$HOME/.Trash"
export BC_ENV_ARGS="$HOME/.config/.bc"
export B2_ACCOUNT_INFO="$HOME/.config/b2/.b2_account_info"
export B2_APPLICATION_KEY_ID="$(<$HOME/.config/b2/file-with-key-id.txt)"
export B2_APPLICATION_KEY="$(<$HOME/.config/b2/file-with-key.txt)"

timeout () { perl -e 'alarm shift; exec @ARGV' "$@" }
encrypt () { openssl enc -aes-256-cbc -a -salt -e -in "$1" } # -out "$2"
decrypt () { openssl enc -aes-256-cbc -a -salt -d -in "$1" } # -out "$2"
tar-compress () { tar zcfv "$@" }
tar-extract  () { tar zxfv "$@" }
volume () { cd "/Volumes/$1" }
eject  () { diskutil eject "$1" }
R-mean () { R --no-echo -e 'x <- scan(file="stdin",quiet=TRUE); mean(x)' }
R-sd   () { R --no-echo -e 'x <- scan(file="stdin",quiet=TRUE); sd(x)'   }
spiel           () { yt-dlp --skip-download --get-title "$1" ; mpv --ytdl=no --no-video --loop "$1" }
spiel-mono      () { yt-dlp --skip-download --get-title "$1" ; mpv --ytdl=no --no-video --loop --audio-channels=mono "$1" }
spielliste      () { yt-dlp --skip-download --get-title "$1" ; mpv --ytdl=no --no-video "$1" }
spielliste-mono () { yt-dlp --skip-download --get-title "$1" ; mpv --ytdl=no --no-video --audio-channels=mono "$1" }

# PROMPT='%B%F{196}%1~%f%b %# '
# export PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# PATH=/usr/local/texlive/2022/bin/universal-darwin:"${PATH}"
# cwtex () { python3 /usr/local/texlive/texmf-local/bin/cwtex51b.py "$1"; pdflatex $(echo "$1" | sed -E 's/\.ctx$/.tex/g'); }
