# Functions

# https://twitter.com/climagic/status/551435572490010624
# same can be done using VLC => vlc v4l2:///dev/video0
# Use your webcam and mplayer as a mirror with this function.
mirror(){ mplayer -vf mirror -v tv:// -tv device=/dev/video0:driver=v4l2; }

#make a directory and go on it
function mkcd(){
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

test-microphone() {
    arecord -vvv -f dat /dev/null
}

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

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

run_ls() {
	ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F
}

run_dir() {
	dir -i --color=auto -w $(tput cols) "$@"
}

run_vdir() {
	vdir -i --color=auto -w $(tput cols) "$@"
}
# alias ls="run_ls"
alias dir="run_dir"
alias vdir="run_vdir"

# In some cases some zip files are "corrupted"
# https://huit.re/MMnBu4uG
recover_archive () {
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

# Git Update/Sync with remote repository
upr() {
    local repo=$1
    : ${repo:=.}
    cd $repo > /dev/null 2>&1
    local repo_dir=$(git rev-parse --show-toplevel)
    local repo_name=$(basename $repo_dir)
    local padded_repo_name_len=$((${#repo_name}+2))
    local default_branch_name=$(git remote show origin | \grep "HEAD branch" | cut -d ":" -f 2 | tr -d '[:space:]')
    echo
    echo -n ╔
    printf '═%.0s' {1..$padded_repo_name_len}
    echo ╗
    echo "║ $repo_name ║"
    echo -n ╚
    printf '═%.0s' {1..$padded_repo_name_len}
    echo ╝
    local current_branch=$(git rev-parse --abbrev-ref HEAD)
    if [ "$current_branch" != "$default_branch_name" ] && [ "x$current_branch" != "x" ]; then
        echo Currently on branch $current_branch
        git stash
        git checkout $default_branch_name
    fi

    if [ "x$current_branch" != "x" ]; then
        git pull
        echo "Checking for branches merged to $default_branch_name..."
        git branch --merged | \grep -v "\*" | xargs -n 1 git branch -d
    fi

    git remote prune origin

    cd - > /dev/null 2>&1
}

look_for_process() {
    local ps_name=$1
    ps aux | ack $ps_name
}

alias lfp='look_for_process'