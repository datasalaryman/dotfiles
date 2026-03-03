#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./link.sh

Symlink yarn config files to ~/.yarnrc and ~/.yarnrc.yml

'
	exit
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
	# .yarnrc
	if [[ -f "$HOME/.yarnrc" && ! -L "$HOME/.yarnrc" ]]; then
		echo "Backing up existing ~/.yarnrc to ~/.yarnrc.backup"
		mv "$HOME/.yarnrc" "$HOME/.yarnrc.backup"
	fi
	ln -sf "$DOTFILES_DIR/.yarnrc" "$HOME/.yarnrc"
	echo "Linked ~/.yarnrc"

	# .yarnrc.yml
	if [[ -f "$HOME/.yarnrc.yml" && ! -L "$HOME/.yarnrc.yml" ]]; then
		echo "Backing up existing ~/.yarnrc.yml to ~/.yarnrc.yml.backup"
		mv "$HOME/.yarnrc.yml" "$HOME/.yarnrc.yml.backup"
	fi
	ln -sf "$DOTFILES_DIR/.yarnrc.yml" "$HOME/.yarnrc.yml"
	echo "Linked ~/.yarnrc.yml"
}

main "$@"
