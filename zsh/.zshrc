export ZSH=$HOME/.oh-my-zsh

# Path to my dotfiles dir
export DOTFILES_DIR=$(dirname $(readlink -f $HOME/.zshrc))

# zsh settings: https://github.com/ohmyzsh/ohmyzsh/wiki/Settings

# See ~/.oh-my-zsh/themes/
#ZSH_THEME="gozilla"
ZSH_THEME="theunraveler"

local OS=$(uname)
local IS_MACOS=false
plugins=(brew macos wd docker docker-compose aws history)
if [[ "$OS" == "Darwin" ]]; then
    IS_MACOS=true
    plugins+="brew"
    plugins+="macos"
fi
source $ZSH/oh-my-zsh.sh

# Share history across all sessions
setopt SHARE_HISTORY

# Load custom functions
[[ -f $DOTFILES_DIR/functions.zsh ]] && source $DOTFILES_DIR/functions.zsh

# Configure PATH
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin"

# Homebrew
[[ -e /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
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
NVIM_VERSION="0.11.2"
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

# Load global .env file if it exists
#[ -f ~/.env ] && source ~/.env

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
export KEYTIMEOUT=1

# Fuzzy finder
# https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
whence fzf &>/dev/null && source <(fzf --zsh)

[[ -e ${HOME}/.iterm2_shell_integration.zsh ]] && source "${HOME}/.iterm2_shell_integration.zsh"

fpath[1,0]=~/.zsh/completion/

# GPG
export GPG_TTY=$(tty)
whence gpgconf &>/dev/null && gpgconf --launch gpg-agent

# Setup direnv
whence direnv &>/dev/null &&  eval "$(direnv hook zsh)"

# Setup completion
autoload -U +X bashcompinit && bashcompinit

# kubectl autocompletion
whence kubectl &>/dev/null && source <(kubectl completion zsh)
export KUBECTL_EXTERNAL_DIFF="colordiff"

# stern autocompletion
whence stern &>/dev/null && source <(stern --completion zsh)

# stern autocompletion
whence argo &>/dev/null && source <(argo completion zsh)

#helm autocompletion
whence helm &>/dev/null && source <(helm completion zsh)

#istioctl autocompletion
whence istioctl &>/dev/null && source <(istioctl completion zsh)

#terraform autocompletion
whence terraform &>/dev/null && complete -o nospace -C $(whence terraform) terraform

#minio client autocompletion
whence mc &>/dev/null && complete -o nospace -C $(whence mc) mc

if whence brew &>/dev/null; then
    local gcloud_path="$(brew --prefix)/share/google-cloud-sdk"
    [[ $gcloud_path/path.zsh.inc ]] && source $gcloud_path/path.zsh.inc
    [[ $gcloud_path/completion.zsh.inc ]] && source $gcloud_path/completion.zsh.inc
fi

autoload -U colors; colors

function iterm2_print_user_vars() {
  iterm2_set_user_var kubecontext $(kubectl config current-context):$(kubectl config view --minify --output 'jsonpath={..namespace}')
}

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export CODE=$HOME/Code

# Source work specific configs
for conf in $DOTFILES_DIR/work/*.zsh(N); do
    source $conf
done
