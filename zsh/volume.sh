#!/bin/bash

eject() {
	[[ "$1" == "" ]] && {
		diskutil list external
		return -1
	}
	disk=$(diskutil list | awk 'BEGIN { last_disk="" } /^\/dev\/disk/ { last_disk=$1 } ($2 ~ /'"$1"'/) || ($3 ~ /'"$1"'/) { print last_disk; exit }')
	[[ "$disk" == "" ]] && {
		echo "Disk with this label not found!"
		return -2
	}
	diskutil eject "$disk"
}

volume() {
	[[ "$1" == "" ]] && {
		ls -lAhG /Volumes
		cd /Volumes
		return 0
	}
	cd /Volumes/"$1"
}

# _disks () {
# 	COMPREPLY=( $(diskutil list physical external | grep '\d:' | grep -v 'FDisk_partition_scheme' | awk '{ print $3 }') )
# }

# complete -o nospace -F _disks volume
# complete -o nospace -F _disks eject
