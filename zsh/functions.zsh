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
  if [ ! -f  $CONFIG_FILE ]; then
    generate-random-config
  fi
  set-tab-color
  sess=$(basename $PWD | sed 's/\./-/g')
  tmux has-session -t $sess 2>/dev/null
  if [ $? != 0 ]; then
    # Set up our session
    tmux new-session -dAs $sess \; split-window -h \; split-window -v \; attach
  else
    tmux attach -t $sess
  fi
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

function unset_aws_creds(){
  unset AWS_SESSION_TOKEN
  unset AWS_SECURITY_TOKEN
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_ACCESS_KEY_ID
  unset AWS_DEFAULT_PROFILE
  unset ASSUMED_ROLE
}

function get_mfa_token() {
  mfa_key="HGNDIOQVYJ7FYXMI5JZVMJ5GWWWJ5GZXHHHOI3BVFIFUWGGY4MKDH2HP2PBOQWI3"
  oathtool --totp -b -d 6 $mfa_key
}

function get_google_mfa_token() {
  mfa_key="dcy7 loxk npfw efnm ctq4 57td a2sp wlnh"
  oathtool --totp -b -d 6 $mfa_key
}

function export_aws_mfa_temp_creds() {
  profile=${1:-dev}
  export AWS_ACCESS_KEY_ID=$(aws --profile $profile configure get aws_access_key_id)
  export AWS_SECRET_ACCESS_KEY=$(aws --profile $profile configure get aws_secret_access_key)
  export AWS_SESSION_TOKEN=$(aws --profile $profile configure get aws_session_token)
}

# get_aws_mfa_temp_creds() {
#   echo 'export AWS_ACCESS_KEY_ID='$(jq -r '.Credentials.AccessKeyId' $cred_file)
#   echo 'export AWS_SECRET_ACCESS_KEY='$(jq -r '.Credentials.SecretAccessKey' $cred_file)
#   echo 'export AWS_SESSION_TOKEN='$(jq -r '.Credentials.SessionToken' $cred_file)
# }

function get_aws_creds_python() {
  echo "os.environ['AWS_ACCESS_KEY_ID'] = '${AWS_ACCESS_KEY_ID}'"
  echo "os.environ['AWS_SECRET_ACCESS_KEY'] = '${AWS_SECRET_ACCESS_KEY}'"
  echo "os.environ['AWS_SESSION_TOKEN'] = '${AWS_SESSION_TOKEN}'"
}

function get_aws_creds() {
  echo "export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
  echo "export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
  echo "export AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}"
}

function get_aws_creds_k8s() {
  echo "- name: AWS_ACCESS_KEY_ID"
  echo "  value: '${AWS_ACCESS_KEY_ID}'"
  echo "- name: AWS_SECRET_ACCESS_KEY"
  echo "  value: '${AWS_SECRET_ACCESS_KEY}'"
  echo "- name: AWS_SESSION_TOKEN"
  echo "  value: '${AWS_SESSION_TOKEN}'"
}

function rename {
    if [ "$#" -ne 2 ]; then
        echo "Usage: $0 source name" >&2
        return
    fi
    if [ ! -f "$1" ]; then
        echo "First argument must be a file"
        return
    fi
    dir=$(dirname $1)
    mv $1 $dir/$2
}

function no_proxy {
  unset HTTP_PROXY;
  unset http_proxy;
  unset https_proxy;
  unset HTTPS_PROXY;
  unset ALL_PROXY;
}
