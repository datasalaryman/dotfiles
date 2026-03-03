# Setup fzf
# ---------
if [[ ! "$PATH" == */.asdf/installs/fzf* ]]; then
	PATH="${PATH:+${PATH}:}$(asdf where fzf)/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$(asdf where fzf)/shell/completion.bash" 2>/dev/null

# Key bindings
# ------------
source "$(asdf where fzf)/shell/key-bindings.bash"
