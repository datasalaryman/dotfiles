export PATH=$HOME/bin:$HOME/.local/bin:/opt/homebrew/bin:$HOME/.gcloud/bin:$HOME/.avm/bin:$HOME/.local/share/nvim/mason/bin/:$PATH

export ZSH="/Users/joseendrinal/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(
	git
	virtualenv
	poetry
  tmux
)

source $ZSH/oh-my-zsh.sh

alias ssh='TERM=vt100 ssh'
alias gbclean='git branch | grep -v -e "\(main$\)\|\(dev$\)\|\(staging$\)\|\(master$\)" | xargs git branch -D'
alias ls='exa'
alias cat='bat'
alias solcheck='f() { solana confirm -v --commitment=finalized --output=json $1 | cat | nvim };f'

export CPPFLAGS="-I$(brew --prefix zlib)/include -I$(brew --prefix bzip2)/include -I$(brew --prefix openblas)/include -I$(brew --prefix llvm)/include -I$(brew --prefix openjdk)/include"
export CFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix bzip2)/include -I$(brew --prefix readline)/include -I$(xcrun --show-sdk-path)/usr/include"
export LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix zlib)/lib -L$(brew --prefix bzip2)/lib -L$(brew --prefix openblas)/lib -L$(brew --prefix llvm)/lib"
export DYLD_LIBRARY_PATH="/opt/homebrew/opt/llvm/lib:$DYLD_LIBRARY_PATH"
export OPENSSL_ROOT_DIR="$(brew --prefix openssl)"
export SYSTEM_VERSION_COMPAT=1

. $(brew --prefix asdf)/libexec/asdf.sh

export TERMINFO_DIRS=$TERMINFO_DIRS:$HOME/.local/share/terminfo

eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PNPM_HOME="/Users/joseendrinal/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun
[ -s "/Users/joseendrinal/.bun/_bun" ] && source "/Users/joseendrinal/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export TMUXIFIER_LAYOUT_PATH="$HOME/.config/tmuxifier/.tmux-layouts"
export PATH="$PATH:$HOME/.config/tmux/plugins/tmuxifier/bin"

fpath=($fpath ~/.zsh/completion)

export OPENCODE_HOME="/Users/joseendrinal/.opencode"
case ":$PATH:" in
  *":$OPENCODE_HOME/bin:"*) ;;
  *) export PATH="$OPENCODE_HOME/bin:$PATH" ;;
esac

# java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# android sdk
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# solana
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
