# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/jessechen/.config/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/jessechen/.config/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/jessechen/.config/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/jessechen/.config/.fzf/shell/key-bindings.zsh"

# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden'
