CONFIG_FILE=.itermconfig

# iTerm2 window/tab color commands
tab-color() {
  echo -ne "\033]6;1;bg;red;brightness;$1\a"
  echo -ne "\033]6;1;bg;green;brightness;$2\a"
  echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

set-tab-color() {
  if [ -f  $CONFIG_FILE ]; then
    rgb_string=$(awk -F "=" '/tab_color/ {print $2}' $CONFIG_FILE)
    if [ ! -z "$rgb_string" ]; then
      IFS=', ' read -r -A rgb_colors <<< "$rgb_string"
      tab-color ${rgb_colors[1]} ${rgb_colors[2]} ${rgb_colors[3]}
    fi
  fi
}
