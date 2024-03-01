#!/usr/bin/env bash

tar-compress () { tar zvcf "$@"; }
tar-extract  () { tar zvxf "$@"; }

encrypt () { openssl aes-256-cbc    -a -salt -pbkdf2 -in "$1" ; } # -out "$2"
decrypt () { openssl aes-256-cbc -d -a       -pbkdf2 -in "$1" ; } # -out "$2"

# encrypt-old () { openssl enc -aes-256-cbc -a -md md5 -salt -e -in "$1" } # -out "$2"
# decrypt-old () { openssl enc -aes-256-cbc -a -md md5 -salt -d -in "$1" } # -out "$2"

# R-mean  () { R --no-echo -e 'x <- scan(file="stdin", quiet=TRUE); mean(x)'; }
# R-sd    () { R --no-echo -e 'x <- scan(file="stdin", quiet=TRUE);   sd(x)'; }

###############################################################################

MY_RECOGNIZED_DISKS=("SCHWARZ" "LANG" "Kindle" "KURZ" "FOTO")

volume-auto () {
	[[ $# -ne 0 ]] && {
		cd "/Volumes/$1" && return 0
		return 1
	}
	for disk in "${MY_RECOGNIZED_DISKS[@]}"
	do cd "/Volumes/${disk}" 2>/dev/null && return 0
	done
	echo "$0: no disks found" >&2
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
	echo "$0: no disks found" >&2
	return 1
}

### Spiel #####################################################################

SPIEL_LOCATION="$HOME/.dotfiles/others/music.sh"
spiel           () { echo "$0 '$1' ${@:2}" >> "$SPIEL_LOCATION" && mpv --ytdl=no --no-video --loop "$1"; }
spiel-mono      () { echo "$0 '$1' ${@:2}" >> "$SPIEL_LOCATION" && mpv --ytdl=no --no-video --loop --audio-channels=mono "$1"; }
spielliste      () { echo "$0 '$1' ${@:2}" >> "$SPIEL_LOCATION" && mpv --ytdl=no --no-video "$1"; }
spielliste-mono () { echo "$0 '$1' ${@:2}" >> "$SPIEL_LOCATION" && mpv --ytdl=no --no-video --audio-channels=mono "$1"; }
