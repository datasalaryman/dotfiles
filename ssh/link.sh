#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./link.sh

Symlink ssh config file to ~/.ssh/config

'
	exit
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
	if [[ ! -d "$HOME/.ssh" ]]; then
		echo "Creating ~/.ssh directory"
		mkdir -p "$HOME/.ssh"
		chmod 700 "$HOME/.ssh"
	fi

	if [[ -f "$HOME/.ssh/config" && ! -L "$HOME/.ssh/config" ]]; then
		echo "Backing up existing ~/.ssh/config to ~/.ssh/config.backup"
		mv "$HOME/.ssh/config" "$HOME/.ssh/config.backup"
	fi
	ln -sf "$DOTFILES_DIR/config" "$HOME/.ssh/config"
	echo "Linked ~/.ssh/config"
}

main "$@"
