export ZSH=$HOME/.oh-my-zsh

# Path to my dotfiles dir
export DOTFILES_DIR=$HOME/Code/dotfiles

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="theunraveler"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(brew npm macos wd docker docker-compose aws history npm fzf-tab)
source $ZSH/oh-my-zsh.sh

setopt SHARE_HISTORY

# Load custom functions
source $DOTFILES_DIR/zsh/functions.zsh

# Configure PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:$HOME/.local/bin"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

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
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
export PATH=/opt/homebrew/opt/go@1.23/bin:$PATH

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

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Load aliases
source $DOTFILES_DIR/zsh/aliases.zsh

#bindkey -v

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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

fpath[1,0]=~/.zsh/completion/

# GPG
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# Setup direnv
eval "$(direnv hook zsh)"

# kubectl autocompletion
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
export KUBECTL_EXTERNAL_DIFF="colordiff"

# stern autocompletion
[[ $HOME/.local/bin/stern ]] && source <(stern --completion zsh)

# stern autocompletion
[[ $HOME/.local/bin/argo ]] && source <(argo completion zsh)

# helm autocompletion
[[ $HOME/.local/bin/helm ]] && source <(helm completion zsh)

# istioctl autocompletion
[[ $HOME/.local/bin/istioctl ]] && source <(istioctl completion zsh)


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Krew
export PATH="${PATH}:${HOME}/.krew/bin"

# pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#if command -v pyenv 1>/dev/null 2>&1; then
#  eval "$(pyenv init --path)"
#fi
#
#if which pyenv-virtualenv-init > /dev/null; then
#    eval "$(pyenv virtualenv-init -)"
#fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

autoload -U colors; colors

# kubectl context prompt
#source /opt/homebrew/etc/zsh-kubectl-prompt/kubectl.zsh
#RPROMPT="$RPROMPT%{$fg[magenta]%}- $ZSH_KUBECTL_CONTEXT%{$reset_color%}"
#RPROMPT='%{$fg[blue]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'

function iterm2_print_user_vars() {
  iterm2_set_user_var kubecontext $(kubectl config current-context):$(kubectl config view --minify --output 'jsonpath={..namespace}')
}
test -e $HOME/.iterm2_shell_integration.zsh && \
    source $HOME/.iterm2_shell_integration.zsh || true
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/mc mc

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export CODE=$HOME/Code

source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

complete -o nospace -C /Users/cmaddalozzo/.local/bin/terraform terraform

# Source work specific configs
for conf in $DOTFILES_DIR/zsh/work/*.zsh(N); do
    source $conf
done
