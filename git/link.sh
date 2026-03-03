#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./link.sh

Symlink git config files to ~/.gitconfig and ~/.gitignore

'
	exit
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
	# .gitconfig
	if [[ -f "$HOME/.gitconfig" && ! -L "$HOME/.gitconfig" ]]; then
		echo "Backing up existing ~/.gitconfig to ~/.gitconfig.backup"
		mv "$HOME/.gitconfig" "$HOME/.gitconfig.backup"
	fi
	ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
	echo "Linked ~/.gitconfig"

	# .gitignore
	if [[ -f "$HOME/.gitignore" && ! -L "$HOME/.gitignore" ]]; then
		echo "Backing up existing ~/.gitignore to ~/.gitignore.backup"
		mv "$HOME/.gitignore" "$HOME/.gitignore.backup"
	fi
	ln -sf "$DOTFILES_DIR/.gitignore" "$HOME/.gitignore"
	echo "Linked ~/.gitignore"
}

main "$@"
