# Functions

# https://twitter.com/climagic/status/551435572490010624
# same can be done using VLC => vlc v4l2:///dev/video0
# Use your webcam and mplayer as a mirror with this function.
function mirror(){ mplayer -vf mirror -v tv:// -tv device=/dev/video0:driver=v4l2; }

#make a directory and go on it
function mkcd(){
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

function test-microphone() {
    arecord -vvv -f dat /dev/null
}

# Creates an archive from given directory
function mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
function mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
function mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

function localip() {
  function _localip() { echo "📶  "$(ipconfig getifaddr "$1"); }
  export -f _localip
  local purple="\x1B\[35m" reset="\x1B\[m"
  networksetup -listallhardwareports | \
    sed -r "s/Hardware Port: (.*)/${purple}\1${reset}/g" | \
    sed -r "s/Device: (en.*)$/_localip \1/e" | \
    sed -r "s/Ethernet Address:/📘 /g" | \
    sed -r "s/(VLAN Configurations)|==*//g"
}

# Parse markdown file and print it man page like
function mdless() {
	pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less
}

function run_ls() {
	ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F
}

# ls for Directories.
function lsd {
    ls -1F $* | grep '/$'
}

function run_dir() {
	dir -i --color=auto -w $(tput cols) "$@"
}

function run_vdir() {
	vdir -i --color=auto -w $(tput cols) "$@"
}
# alias ls="run_ls"
alias dir="run_dir"
alias vdir="run_vdir"

# In some cases some zip files are "corrupted"
# https://huit.re/MMnBu4uG
function recover_archive () {
    jar xvf $1
}

# Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh;
    else
        local arg=-sh;
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@";
    else
        du $arg .[^.]* *;
    fi;
}

# Finding files and directories
function ff() {
        find . -type f -name "*$1*"
}

function fd() {
        find . -type d -name "*$1*"
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
    tree -aC -I '.git' --dirsfirst "$@" | less -FRNX
}

# Git Update/Sync with remote repository
function upr() {
    local repo=$1
    : ${repo:=.}
    cd ${repo} > /dev/null 2>&1
    local repo_dir=$(git rev-parse --show-toplevel)
    local repo_name=$(basename ${repo_dir})
    local padded_repo_name_len=$((${#repo_name}+2))
    local default_branch_name=$(git remote show origin | \grep "HEAD branch" | cut -d ":" -f 2 | tr -d '[:space:]')
    echo
    echo -n "╔"
    printf '═%.0s' {1..${padded_repo_name_len}}
    echo "╗"
    echo "║ $repo_name ║"
    echo -n "╚"
    printf '═%.0s' {1..${padded_repo_name_len}}
    echo "╝"
    local current_branch=$(git rev-parse --abbrev-ref HEAD)

    if [[ "$current_branch" != "$default_branch_name" ]] && [[ "x$current_branch" != "x" ]]; then
        echo Currently on branch ${current_branch}
        git stash
        git checkout ${default_branch_name}
    fi

    if [[ "x$current_branch" != "x" ]]; then
        git pull
        echo "Checking for branches merged to $default_branch_name..."
        git branch --merged | \grep -v "\*" | xargs -n 1 git branch -d
    fi

    git remote prune origin

    cd - > /dev/null 2>&1
}

function look_for_process() {
    local ps_name=$1
    ps aux | ack ${ps_name}
}

alias lfp='look_for_process'

function download-web() {
    wget -r -nH --no-parent --reject='index.html*' "$@" ;
}

function bye-bye-branches() {
  git fetch -p && for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`; do git branch -D ${branch}; done
}

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"


#  ssh + scp without storing or prompting for keys.
function sshtmp
{
    ssh -o "ConnectTimeout 3" \
        -o "StrictHostKeyChecking no" \
        -o "UserKnownHostsFile /dev/null" \
        "$@"
}

function scptmp
{
    exec scp -o "ConnectTimeout 3" \
        -o "StrictHostKeyChecking no" \
        -o "UserKnownHostsFile /dev/null" \
        "$@"
}