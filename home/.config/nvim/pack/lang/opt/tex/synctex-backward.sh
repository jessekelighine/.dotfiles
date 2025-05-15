#!/usr/bin/env bash

###############################################################################
# -*- encoding: UTF-8 -*-                                                     #
# Author: jessekelighine.com                                                  #
# Description: Performs SyncTeX Backwards Search.                             #
#                                                                             #
# Last Modified: 2025-04-20                                                   #
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

###############################################################################

line="$1"
file="$2"
terminal="Alacritty"
vim_command="<Esc><Esc>:${line}<CR><CR>zz"

for server in $(echo ${XDG_RUNTIME_DIR:-${TMPDIR}nvim.${USER}}/*/nvim.*.0)
do
	nvim --server "$server" --remote-send "${vim_command}" --remote "${file}"
	echo $?
done
open -a ${terminal}

exit 0

###############################################################################

line="$1"
file="$2"
terminal="Alacritty"
export_nvim_listen_address="$HOME/.config/shell-source/export.sh"
vim_command="<Esc><Esc>:${line}<CR><CR>zz"

source "${export_nvim_listen_address}"
nvim --server "$NVIM_LISTEN_ADDRESS" --remote-send +"${vim_command}" "${file}"
open -a ${terminal}

exit 0
