
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

#Load tractable functions
source $HOME/tractable/cli-tools/shell/functions.zsh

# Configure PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin"

# Python path
export PATH="${HOME}/Library/Python/3.6/bin:$PATH"

# Python user path
export PATH="${HOME}/.local/bin:$PATH"
export PIPENV_VENV_IN_PROJECT=1

# touch ID sudo!
export PATH="$PATH:/usr/local/opt/sudo-touchid/bin"

#Kafka
export PATH=$PATH:/Users/cmadd/.kafka/current/bin

#Tractable tools
export PATH="/Users/cmadd/tractable/cli-tools/bin:$PATH"

# Depot tools
export PATH="$PATH:/Users/cmadd/Code/depot_tools"

# JPEG Turbo
export PATH="/usr/local/opt/jpeg-turbo/bin:$PATH"

# Bazel
export PATH="${HOME}/bin:$PATH"

# EB cli
export PATH="/Users/cmadd/.ebcli-virtual-env/executables:$PATH"

# Rust
source ~/.cargo/env

# Go
export PATH="/usr/local/go/bin:/Users/cmadd/go/bin:$PATH"
export GOPATH="${HOME}/go"

# nvim
export PATH="/usr/local/nvim/0.6.1/bin:$PATH"

export PATH="$PATH:/usr/local/opt/llvm/bin"

#Colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Load global .env file if it exists
[ -f ~/.env ] && source ~/.env

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

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

# Virtualenvwrapper init
#if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
#  export VIRTUALENVWRAPPER_PYTHON='/usr/local/bin/python3'
#  export WORKON_HOME=~/.virtualenvs
#  source /usr/local/bin/virtualenvwrapper.sh
#fi

# Load NVM
export NVM_DIR="/Users/cmadd/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

fpath[1,0]=~/.zsh/completion/

# Setup direnv
eval "$(direnv hook zsh)"

# show_virtual_env() {
#   if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
#     echo "($(basename $VIRTUAL_ENV))"
#   fi
# }
# PS1='$(show_virtual_env)'$PS1

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
[[ -f /Users/cmadd/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh ]] && . /Users/cmadd/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh

# kubectl autocompletion
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
export KUBECTL_EXTERNAL_DIFF="colordiff"

export ARGOCD_OPTS='--grpc-web'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

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

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/mc mc

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/google-cloud-sdk/completion.zsh.inc'; fi
