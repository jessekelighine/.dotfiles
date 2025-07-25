#!/bin/zsh

setopt autocd
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
export SHELL_SESSIONS_DISABLE=1

# HOMEBREW:
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

set -o vi
autoload -U colors && colors
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LSCOLORS='exfxcxdxbxegedabagacad'
export CLICOLOR=1
export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$ZDOTDIR/.zsh_history"

export PS1="%B%{$fg[red]%}["           # [
export PS1="$PS1%{$fg[yellow]%}%n"     # username
export PS1="$PS1%{$reset_color%}%B@"   # @
export PS1="$PS1%{$fg[blue]%}%m "      # hostname
export PS1="$PS1%{$fg[magenta]%}%~"    # working directory
export PS1="$PS1%{$fg[red]%}]"         # ]
export PS1="$PS1%{$reset_color%}%%%b " # %

[[ -x "$(command -v fzf)" ]] && {
	export FZF_CTRL_T_COMMAND='fd --hidden --follow --exclude .git'
	source <(fzf --zsh)
}

[[ -d "$HOME/.config/zsh" ]] && {
	source "$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
	source "$HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
}

[[ -d "$HOME/.config/shell-source" ]] && {
	source "$HOME/.config/shell-source/export.sh"
	source "$HOME/.config/shell-source/alias-function.sh"
	source "$HOME/.config/shell-source/up.sh"
	source "$HOME/.config/shell-source/pyenv.sh"
}

confucius-said --random

# xiaolin-said --random

# mencius_chapters=(7 8 9 10 11 12 13 14)
# random_mencius_index=$((1 + RANDOM % ${#mencius_chapters[@]})) # zsh is 1-indexed
# random_mencius_chapter=${mencius_chapters[$random_mencius_index]}
# mencius-said --random-from-chapter "$random_mencius_chapter"

# mencius-said --random-from-chapter 13
