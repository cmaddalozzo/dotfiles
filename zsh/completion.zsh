zmodload -i zsh/complist
autoload -Uz compinit && compinit -C
autoload -U +X bashcompinit && bashcompinit

setopt auto_menu complete_in_word always_to_end
unsetopt menu_complete flowcontrol

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compcache"

# Cached completions for slow CLI tools
# Regenerate with: cache-completions
local _comp_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions"
mkdir -p "$_comp_cache"
fpath=("$_comp_cache" $fpath)

function cache-completions() {
  whence kubectl &>/dev/null && kubectl completion zsh > "$_comp_cache/_kubectl"
  whence stern &>/dev/null && stern --completion zsh > "$_comp_cache/_stern"
  whence argo &>/dev/null && argo completion zsh > "$_comp_cache/_argo"
  whence helm &>/dev/null && helm completion zsh > "$_comp_cache/_helm"
  whence istioctl &>/dev/null && istioctl completion zsh > "$_comp_cache/_istioctl"
  echo "Completions cached to $_comp_cache"
}

whence terraform &>/dev/null && complete -o nospace -C $(whence terraform) terraform
whence mc &>/dev/null && complete -o nospace -C $(whence mc) mc

if [[ -e /opt/homebrew/share/google-cloud-sdk ]]; then
    local gcloud_path="/opt/homebrew/share/google-cloud-sdk"
    [[ $gcloud_path/path.zsh.inc ]] && source $gcloud_path/path.zsh.inc
    [[ $gcloud_path/completion.zsh.inc ]] && source $gcloud_path/completion.zsh.inc
fi
