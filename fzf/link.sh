#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./link.sh

Symlink fzf config files to ~/.fzf.zsh and ~/.fzf.bash

'
	exit
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
	# .fzf.zsh
	if [[ -f "$HOME/.fzf.zsh" && ! -L "$HOME/.fzf.zsh" ]]; then
		echo "Backing up existing ~/.fzf.zsh to ~/.fzf.zsh.backup"
		mv "$HOME/.fzf.zsh" "$HOME/.fzf.zsh.backup"
	fi
	ln -sf "$DOTFILES_DIR/.fzf.zsh" "$HOME/.fzf.zsh"
	echo "Linked ~/.fzf.zsh"

	# .fzf.bash
	if [[ -f "$HOME/.fzf.bash" && ! -L "$HOME/.fzf.bash" ]]; then
		echo "Backing up existing ~/.fzf.bash to ~/.fzf.bash.backup"
		mv "$HOME/.fzf.bash" "$HOME/.fzf.bash.backup"
	fi
	ln -sf "$DOTFILES_DIR/.fzf.bash" "$HOME/.fzf.bash"
	echo "Linked ~/.fzf.bash"
}

main "$@"
