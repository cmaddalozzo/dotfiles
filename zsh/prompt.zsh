autoload -U colors && colors
setopt PROMPT_SUBST

function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}

function git_prompt_info() {
  __git_prompt_git rev-parse --git-dir &>/dev/null || return 0
  local ref
  ref=$(__git_prompt_git symbolic-ref --short HEAD 2>/dev/null) \
    || ref=$(__git_prompt_git describe --tags --exact-match HEAD 2>/dev/null) \
    || ref=$(__git_prompt_git rev-parse --short HEAD 2>/dev/null) \
    || return 0
  echo "${ref:gs/%/%%}"
}

function git_prompt_status() {
  local status_text status_prompt
  status_text="$(__git_prompt_git status --porcelain -b 2>/dev/null)" || return
  local -A seen
  [[ "$status_text" =~ '(^|\n)\?\? ' ]] && seen[untracked]=1
  [[ "$status_text" =~ '(^|\n)[AMRT][ MT] |[ AMRT]M ' ]] && seen[modified]=1
  [[ "$status_text" =~ '(^|\n)A  ' ]] && seen[added]=1
  [[ "$status_text" =~ '(^|\n)R  ' ]] && seen[renamed]=1
  [[ "$status_text" =~ '(^|\n)[ ]?D ' ]] && seen[deleted]=1
  [[ "$status_text" =~ '(^|\n)UU ' ]] && seen[unmerged]=1
  (( seen[added] ))     && status_prompt+="%{$fg[cyan]%} ✈"
  (( seen[modified] ))  && status_prompt+="%{$fg[yellow]%} ✭"
  (( seen[deleted] ))   && status_prompt+="%{$fg[red]%} ✗"
  (( seen[renamed] ))   && status_prompt+="%{$fg[blue]%} ➦"
  (( seen[unmerged] ))  && status_prompt+="%{$fg[magenta]%} ✂"
  (( seen[untracked] )) && status_prompt+="%{$fg[grey]%} ✱"
  echo "$status_prompt"
}

PROMPT='%{$fg[magenta]%}[%c] %{$reset_color%}'
RPROMPT='%{$fg[magenta]%}$(git_prompt_info)%{$reset_color%} $(git_prompt_status)%{$reset_color%}'
