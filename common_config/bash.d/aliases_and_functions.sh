#!/usr/bin/env bash

if ! declare -p t_debug > /dev/null 2> /dev/null; then
    source ~/.bash.d/core_utils.sh
fi

t_debug "Reading aliases and functions"

function is_mac() {
  cmd=$(command -v uname)
  
  if [[ -z ${cmd} ]];then
    return 1
  else
    # dynamically redefines the function definition to avoid recomputing 
    if ${cmd} |grep Darwin 1>/dev/null; then
        is_mac(){ return 0; };
    else 
        is_mac(){ return 1; };
    fi
  fi
}

# Bash setup
alias edit-rc="vim ~/.bashrc"
alias edit-alias="vim ~/.bash.d/aliases_and_functions.sh"
alias source-rc="source ~/.bashrc"
alias source-alias="source ~/.bash.d/aliases_and_functions.sh"

alias editzsh="vim ~/.zshrc"
alias editvim="vim ~/.vimrc"

# Conversions
t_debug conversions
# URL-encode strings
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias htmldecode='python -c "import sys, HTMLParser;h = HTMLParser.HTMLParser();print h.unescape(sys.argv[1])"'
alias htmlencode='python3 -c "import sys, html; print(html.escape(sys.argv[1]))"'
alias html2text='python -c "import sys,html2text;sys.stdout.write(html2text.html2text(sys.stdin.read().decode(\"utf-8\")))"'

t_debug Use htop if available
if command -v htop > /dev/null; then
    alias top='htop'
fi

# Use Hub if installed. Just using `hub` instead of `which hub` cuts 2 seconds of Cygwin load time
t_debug Use hub if available
if /usr/local/bin/hub help > /dev/null 2>&1; then
    alias git='hub'
fi

t_debug Add custom ignore pattern for GNU ls
IGNORE=""
if ! is_mac; then
  #ignore patterns
  for i in '*~' '*.pyc'; do 
      IGNORE="$IGNORE --ignore=$i"
  done
fi

alias ls='/bin/ls $IGNORE'

t_debug small utils and aliases
alias c=" clear"
alias clean-temp='find -E ~ -type f -and -regex ".*~$|.*-ck.js|.*.tmp" -exec rm {} \;'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias grep='grep --color=tty -d skip'
alias hh=" history"
alias mkdir="mkdir -p"
alias ping="ping -c 5"
alias rmf='rm -rf'
alias sudo="sudo "                        # makes sudo recognize aliases.
alias t='tail -f'
alias rm='rm -i'
alias mv='mv -i'

alias l='ls -lFh'                         #size,show type,human readable
alias la='ls -lAFh'                       #long list,show almost all,show type,human readable
alias lr='ls -tRFh'                       #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'                       #long list,sorted by date,show type,human readable
alias ll='ls -l'                          #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'

alias prettify_json='python -mjson.tool'  # Pretty print json

# Indent text before sending it to Stack Overflow
alias indent4="sed -E 's/(^.*)/    \1/'"
alias remove-indent4="sed -E 's/^    //'"

t_debug "aliases: setting up node aliases"
# node commands - important that these are enclosed in single quotes to avoid expansion!
alias npm-exec='PATH=$(npm bin):$PATH'
alias eslint='$(npm bin)/eslint'
alias prettier='$(npm bin)/prettier'

t_debug "aliases: finished setting up node aliases"

t_debug webserver aliases
# webdev
# it's so long because I enabled UTF8 support: https://stackoverflow.com/a/24517632/200987
alias webserver='python -c "import SimpleHTTPServer; m = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map; m['\'\''] = '\''text/plain'\''; m.update(dict([(k, v + '\'';charset=UTF-8'\'') for k, v in m.items()])); SimpleHTTPServer.test();"'
alias servers='sudo lsof -iTCP -sTCP:LISTEN -P -n'

# time
alias epoch=millis #  tool that we compile ourselves

# find external ip
alias my-ip='curl -s http://ipinfo.io/ip'
alias my-ip-json='curl -s http://ifconfig.co/json'

alias myip='ipconfig getifaddr en1 || ipconfig getifaddr en0'
alias dig-ip="dig +short myip.opendns.com @resolver1.opendns.com"

function localip() {
  function _localip() { echo "📶  " "$(ipconfig getifaddr "$1")"; }
  export -f _localip
  local purple="\x1B\[35m" reset="\x1B\[m"
  networksetup -listallhardwareports | \
    sed -E "s/Hardware Port: (.*)/${purple}\1${reset}/g" | \
    sed -E "s/Device: (en.*)$/_localip \1/e" | \
    sed -E "s/Ethernet Address:/📘 /g" | \
    sed -E "s/(VLAN Configurations)|==*//g"
}

# SOCKS proxy
alias socks_proxy='ssh -v -D 22222 carl-erik@timbuktu.kopseng.no -N'
alias socks_proxy_all='ssh -v -D :22222 carl-erik@timbuktu.kopseng.no -N'

# Used with the git alias functions; gd, gds, gdw, gdws
alias strip-diff-prefix='sed "s/^\([^-+ ]*\)[-+ ]/\\1/"' 

# For stack overflow pasting
alias stack-overflow-no-copy='sed -e "s/diffia/ACME/g" -e "s/$USER/myuser/g" | indent4 '
alias stack-overflow='stack-overflow-no-copy | pbcopy; pbpaste; echo -e "\n\nCopied to pastebuffer (use stack-overflow-no-copy to avoid this)!"'

# "reminder aliases" for how to suspend and continue a process
alias processes-suspend='killall -sSTOP '
alias processes-start='killall -sSTART '

# Shortcuts
alias dwl=" cd ~/Downloads"
alias roj="cd ~/Projects"

alias brewup='brew update && brew upgrade'
alias fact="elinks -dump randomfunfacts.com | sed -n '/^| /p' | tr -d \|"
alias tree='tree -C -I $(git check-ignore * 2>/dev/null | tr "\n" "|").git'
# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() { tree -aC -I '.git' --dirsfirst "$@" | less -FRNX; }

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'
# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

#### those are for linux ####
# Set keyboard layout
alias keybhr='setxkbmap hr'
alias keybus='setxkbmap us'
# Dump pacman orphans
alias rem-orphans='pacman -Rs $(pacman -Qqdt)'

alias bootservices="systemctl list-unit-files | grep enabled"
alias fixit='sudo rm -f /var/lib/pacman/db.lck && sudo pacman-mirrors -g && sudo pacman -Syyuu  && sudo pacman -Suu'

# Reload the shell (i.e. invoke as a login shell)
alias reload='exec $SHELL -l'

##### Git aliases #####
alias gcu='git gc --aggressive' # Cleanup unnecessary files and optimize the local repository
alias gdi='git diff --ignore-all-space'
alias gdw='git diff --color-words'
alias gits='git status -uno'
alias glr='git rev-list --left-right --count master...' # Lists commit objects in reverse chronological order
alias gmb='git merge-base $(current_branch) master'  # Find as good common_config ancestors as possible for a merge
alias gpoh='git push origin HEAD'
alias gst='git status --short --branch'
alias upfork='git fetch upstream; git checkout master; git merge upstream/master'
# View abbreviated SHA, description, history graph, time and author
alias glog='git log --color --graph --date=iso --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci) %C(bold blue)<%an>%Creset" --abbrev-commit --'
# Show a formatted commit tree
alias gtree="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias since='git log --oneline --decorate $(git merge-base --fork-point master)..HEAD'
# Show unmodified tracked files
alias gunm='echo -e "$(git ls-files --modified)\n$(git ls-files)" | sort | uniq -u'
# Nuke files from repo history
alias gnuke='sh ~/.dotfiles/bin/git-nuke.sh'

alias nvp='npm version patch'

#SYSTEM RELATED ALIASES :
alias restart="sudo systemctl restart"
alias start="sudo systemctl start"
alias status="sudo systemctl status"
alias stop="sudo systemctl stop"
alias sys-info='inxi -Fxz'
alias view_recent_alerts='sudo journalctl -p err..alert -b'
# happens so often that it requires alias on its own...
alias dock-restart='pkill dde-dock & dde-dock'

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Yarn aliases
alias ya="yarn add"
alias yanl="yarn add --no-lockfile"
alias ycc="yarn cache clean"
alias yh="yarn help"
alias yo="yarn outdated"
alias yrm="yarn remove"
alias yrn="yarn run"
alias yui="yarn upgrade-interactive"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Docker
# alias dockerps='docker ps --format=$FORMAT'
# alias dockerconc='docker ps -aq --no-trunc | xargs docker rm'
# alias dockerLamp='docker run -v /work/Docker:/var/www/example.com/public_html -p 80:80 -t -i linode/lamp /bin/bash'
# alias dklc='docker ps -l'  # List last Docker container
# alias dklcid='docker ps -l -q'  # List last Docker container ID
# alias dklcip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)'  # Get IP of last Docker container
# alias dkps='docker ps'  # List running Docker containers
# alias dkpsa='docker ps -a'  # List all Docker containers
# alias dki='docker images'  # List Docker images
# alias dkrmac='docker rm $(docker ps -a -q)'  # Delete all Docker containers
# alias dkrmlc='docker-remove-most-recent-container'  # Delete most recent (i.e., last) Docker container
# alias dkrmui='docker images -q -f dangling=true |xargs -r docker rmi'  # Delete all untagged Docker images
# alias dkrmall='docker-remove-stale-assets'  # Delete all untagged images and exited containers
# alias dkrmli='docker-remove-most-recent-image'  # Delete most recent (i.e., last) Docker image
# alias dkrmi='docker-remove-images'  # Delete images for supplied IDs or all if no IDs are passed as arguments
# alias dkideps='docker-image-dependencies'  # Output a graph of image dependencies using Graphiz
# alias dkre='docker-runtime-environment'  # List environmental variables of the supplied image ID
# alias dkelc='docker exec -it `dklcid` bash' # Enter last container (works with Docker 1.3 and above)

function psgrep() { ps -ef | grep -i "$@"; }

# Trims whitespace at start and end of line
alias trim="sed '/^[[:space:]]*$/d'"

# Trims whitespace
# Source: https://unix.stackexchange.com/questions/102008/how-do-i-trim-leading-and-trailing-whitespace-from-each-line-of-some-output
function trimWS(){ awk '{$1=$1};1'; }

### Snitch and Snatch should be refactored so that they can work on OSX too ###
# Find which program is using a port, works in reverse as well
# Eg. `snitch 8080` or `snitch node`
function snitch() {
	if is_mac; then
		lsof -nPi | grep "$1" | tail -n 2
	else
	 	netstat -tulpn | grep "$1" | tail -n 2 
	fi
}
# Kill the program using a specified port
# Eg. `snatch 8080`
function snatch() { kill -9 "$(netstat -tulpn 2>/dev/null | grep "$1" | awk '{print $7}' | cut -d / -f 1)"; }

function look_for_process() {
    local ps_name=$1
    ps aux | ack "${ps_name}"
}

# Based on https://stackoverflow.com/a/12579554/200987
function remove-last-newline(){
    local file
    file=$(mktemp)
    cat > "${file}"
    if [[ $(tail -c1 "$file" | wc -l) == 1 ]]; then
        head -c -1 "${file}" > "${file}".tmp
        mv "${file}".tmp "${file}"
    fi
    cat "${file}"
    rm "${file}"&
}


# System shortcuts
alias apt='sudo apt' # Need Java for this

# Restore the original system path if for some reason some 
# command in your ~/bin directory does not work
function restore_path() {
        PATH="${ORIGINAL_PATH}"
        export PATH;
}

# Zach Holman's git aliases converted to functions for more flexibility
#   @see https://github.com/holman/dotfiles/commit/2c077a95a610c8fd57da2bd04aa2c85e6fd37b7c#diff-4335824c6d289f1b8b41f7f10bf3a2e7
#   Being functions allow them to take arguments, such as additional options or filenames
#
#   The -r flag to `less` is uses to make it work with the color escape codes
#   @depends on strip-diff-prefix alias
function gd() {   git diff          --color "$@"| strip-diff-prefix | less -r; }
function gds() {  git diff --staged --color "$@"| strip-diff-prefix | less -r; }
function gdw() {  git diff          --color --word-diff "$@"        | less -r; }
function gdws() { git diff --staged --color --word-diff "$@"        | less -r; }
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias glg='git lg'

function bye-bye-branches() {
  git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D "${branch}"; done
}

# View commits in GitHub 
function gh-commit() {
    [[ -n $2 ]] && open "https://github.com/$1/commit/$2" && return
    echo "Usage: gh-commit fatso83/razor-cli-node 779490"
}
function gh-compare() {
    [[ -n $3 ]] &&  open "https://github.com/$1/compare/$2...$3" \
    || echo "Usage: gh-compare fatso83/razor-cli-node 779490 master"
}

function tmux-restore () {
    if [[ -n $1 ]]; then
        local setup_file="$HOME/tmux/$1.proj"

        if [[ -e ${setup_file} ]]; then
            $(command -v tmux) new-session "tmux $2 source-file $setup_file"
        else
            printf "\nNo such file \"$setup_file\".\nListing existing files:\n\n"
            ls -1 ~/.tmux/*.proj
            return 1
        fi
    else
        echo "Usage: tmux-restore my-js-setup <optional command>"
        return 1
    fi
}

# https://twitter.com/climagic/status/551435572490010624
# same can be done using VLC => vlc v4l2:///dev/video0
# Use your webcam and mplayer as a mirror with this function.
function mirror() { mplayer -vf mirror -v tv:// -tv device=/dev/video0:driver=v4l2; }

#make a directory and go on it
function mkcd() { mkdir -p "$@" && eval cd "\"\$$#\""; }
function test-microphone() { arecord -vvv -f dat /dev/null; }

# Creates an archive from given directory
function mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
function mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
function mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# In some cases some zip files are "corrupted"
# https://huit.re/MMnBu4uG
function recover_archive () { jar xvf "$1"; }

# Parse markdown file and print it man page like
function mdless() { pandoc -s -f markdown -t man "$1" | groff -T utf8 -man | less; }

# ls for Directories.
function lsd { ls -1F "$*" | grep '/$'; }

# Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh;
    else
        local arg=-sh;
    fi

    if [[ -n "$*" ]]; then
        du $arg -- "$@";
    else
        du $arg .[^.]* *;
    fi
}

# Finding files and directories
function ff() { find . -type f -name "*$1*"; }
function fd() { find . -type d -name "*$1*"; }

function download-web() { wget -r -nH --no-parent --reject='index.html*' "$@"; }

#  ssh + scp without storing or prompting for keys.
function sshtmp() {
    ssh -o "ConnectTimeout 3" \
        -o "StrictHostKeyChecking no" \
        -o "UserKnownHostsFile /dev/null" \
        "$@";
}

function scptmp() {
    exec scp -o "ConnectTimeout 3" \
        -o "StrictHostKeyChecking no" \
        -o "UserKnownHostsFile /dev/null" \
        "$@";
}

# Nice util for listing all declared functions. You use `type` to print them
alias list-functions='declare | egrep '\''^[[:alpha:]][[:alnum:]_]* ()'\''; echo -e "\nTo print a function definition, issue \`type function-name\` "'

t_debug "global aliases and functions finished"

