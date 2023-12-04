#!/bin/zsh

setopt autocd
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

set -o vi
autoload -U colors && colors
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export MAILCHECK=0
# export LANG=C
# export LC_ALL=C
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
export PS1="%B%{$fg[red]%}["           # [
export PS1="$PS1%{$fg[yellow]%}%n"     # username
export PS1="$PS1%{$reset_color%}%B@"   # @
export PS1="$PS1%{$fg[blue]%}%m "      # hostname
export PS1="$PS1%{$fg[magenta]%}%~"    # working directory
export PS1="$PS1%{$fg[red]%}]"         # ]
export PS1="$PS1%{$reset_color%}%%%b " # %
# autoload -Uz compinit && compinit

alias 'mv'='mv -i'
alias 'rg'='rg --smart-case'
alias 'grep'='grep --color=auto'
alias 'd'='del'
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
alias ':q'='cowsay "You are not in Vim!" | lolcat'
alias ':w'='cowsay "You are not in Vim!" | lolcat'
alias ':wq'='cowsay "You are not in Vim!" | lolcat'

[[ -d "$HOME/.config/zsh"      ]] && source "$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -d "$HOME/.config/zsh"      ]] && source "$HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -d "$HOME/.config/zsh"      ]] && source "$HOME/.config/zsh/up.sh"
[[ -f "$HOME/.config/.fzf.zsh" ]] && source "$HOME/.config/.fzf.zsh"
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS='--layout=reverse --info=inline --extended'
export BC_ENV_ARGS="$HOME/.config/.bc"
export B2_ACCOUNT_INFO="$HOME/.config/b2/.b2_account_info"
export B2_APPLICATION_KEY_ID="$(<$HOME/.config/b2/file-with-key-id.txt)"
export B2_APPLICATION_KEY="$(<$HOME/.config/b2/file-with-key.txt)"

# tar-compress () { tar zvcf "$@" }
# tar-extract  () { tar zvxf "$@" }
tldr    () { open -a Firefox "https://tldr.inbrowser.app"; echo "$@" > /dev/null }
timeout () { perl -e 'alarm shift; exec @ARGV' "$@" }
encrypt () { openssl enc -aes-256-cbc -a -md md5 -salt -e -in "$1" } # -out "$2"
decrypt () { openssl enc -aes-256-cbc -a -md md5 -salt -d -in "$1" } # -out "$2"
volume  () { cd "/Volumes/$1" }
eject   () { diskutil eject "$1" }
R-mean  () { R --no-echo -e 'x <- scan(file="stdin",quiet=TRUE); mean(x)' }
R-sd    () { R --no-echo -e 'x <- scan(file="stdin",quiet=TRUE); sd(x)'   }

SPIEL_LOCATION="$HOME/Documents/.music.sh"
spiel           () { echo "$0 $@" >> "$SPIEL_LOCATION" && mpv --ytdl=no --no-video --loop "$1" }
spiel-mono      () { echo "$0 $@" >> "$SPIEL_LOCATION" && mpv --ytdl=no --no-video --loop --audio-channels=mono "$1" }
spielliste      () { echo "$0 $@" >> "$SPIEL_LOCATION" && mpv --ytdl=no --no-video "$1" }
spielliste-mono () { echo "$0 $@" >> "$SPIEL_LOCATION" && mpv --ytdl=no --no-video --audio-channels=mono "$1" }

command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"

# PROMPT='%B%F{196}%1~%f%b %# '
# export PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# PATH=/usr/local/texlive/2022/bin/universal-darwin:"${PATH}"
# cwtex () { python3 /usr/local/texlive/texmf-local/bin/cwtex51b.py "$1"; pdflatex $(echo "$1" | sed -E 's/\.ctx$/.tex/g'); }
