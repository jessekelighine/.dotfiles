#!/usr/bin/env bash

window_id="9"
window_name="musik"
window_list=$(tmux list-windows | awk -F : '{ print $1 }')

for id in ${window_list[@]} ; do
	[ $id = $window_id ] && {
		tmux select-window -t "$window_id"
		exit 0
	}
done

tmux new-window -n "$window_name" -t "$window_id"
exit 0
