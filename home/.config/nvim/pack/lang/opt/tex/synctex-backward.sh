#!/usr/bin/env bash

###############################################################################
# Author: Jesse Chieh Chen (jessekelighine.com)                               #
# Description: Performs SyncTeX Backwards Search.                             #
#                                                                             #
# Last Modified: 2026-03-20                                                   #
###############################################################################

set -euo pipefail

line="$1"
file="$2"

terminal="ghostty"
vim_command="<Esc><Esc>:${line}<CR><CR>zz"

tex_server_file="$HOME/.config/nvim/pack/lang/opt/tex/.tex-server"
[[ ! -f "${tex_server_file}" ]] && exit 1
server="$(<"$tex_server_file")"

nvim --headless --server "${server}" --remote      "${file}"
nvim --headless --server "${server}" --remote-send "${vim_command}"
open -a ${terminal}
