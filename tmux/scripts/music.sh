#!/usr/bin/env bash

###############################################################################
# -*- encoding: UTF-8 -*-                                                     #
# Author: Jesse C. Chen  (jessekelighine@gmail.com)                           #
# Description: Creates a new window that plays music.                         #
#                                                                             #
# Last Modified: 2023-03-19                                                   #
###############################################################################

window_id="9"
window_name="music"
window_list=$( tmux list-windows | awk -F : '{ print $1 }' )

for id in ${window_list[@]} ; do
	[ $id = $window_id ] && {
		tmux select-window -t "$window_id"
		exit 0
	}
done

tmux new-window -n "$window_name" -t "$window_id"
exit 0