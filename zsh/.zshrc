# Path to my dotfiles dir
export DOTFILES_DIR=$(dirname $(readlink -f $HOME/.zshrc))

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history hist_expire_dups_first hist_ignore_dups
setopt hist_ignore_space hist_verify share_history

# Completion
fpath[1,0]=~/.zsh/completion/
source $DOTFILES_DIR/completion.zsh

# Load custom functions
[[ -f $DOTFILES_DIR/functions.zsh ]] && source $DOTFILES_DIR/functions.zsh

# Configure PATH
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin"

# Homebrew
if [[ -e /opt/homebrew/bin/brew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  export HOMEBREW_REPOSITORY="/opt/homebrew"
  fpath+=("/opt/homebrew/share/zsh/site-functions")
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  export MANPATH="/opt/homebrew/share/man:${MANPATH:-}"
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
fi

# Python path
[[ -d ${HOME}/Library/Python/3.11/bin ]] && export PATH="${HOME}/Library/Python/3.11/bin:$PATH"

# touch ID sudo!
[[ -d /usr/local/opt/sudo-touchid/bin ]] && export PATH="$PATH:/usr/local/opt/sudo-touchid/bin"

# Go
if [[ -d /usr/local/go ]]; then
  export GOPATH=/usr/local/go
elif [[ -d $HOME/go ]]; then
  export GOPATH=$HOME/go
fi
[[ -n "$GOPATH" ]] && export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin

# nvim
NVIM_VERSION="0.12.1"
[[ -d /usr/local/nvim/$NVIM_VERSION/bin ]] && export PATH="/usr/local/nvim/$NVIM_VERSION/bin:$PATH"

# flink
FLINK_VERSION="1.18.1"
FLINK_PATH=/usr/local/flink/$FLINK_VERSION
if [[ -d $FLINK_PATH ]]; then
  export FLINK_PATH=$FLINK_PATH
  export PATH="${FLINK_PATH}/bin:$PATH"
fi

#Colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Bat
export MANPAGER='nvim +Man!'

# Set languange environment
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
if whence nvim &>/dev/null; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# Load aliases
[[ -f $DOTFILES_DIR/aliases.zsh ]] && source $DOTFILES_DIR/aliases.zsh

# Set key bindings
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
export KEYTIMEOUT=1

# Fuzzy finder
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
whence fzf &>/dev/null && source <(fzf --zsh)

[[ -e ${HOME}/.iterm2_shell_integration.zsh ]] && source "${HOME}/.iterm2_shell_integration.zsh"

# GPG
export GPG_TTY=$(tty)
whence gpgconf &>/dev/null && gpgconf --launch gpg-agent

# Setup direnv
whence direnv &>/dev/null &&  eval "$(direnv hook zsh)"

export KUBECTL_EXTERNAL_DIFF="colordiff"

function iterm2_print_user_vars() {
  iterm2_set_user_var kubecontext $(kubectl config current-context):$(kubectl config view --minify --output 'jsonpath={..namespace}')
}

sdk() {
  unfunction sdk java javac gradle mvn groovy kotlin
  export SDKMAN_DIR="$HOME/.sdkman"
  source "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk "$@"
}
for cmd in java javac gradle mvn groovy kotlin; do
  eval "$cmd() { sdk; $cmd \"\$@\" }"
done

export CODE=$HOME/Code

# Source work specific configs
for conf in $DOTFILES_DIR/work/*.zsh(N); do
    source $conf
done

source ~/.lcldevrc

# opencode
export PATH=/Users/cmaddalozzo/.opencode/bin:$PATH

# Starship
export STARSHIP_CONFIG=$DOTFILES_DIR/starship.toml
eval "$(starship init zsh)"
