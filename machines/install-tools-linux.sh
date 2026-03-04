#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./install-tools-linux.sh

Install all tools required by these dotfiles on Linux (Debian/Ubuntu).
This script uses apt to install all tools.

'
	exit
fi

echo "=== Installing tools for dotfiles (Linux) ==="
echo ""

# Check if running on Linux
if [[ "$OSTYPE" != "linux"* ]]; then
	echo "Error: This script is for Linux only."
	exit 1
fi

# Check if apt is available
if ! command -v apt-get &>/dev/null; then
	echo "Error: This script requires apt-get (Debian/Ubuntu)."
	exit 1
fi

# Assume arm64 architecture
ARCH="arm64"
echo "Detected OS: Linux (Debian/Ubuntu)"
echo "Architecture: $ARCH"
echo ""

# Update package list
echo "Updating package list..."
sudo apt-get update

# Install build dependencies and system packages
echo ""
echo "Installing system packages..."
sudo apt-get install -y \
	build-essential \
	curl \
	wget \
	git \
	zsh \
	unzip \
	cmake \
	pkg-config \
	zlib1g-dev \
	libbz2-dev \
	libreadline-dev \
	libssl-dev \
	libsqlite3-dev \
	libncursesw5-dev \
	xz-utils \
	tk-dev \
	libxml2-dev \
	libxmlsec1-dev \
	libffi-dev \
	liblzma-dev \
	libopenblas-dev \
	llvm \
	clang \
	lld \
	default-jdk \
	openjdk-21-jdk

# Install CLI tools via apt where available
echo ""
echo "Installing CLI tools..."
sudo apt-get install -y \
	fzf \
	ripgrep \
	jq \
	redis-tools \
	shellcheck \
	gh

# Install neovim from official repo (newer version)
echo ""
echo "Installing neovim..."
if ! command -v nvim &>/dev/null; then
	curl -LO "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz"
	sudo rm -rf /opt/nvim
	sudo tar -C /opt -xzf nvim-linux-arm64.tar.gz
	sudo ln -sf /opt/nvim-linux-arm64/bin/nvim /usr/local/bin/nvim
	rm nvim-linux-arm64.tar.gz
else
	echo "neovim already installed"
fi

# Install lazygit
echo ""
echo "Installing lazygit..."
if ! command -v lazygit &>/dev/null; then
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_arm64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin
	rm lazygit.tar.gz lazygit
else
	echo "lazygit already installed"
fi

# Install eza
echo ""
echo "Installing eza..."
if ! command -v eza &>/dev/null; then
	sudo apt-get install -y gpg
	sudo mkdir -p /etc/apt/keyrings
	wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
	echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
	sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
	sudo apt-get update
	sudo apt-get install -y eza
else
	echo "eza already installed"
fi

# Install fd
echo ""
echo "Installing fd..."
if ! command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
	sudo apt-get install -y fd-find
	# Create symlink as 'fd' since Ubuntu package uses 'fdfind'
	sudo ln -sf $(which fdfind) /usr/local/bin/fd
else
	echo "fd already installed"
fi

# Install bat
echo ""
echo "Installing bat..."
if ! command -v bat &>/dev/null && ! command -v batcat &>/dev/null; then
	sudo apt-get install -y bat
	# Create symlink as 'bat' since Ubuntu package uses 'batcat'
	sudo ln -sf $(which batcat) /usr/local/bin/bat
else
	echo "bat already installed"
fi

# Install zoxide
echo ""
echo "Installing zoxide..."
if ! command -v zoxide &>/dev/null; then
	curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
else
	echo "zoxide already installed"
fi

# Install xh
echo ""
echo "Installing xh..."
if ! command -v xh &>/dev/null; then
	XH_VERSION=$(curl -s "https://api.github.com/repos/ducaale/xh/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo xh.deb "https://github.com/ducaale/xh/releases/latest/download/xh_${XH_VERSION}_arm64.deb"
	sudo dpkg -i xh.deb || sudo apt-get install -f -y
	rm xh.deb
else
	echo "xh already installed"
fi

# Install glow
echo ""
echo "Installing glow..."
if ! command -v glow &>/dev/null; then
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
	echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
	sudo apt-get update
	sudo apt-get install -y glow
else
	echo "glow already installed"
fi

# Install hyperfine
echo ""
echo "Installing hyperfine..."
if ! command -v hyperfine &>/dev/null; then
	HYPERFINE_VERSION=$(curl -s "https://api.github.com/repos/sharkdp/hyperfine/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo hyperfine.deb "https://github.com/sharkdp/hyperfine/releases/latest/download/hyperfine_${HYPERFINE_VERSION}_arm64.deb"
	sudo dpkg -i hyperfine.deb || sudo apt-get install -f -y
	rm hyperfine.deb
else
	echo "hyperfine already installed"
fi

# Install oh-my-zsh
echo ""
echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
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

# Install asdf
echo ""
echo "Installing asdf..."
if [ ! -d "$HOME/.asdf" ]; then
	git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.14.0

	# Add to shell config
	echo '. "$HOME/.asdf/asdf.sh"' >>"$HOME/.bashrc"
	echo '. "$HOME/.asdf/completions/asdf.bash"' >>"$HOME/.bashrc"
else
	echo "asdf already installed"
fi

# Source asdf for this session
. "$HOME/.asdf/asdf.sh"

# Install asdf plugins
echo ""
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
ANDROID_HOME="$HOME/Android/Sdk"
if [ ! -d "$ANDROID_HOME" ]; then
	mkdir -p "$ANDROID_HOME"
	cd "$ANDROID_HOME"

	# Download and install command line tools
	curl -o cmdline-tools.zip "https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip"
	unzip cmdline-tools.zip
	mkdir -p cmdline-tools/latest
	mv cmdline-tools/* cmdline-tools/latest/ 2>/dev/null || true
	rm cmdline-tools.zip

	# Install platform tools and platform
	"$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --install "platform-tools" "platforms;android-34" 2>/dev/null || true
else
	echo "Android SDK already installed"
fi

# Change default shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
	echo ""
	echo "Changing default shell to zsh..."
	chsh -s "$(which zsh)" || echo "Could not change shell. Run 'chsh -s $(which zsh)' manually."
fi

echo ""
echo "=== All tools installed successfully! ==="
echo ""
echo "Next steps:"
echo "  1. Run ../install.sh to link your dotfiles"
echo "  2. Log out and log back in for shell changes to take effect"
echo "  3. Run 'nvim' to finish installing lazy.nvim plugins"
