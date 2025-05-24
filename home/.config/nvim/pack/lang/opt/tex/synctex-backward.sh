#!/usr/bin/env bash

###############################################################################
# -*- encoding: UTF-8 -*-                                                     #
# Author: jessekelighine.com                                                  #
# Description: Performs SyncTeX Backwards Search.                             #
#                                                                             #
# Last Modified: 2025-05-20                                                   #
###############################################################################

line="$1"
file="$2"
terminal="Alacritty"
vim_command="<Esc><Esc>:${line}<CR><CR>zz"
tex_server_file="$HOME/.config/nvim/pack/lang/opt/tex/.tex-server"
server="$(cat "${tex_server_file}")"

[[ ! -f "${tex_server_file}" ]] && exit 1

nvim --headless --server "${server}" --remote      "${file}"
nvim --headless --server "${server}" --remote-send "${vim_command}"
open -a ${terminal}

exit 0
