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
alias 'scim'='sc-im'
alias 'youtube-audio'='yt-dlp -f bestaudio -o "~/Desktop/%(creator)s-%(title)s.mp3"'

alias pd='pushd'
alias ppd='popd'
alias dirs='dirs -v'

alias 'opencc-2t'='opencc -c s2tw.json'
alias 'opencc-2s'='opencc -c t2s.json'

alias wordsegment='python -m wordsegment'

alias tmm='tmux new -s main -n main'
alias tml='tmux ls'
alias tma='tmux attach -t'
alias tmk='tmux kill-session'
# alias tin='tmux new -s "$(pwd | xargs basename)" -n main'
tmn () { tmux new -s "$1" -n "$1"; }

for vim_cmd in ":q" ":qa" ":w" ":wa" ":x" ":wq" ":wqa" ; do
	alias "${vim_cmd}"='cowsay -e xx "You are not in Vim!" | rainbowize'
done

tar-compress () { tar zvcf "$@"; }
tar-extract  () { tar zvxf "$@"; }

### Encryption / Decryption ###################################################

encrypt () { openssl aes-256-cbc    -a -salt -pbkdf2 -in "$1" ; } # -out "$2"
decrypt () { openssl aes-256-cbc -d -a       -pbkdf2 -in "$1" ; } # -out "$2"

# encrypt-old () { openssl enc -aes-256-cbc -a -md md5 -salt -e -in "$1" } # -out "$2"
# decrypt-old () { openssl enc -aes-256-cbc -a -md md5 -salt -d -in "$1" } # -out "$2"

### Vim / Neovim ##############################################################

alias 'vim'='nvim'

vims () {
	local session; session="${1:-Session.vim}"
	[[ ! -f ${session} ]] && {
		echo "$(tput bold)$0$(tput sgr0): ${session} not found"
		return 1
	}
	nvim -S ${session}
	return 0
}

### R #########################################################################

R-mean () { R --no-echo -e 'x <- scan(file="stdin", quiet=TRUE); cat(mean(x),fill=TRUE)'; }
R-sum  () { R --no-echo -e 'x <- scan(file="stdin", quiet=TRUE);  cat(sum(x),fill=TRUE)'; }
R-sd   () { R --no-echo -e 'x <- scan(file="stdin", quiet=TRUE);   cat(sd(x),fill=TRUE)'; }

### Volume ####################################################################

MY_RECOGNIZED_DISKS=("SCHWARZ" "LANG" "Kindle" "KURZ" "FOTO")

volume-auto () {
	[[ $# -ne 0 ]] && {
		cd "/Volumes/$1" && return 0
		return 1
	}
	for disk in "${MY_RECOGNIZED_DISKS[@]}"
	do cd "/Volumes/${disk}" 2>/dev/null && return 0
	done
	echo "$(tput bold)$0$(tput sgr0): no disks found" >&2
	return 1
}

eject-auto () {
	[[ $# -ne 0 ]] && {
		diskutil eject "$1" && return 0
		return 1
	}
	for disk in "${MY_RECOGNIZED_DISKS[@]}"
	do
		[[ ! -d "/Volumes/${disk}" ]] && continue
		diskutil eject "${disk}" 2>/dev/null && return 0
		echo "$0: cannot eject ${disk}" >&2
		return 1
	done
	echo "$(tput bold)$0$(tput sgr0): no disks found" >&2
	return 1
}

### Spiel #####################################################################

SPIEL_LOCATION="$HOME/.dotfiles/others/music.sh"
spiel           () { echo "$0 '$1' ${@:2}" >> "$SPIEL_LOCATION" && mpv --ytdl=no --no-video --loop "$1"; }
spiel-mono      () { echo "$0 '$1' ${@:2}" >> "$SPIEL_LOCATION" && mpv --ytdl=no --no-video --loop --audio-channels=mono "$1"; }
spielliste      () { echo "$0 '$1' ${@:2}" >> "$SPIEL_LOCATION" && mpv --ytdl=no --no-video "$1"; }
spielliste-mono () { echo "$0 '$1' ${@:2}" >> "$SPIEL_LOCATION" && mpv --ytdl=no --no-video --audio-channels=mono "$1"; }
