#!/bin/zsh

autoload -Uz compinit && compinit
export LANG=C
export LC_ALL=C

PROMPT='%B%F{196}%1~%f%b %# '
export PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

PATH=/usr/local/texlive/2022/bin/universal-darwin:"${PATH}"
cwtex () { python3 /usr/local/texlive/texmf-local/bin/cwtex51b.py "$1"; pdflatex $(echo "$1" | sed -E 's/\.ctx$/.tex/g'); }
