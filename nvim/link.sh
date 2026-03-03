#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./link.sh

Symlink nvim config to ~/.config/nvim

'
	exit
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
	if [[ ! -d "$HOME/.config" ]]; then
		echo "Creating ~/.config directory"
		mkdir -p "$HOME/.config"
	fi

	if [[ -d "$HOME/.config/nvim" && ! -L "$HOME/.config/nvim" ]]; then
		echo "Backing up existing ~/.config/nvim to ~/.config/nvim.backup"
		mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup"
	fi
	ln -sf "$DOTFILES_DIR" "$HOME/.config/nvim"
	echo "Linked ~/.config/nvim"
}

main "$@"
