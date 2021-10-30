alias ls='ls -lFA'

alias sum='awk '\''{s+=$1} END {print s}'\'

alias cat='ccat --bg=dark'
alias tarx='tar -xzf'
alias tarc='tar -czf'

alias diff='colordiff'

alias tn='tmux new -s'
alias tml='tmux ls'
alias tma='tmux a -t'

alias greph='history | grep'

alias tnew='new_tmux_from_dir_name'
alias tm='tnew'

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

alias mocha='$(npm bin)/mocha'
alias tsc='$(npm bin)/tsc'
alias tslint='$(npm bin)/tslint'
alias eslint='$(npm bin)/eslint'
alias babel-node='$(npm bin)/babel-node'
alias ts-node='$(npm bin)/ts-node'

alias pbp='pbpaste'
alias pbc='pbcopy'

alias pbj='pbpaste | jq'

alias vimm='mvim'
alias vim='nvim'

alias vimrc='vim ~/.config/nvim/init.vim'

alias venv='python3 -m venv'

alias activate='source venv/bin/activate'

# Kubernetes
alias k=kubectl

alias kafkacat=kcat

# Bat highlighting
alias cyaml='bat -l yaml'
alias cjson='bat -l json'
alias cjson='bat -l json'
alias ccsv='bat -l csv'
