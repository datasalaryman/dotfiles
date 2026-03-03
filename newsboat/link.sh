#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./link.sh

Symlink the newsboat urls to this github repository

'
	exit
fi

main() {
	if [[ ! -d "$HOME/.newsboat" ]]; then
		mkdir -p "$HOME/.newsboat"
	fi

	ln -sf "$PWD/urls" "$HOME/.newsboat/urls"
	ln -sf "$PWD/config" "$HOME/.newsboat/config"
}

main "$@"
