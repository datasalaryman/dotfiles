# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/opt/homebrew/bin:/opt/homebrew/opt/node@18/bin:$HOME/.gcloud/bin:$HOME/.pyenv/shims:$PATH
export PYENV_ROOT="$HOME/.pyenv"

# Path to your oh-my-zsh installation.
export ZSH="/Users/joseendrinal/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	virtualenv
	poetry
  tmux
)

# ZSH_TMUX_AUTOSTART=true

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ssh='TERM=vt100 ssh'
alias gbclean='git branch | grep -v -e "\(main$\)\|\(dev$\)\|\(staging$\)\|\(master$\)" | xargs git branch -D'
alias ls='exa'
alias cat='bat'
alias solcheck='f() { solana confirm -v --commitment=finalized --output=json $1 | cat | nvim };f'

# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
#   eval "$(pyenv virtualenv-init -)"
# fi

export CPPFLAGS="-I$(brew --prefix zlib)/include -I$(brew --prefix bzip2)/include -I$(brew --prefix openblas)/include -I$(brew --prefix node@18)/include -I$(brew --prefix llvm)/include -I$(brew --prefix openjdk)/include"
export CFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix bzip2)/include -I$(brew --prefix readline)/include -I$(xcrun --show-sdk-path)/usr/include"
export LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix zlib)/lib -L$(brew --prefix bzip2)/lib -L$(brew --prefix openblas)/lib -L$(brew --prefix node@18)/lib -L$(brew --prefix llvm)/lib"
export OPENSSL_ROOT_DIR="$(brew --prefix openssl)"


# export PKG_CONFIG_PATH="$(brew --prefix openblas)/lib/pkgconfig"


export SYSTEM_VERSION_COMPAT=1

# fpath+=~/.zfunc
# autoload -Uz compinit && compinit

# load rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - --no-rehash)"
eval "$(fnm env --use-on-cd)"

# Add solana to path
# export PATH="/Users/joseendrinal/.local/share/solana/install/active_release/bin:$PATH"
export PATH="$(brew --prefix openjdk)/bin:$PATH"

. $(brew --prefix asdf)/libexec/asdf.sh

export TERMINFO_DIRS=$TERMINFO_DIRS:$HOME/.local/share/terminfo

eval "$(zoxide init zsh)"

. $HOME/.nvm/nvm.sh
. $HOME/.nvm/bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TEMM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux new-session -A -s default
# fi

# pnpm
export PNPM_HOME="/Users/joseendrinal/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

# bun completions
[ -s "/Users/joseendrinal/.bun/_bun" ] && source "/Users/joseendrinal/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export TMUXIFIER_LAYOUT_PATH="$HOME/.config/tmuxifier/.tmux-layouts"

export PATH="$PATH:$HOME/.config/tmux/plugins/tmuxifier/bin"

ZSH_TMUX_DEFAULT_SESSION_NAME=default

ZSH_TMUX_CONFIG=$HOME/.config/tmux/tmux.conf