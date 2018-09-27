CONFIG_FILE=.itermconfig

# iTerm2 window/tab color commands
function tab-color() {
  echo -ne "\033]6;1;bg;red;brightness;$1\a"
  echo -ne "\033]6;1;bg;green;brightness;$2\a"
  echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

function set-tab-color() {
  if [ -f  $CONFIG_FILE ]; then
    rgb_string=$(awk -F "=" '/tab_color/ {print $2}' $CONFIG_FILE)
    if [ ! -z "$rgb_string" ]; then
      IFS=', ' read -r -A rgb_colors <<< "$rgb_string"
      tab-color ${rgb_colors[1]} ${rgb_colors[2]} ${rgb_colors[3]}
    fi
  fi
}

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}
function new_tmux_from_dir_name() { 
  set-tab-color
  tmux new-session -As `basename $PWD | sed 's/\./-/g'` 
}

function random-rgb {
  echo `jot -r 1  0 255`,`jot -r 1  0 255`,`jot -r 1  0 255`
}

function wiki() {
  tmux new-session -As wiki -n main "nvim -c VimwikiMakeDiaryNote"
}

function generate-random-config {
  echo "tab_color="`random-rgb` > .itermconfig && set-tab-color
}
