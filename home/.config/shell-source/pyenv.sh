#!/usr/bin/env bash
# Works on macOS (Homebrew pyenv) and Linux (pyenv in ~/.pyenv)

export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init -)"
