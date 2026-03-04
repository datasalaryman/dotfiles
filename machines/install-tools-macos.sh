#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./install-tools-macos.sh

Install all tools required by these dotfiles on macOS.
This script installs Homebrew, asdf, oh-my-zsh, and various CLI tools.

'
	exit
fi

echo "=== Installing tools for dotfiles (macOS) ==="
echo ""

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
	echo "Error: This script is for macOS only."
	exit 1
fi

# Architecture is assumed to be arm64
HOMEBREW_PREFIX="/opt/homebrew"

echo "Architecture: arm64"
echo ""

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# Add Homebrew to PATH for this session
	eval "$("$HOMEBREW_PREFIX/bin/brew" shellenv)"
else
	echo "Homebrew already installed"
fi

# Install Homebrew packages
echo ""
echo "Installing Homebrew packages..."
brew install \
	zlib \
	bzip2 \
	openblas \
	llvm \
	openjdk \
	openssl \
	readline \
	zoxide \
	asdf \
	zsh \
	git \
	libpq \
	xz \
	eza \
	fzf \
	fd \
	bat \
	ripgrep \
	jq \
	xh \
	glow \
	hyperfine \
	shellcheck \
	lazygit \
	neovim \
	redis \
	gh

echo ""
echo "Installing Homebrew casks..."
brew install --cask \
	font-meslo-lg-nerd-font \
	iterm2

# Install oh-my-zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo ""
	echo "Installing Oh My Zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
	echo ""
	echo "Oh My Zsh already installed"
fi

# Install zsh plugins
echo ""
echo "Installing zsh plugins..."

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Initialize asdf
echo ""
echo "Setting up asdf..."

# Add asdf to PATH for this script
. "$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh"

# Install asdf plugins
echo "Installing asdf plugins..."

asdf_plugin_add() {
	if ! asdf plugin list 2>/dev/null | grep -q "^$1$" 2>/dev/null; then
		asdf plugin add "$1" 2>/dev/null || true
	fi
}

asdf_plugin_add python
asdf_plugin_add uv
asdf_plugin_add nodejs
asdf_plugin_add golang
asdf_plugin_add java
asdf_plugin_add nim
asdf_plugin_add zig
asdf_plugin_add act

# Install tools from .tool-versions
echo ""
echo "Installing asdf tools (this may take a while)..."
echo ""

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$DOTFILES_DIR"

# Install all tools from .tool-versions
asdf install 2>/dev/null || true

# Install pnpm
echo ""
echo "Installing pnpm..."
if ! command -v pnpm &>/dev/null; then
	curl -fsSL https://get.pnpm.io/install.sh | sh -
else
	echo "pnpm already installed"
fi

# Install bun
echo ""
echo "Installing bun..."
if ! command -v bun &>/dev/null; then
	curl -fsSL https://bun.sh/install | bash
else
	echo "bun already installed"
fi

# Install opencode
echo ""
echo "Installing opencode..."
if ! command -v opencode &>/dev/null; then
	curl -fsSL https://opencode.ai/install.sh | bash
else
	echo "opencode already installed"
fi

# Install solana CLI
echo ""
echo "Installing solana CLI..."
if ! command -v solana &>/dev/null; then
	sh -c "$(curl -sSfL https://release.anza.xyz/stable/install)"
else
	echo "solana CLI already installed"
fi

# Install Android SDK (command line tools)
echo ""
echo "Installing Android SDK..."
ANDROID_HOME="$HOME/Library/Android/sdk"
if [ ! -d "$ANDROID_HOME" ]; then
	mkdir -p "$ANDROID_HOME"
	cd "$ANDROID_HOME"

	# Download and install command line tools
	curl -o cmdline-tools.zip "https://dl.google.com/android/repository/commandlinetools-mac-11076708_latest.zip"
	unzip cmdline-tools.zip
	mkdir -p cmdline-tools/latest
	mv cmdline-tools/* cmdline-tools/latest/ 2>/dev/null || true
	rm cmdline-tools.zip

	# Install platform tools and platform
	"$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --install "platform-tools" "platforms;android-34" 2>/dev/null || true
else
	echo "Android SDK already installed"
fi

echo ""
echo "=== All tools installed successfully! ==="
echo ""
echo "Next steps:"
echo "  1. Run ../install.sh to link your dotfiles"
echo "  2. Restart your terminal or run 'source ~/.zshrc'"
echo "  3. Run 'nvim' to finish installing lazy.nvim plugins"
