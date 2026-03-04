#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./link-tools-linux.sh

Link all dotfiles for Linux.

'
	exit
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

backup_and_link() {
	local src="$1"
	local dst="$2"

	if [[ -e "$dst" && ! -L "$dst" ]]; then
		echo "Backing up existing $dst to $dst.backup"
		mv "$dst" "$dst.backup"
	fi
	ln -sf "$src" "$dst"
	echo "Linked $dst"
}

main() {
	echo "=== Linking dotfiles for Linux ==="
	echo ""

	# Ensure ~/.config exists
	if [[ ! -d "$HOME/.config" ]]; then
		echo "Creating ~/.config directory"
		mkdir -p "$HOME/.config"
	fi

	# zsh
	echo "Linking zsh config..."
	backup_and_link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
	backup_and_link "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"
	backup_and_link "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"
	echo ""

	# nvim
	echo "Linking nvim config..."
	if [[ -d "$HOME/.config/nvim" && ! -L "$HOME/.config/nvim" ]]; then
		echo "Backing up existing ~/.config/nvim to ~/.config/nvim.backup"
		mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup"
	fi
	ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
	echo "Linked ~/.config/nvim"
	echo ""

	# git
	echo "Linking git config..."
	backup_and_link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
	backup_and_link "$DOTFILES_DIR/git/.gitignore" "$HOME/.gitignore"
	echo ""

	# fzf
	echo "Linking fzf config..."
	backup_and_link "$DOTFILES_DIR/fzf/.fzf.zsh" "$HOME/.fzf.zsh"
	backup_and_link "$DOTFILES_DIR/fzf/.fzf.bash" "$HOME/.fzf.bash"
	echo ""

	# asdf
	echo "Linking asdf config..."
	backup_and_link "$DOTFILES_DIR/asdf/.tool-versions" "$HOME/.tool-versions"
	echo ""

	# act
	echo "Linking act config..."
	backup_and_link "$DOTFILES_DIR/act/.actrc" "$HOME/.actrc"
	echo ""

	# newsboat
	echo "Linking newsboat config..."
	if [[ ! -d "$HOME/.newsboat" ]]; then
		mkdir -p "$HOME/.newsboat"
	fi
	backup_and_link "$DOTFILES_DIR/newsboat/urls" "$HOME/.newsboat/urls"
	backup_and_link "$DOTFILES_DIR/newsboat/config" "$HOME/.newsboat/config"
	echo ""

	echo "=== All dotfiles linked successfully! ==="
}

main "$@"
