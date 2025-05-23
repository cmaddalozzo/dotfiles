export ZSH=$HOME/.oh-my-zsh

# Path to my dotfiles dir
export DOTFILES_DIR=$HOME/Code/dotfiles

# zsh settings: https://github.com/ohmyzsh/ohmyzsh/wiki/Settings

# See ~/.oh-my-zsh/themes/
ZSH_THEME="theunraveler"

local OS=$(uname)
local IS_MACOS=false
plugins=(brew macos wd docker docker-compose aws history fzf-tab)
if [[ "$OS" == "Darwin" ]]; then
    IS_MACOS=true
    plugins+="brew"
    plugins+="macos"
fi
source $ZSH/oh-my-zsh.sh

# Share history across all sessions
setopt SHARE_HISTORY

# Load custom functions
source $DOTFILES_DIR/zsh/functions.zsh

# Configure PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:$HOME/.local/bin"

# Homebrew
[[ -e /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Python path
export PATH="${HOME}/Library/Python/3.11/bin:$PATH"

# touch ID sudo!
export PATH="$PATH:/usr/local/opt/sudo-touchid/bin"

# Go
if [[ -d /usr/local/go ]]; then
  export GOPATH=/usr/local/go
elif [[ -d $HOME/go ]]; then
  export GOPATH=$HOME/go
fi
if [[ -n "$GOPATH" ]]; then
  export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
fi

# nvim
NVIM_VERSION="0.11.0"
export PATH="/usr/local/nvim/$NVIM_VERSION/bin:$PATH"

# flink
FLINK_VERSION="1.18.1"
export FLINK_PATH=/usr/local/flink/$FLINK_VERSION
export PATH="${FLINK_PATH}/bin:$PATH"

#Colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Bat
export MANPAGER='nvim +Man!'

# Load global .env file if it exists
[ -f ~/.env ] && source ~/.env

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
source $DOTFILES_DIR/zsh/aliases.zsh

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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

[[ -e ${HOME}/.iterm2_shell_integration.zsh ]] && source "${HOME}/.iterm2_shell_integration.zsh"

fpath[1,0]=~/.zsh/completion/

# GPG
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# Setup direnv
eval "$(direnv hook zsh)"

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

if whence brew; then
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
for conf in $DOTFILES_DIR/zsh/work/*.zsh(N); do
    source $conf
done
