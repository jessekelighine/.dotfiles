#!/bin/bash
# ~/.bashrc — shared by macOS and Linux (ovile)

# Non-interactive shells (scp, rsync, `ssh ovile '<cmd>'`, agents) stop here,
# so nothing below can print output or call `bind` and break them.
case $- in
	*i*) ;;
	*) return ;;
esac

set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
shopt -s autocd

shopt -s histappend
shopt -s checkwinsize

# \[ \] around colour codes keeps the cursor aligned on long command lines
export PS1="\[\e[1;31m\][\[\e[1;33m\]\u\[\e[1;37m\]@\[\e[1;34m\]\h \[\e[1;35m\]\w\[\e[1;31m\]]\[\e[m\]\$ \[\e[0m\]"
export SHELL_SESSIONS_DISABLE=1
mkdir -p "$HOME/.config/bash"
export HISTFILE="$HOME/.config/bash/.bash_history"
export LS_COLORS="fi=01;37:di=01;34:ex=01;32:ln=37\
:or=01;30:mi=00:mh=31\
:pi=33:so=43;30:do=35\
:bd=35;01:cd=35\
:su=37;41:sg=30;43:ca=30;41\
:tw=07;34:ow=30;44:st=30;44"

# GNU ls (Linux) needs --color; BSD ls (macOS) uses CLICOLOR
case "$(uname -s)" in
	Linux) alias ls='ls --color=auto' ;;
	Darwin) export CLICOLOR=1 ;;
esac

[[ -x "$(command -v fzf)" ]] && {
	export FZF_CTRL_T_COMMAND='fd --hidden --follow --exclude .git'
	eval "$(fzf --bash)"
}

[[ -d "$HOME/.config/shell-source" ]] && {
	source "$HOME/.config/shell-source/export.sh"
	source "$HOME/.config/shell-source/alias-function.sh"
	source "$HOME/.config/shell-source/up.sh"
	source "$HOME/.config/shell-source/pyenv.sh"
}

# Tab completion for apt, git, systemctl, ... (Linux)
if ! shopt -oq posix && [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
fi

command -v confucius-said >/dev/null && confucius-said --random
