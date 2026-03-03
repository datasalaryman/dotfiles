#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./link.sh

Symlink zsh config files to ~/.zshrc, ~/.zprofile, and ~/.zshenv

'
	exit
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
	# .zshrc
	if [[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
		echo "Backing up existing ~/.zshrc to ~/.zshrc.backup"
		mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
	fi
	ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
	echo "Linked ~/.zshrc"

	# .zprofile
	if [[ -f "$HOME/.zprofile" && ! -L "$HOME/.zprofile" ]]; then
		echo "Backing up existing ~/.zprofile to ~/.zprofile.backup"
		mv "$HOME/.zprofile" "$HOME/.zprofile.backup"
	fi
	ln -sf "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
	echo "Linked ~/.zprofile"

	# .zshenv
	if [[ -f "$HOME/.zshenv" && ! -L "$HOME/.zshenv" ]]; then
		echo "Backing up existing ~/.zshenv to ~/.zshenv.backup"
		mv "$HOME/.zshenv" "$HOME/.zshenv.backup"
	fi
	ln -sf "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
	echo "Linked ~/.zshenv"
}

main "$@"
