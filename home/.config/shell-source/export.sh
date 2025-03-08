#!/usr/bin/env bash

export PATH="$HOME/.local/bin:$PATH"
export MAILCHECK=0
export EDITOR=nvim
export VISUAL="$EDITOR"
export LESSHISTFILE=-
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
export SHELL_SESSIONS_DISABLE=1

export HOMEBREW_NO_AUTO_UPDATE=1

export PYTHONSTARTUP=~/.config/python/.python_history

[[ -d "$HOME/.config/b2/.b2_account_info"     ]] && export B2_ACCOUNT_INFO="$HOME/.config/b2/.b2_account_info"
[[ -d "$HOME/.config/b2/file-with-key-id.txt" ]] && export B2_APPLICATION_KEY_ID="$(<"$HOME/.config/b2/file-with-key-id.txt")"
[[ -d "$HOME/.config/b2/file-with-key.txt"    ]] && export B2_APPLICATION_KEY="$(<"$HOME/.config/b2/file-with-key.txt")"

[[ -f "$HOME/.config/.bc" ]] && export BC_ENV_ARGS="$HOME/.config/.bc"
