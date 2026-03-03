#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./link.sh

Symlink act config file to ~/.actrc

'
	exit
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
	if [[ -f "$HOME/.actrc" && ! -L "$HOME/.actrc" ]]; then
		echo "Backing up existing ~/.actrc to ~/.actrc.backup"
		mv "$HOME/.actrc" "$HOME/.actrc.backup"
	fi
	ln -sf "$DOTFILES_DIR/.actrc" "$HOME/.actrc"
	echo "Linked ~/.actrc"
}

main "$@"
