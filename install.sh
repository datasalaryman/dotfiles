#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./install.sh

Install all dotfiles by running individual link.sh scripts

'
	exit
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
	echo "Installing dotfiles..."
	echo ""

	# Find and run all link.sh scripts
	for link_script in "$DOTFILES_DIR"/*/link.sh; do
		if [[ -x "$link_script" ]]; then
			dir_name=$(basename "$(dirname "$link_script")")
			echo "Installing $dir_name..."
			(cd "$(dirname "$link_script")" && ./link.sh)
			echo ""
		fi
	done

	echo "All dotfiles installed successfully!"
}

main "$@"
