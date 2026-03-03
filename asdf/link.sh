#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./link.sh

Symlink asdf tool-versions to ~/.tool-versions

'
	exit
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
	if [[ -f "$HOME/.tool-versions" && ! -L "$HOME/.tool-versions" ]]; then
		echo "Backing up existing ~/.tool-versions to ~/.tool-versions.backup"
		mv "$HOME/.tool-versions" "$HOME/.tool-versions.backup"
	fi
	ln -sf "$DOTFILES_DIR/.tool-versions" "$HOME/.tool-versions"
	echo "Linked ~/.tool-versions"
}

main "$@"
