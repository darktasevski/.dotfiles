#!/usr/bin/env bash

if ! declare -p t_debug > /dev/null 2> /dev/null; then
    # shellcheck source=$HOME/.bash.d/core_utils.sh
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

t_debug Use htop if available
if command -v htop > /dev/null; then
    alias top='htop'
fi

# Use Hub if installed. Just using `hub` instead of `which hub` cuts 2 seconds of Cygwin load time
# t_debug Use hub if available
# if /usr/local/bin/hub help > /dev/null 2>&1; then
#     alias git='hub'
# fi

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
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias grep='grep --color=tty -d skip'
alias hh=" history"
alias md="mkdir -p"
alias ping="ping -c 5"
alias rmf='rm -rf'
alias sudo="sudo "                        # makes sudo recognize aliases.
alias t='tail -f'
alias rm='rm -i'
alias mv='mv -i'
alias k9="kill -9"
alias l='ls -lFh'                         #size,show type,human readable
alias la='ls -lAFh'                       #long list,show almost all,show type,human readable
alias lr='ls -tRFh'                       #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'                       #long list,sorted by date,show type,human readable
alias ll='ls -l'                          #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'
alias lsd='ls -1F'                        # ls for Directories.

# Prettyprint some JSON text with a few back-ends, w/ optional CURL:
# - 'json a-url-here' to curl-and-prettify
# - '<command emitting JSON> | json' to just-prettify
function json() {
    # Obtain prettyprinter command string
    if which jq > /dev/null; then
        # Default to using jq as prettyprinter, it's quite nice for that alone
        _pretty="jq -C ."
    else
        # Otherwise, fallback to Python's json module; Python is errywhere.
        _pretty="python -m json.tool"
        # Add pygmentize if it exists. (So, our absolute worst case is
        # pretty-printed, but not colorized. Still useful.)
        if which pygmentize > /dev/null; then
            _pretty="${_pretty} | pygmentize -l json"
        fi
    fi
    
    # Insert a curl if args were given; otherwise assume stdin is being used.
    if [[ -z $1 ]]; then
        eval ${_pretty}
    else
        eval "curl -ks $2 \"$1\" | ${_pretty}"
    fi | less -FR
}

t_debug "aliases: finished setting up node aliases"

t_debug webserver aliases
# webdev
# it's so long because I enabled UTF8 support: https://stackoverflow.com/a/24517632/200987
alias webserver='python -c "import SimpleHTTPServer; m = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map; m['\'\''] = '\''text/plain'\''; m.update(dict([(k, v + '\'';charset=UTF-8'\'') for k, v in m.items()])); SimpleHTTPServer.test();"'
alias servers='sudo lsof -iTCP -sTCP:LISTEN -P -n'

# time
alias epoch=~/.bin/millis #  tool that we compile ourselves

# find external ip
alias my-ip='curl -s http://ipinfo.io/ip'
alias my-ip-json='curl -s http://ifconfig.co/json'
alias myip='ipconfig getifaddr en1 || ipconfig getifaddr en0'

# Used with the git alias functions; gd, gds, gdw, gdws
alias strip-diff-prefix='sed "s/^\([^-+ ]*\)[-+ ]/\\1/"'

# Shortcuts
alias ddl=" cd ~/Downloads"
alias roj="cd ~/Projects"

alias brewup='brew update && brew upgrade'
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

alias bootservices="systemctl list-unit-files | grep enabled"

# Reload the shell (i.e. invoke as a login shell)
alias reload='exec $SHELL -l'

##### Git aliases #####
alias g='git'
alias since='git log --oneline --decorate $(git merge-base --fork-point master)..HEAD'
# Show unmodified tracked files
alias gunm='echo -e "$(git ls-files --modified)\n$(git ls-files)" | sort | uniq -u'
# Nuke files from repo history
alias gnuke='sh ~/.dotfiles/bin/git-nuke.sh'

function gcamp() {
    git commit -a -m "$1" && git push
}

commit_types="feat: (new feature for the user, not a new feature for build script)
fix: (bug fix for the user, not a fix to a build script)
docs: (changes to the documentation)
style: (formatting, missing semicolons, etc; no production code change)
refactor: (refactoring production code, eg. renaming a variable)
test: (adding missing tests, refactoring tests; no production code change)
build: (changes to build tools or CI/CD configuration)
chore: (updating npm scripts etc; no production code change)"

alias cmt='echo $commit_types'

alias nvp='npm version patch'

# SYSTEM RELATED ALIASES :
alias restart="sudo systemctl restart"
alias start="sudo systemctl start"
alias status="sudo systemctl status"
alias stop="sudo systemctl stop"
alias sysinfo='inxi -Fxz'

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
# View HTTP traffic
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Yarn aliases
alias ya="yarn add"
alias ycc="yarn cache clean"
alias yrn="yarn run"
alias yui="yarn upgrade-interactive"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

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
alias gs='git -c color.status=always status -b' # upgrade your git if -sb breaks for you. it's fun.
alias glg='git lg'

function bye-bye-branches() {
  git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D "${branch}"; done
}

# View commits in GitHub
# function gh-commit() {
#     [[ -n $2 ]] && open "https://github.com/$1/commit/$2" && return
#     echo "Usage: gh-commit puritanic/.dotfile fgjdkgbe4"
# }
# function gh-compare() {
#     [[ -n $3 ]] &&  open "https://github.com/$1/compare/$2...$3" \
#     || echo "Usage: gh-compare puritanic/.dotfile fgjdkgbe4 master"
# }

# function tmux-restore () {
#     if [[ -n $1 ]]; then
#         local setup_file="$HOME/.tmux/$1.proj"

#         if [[ -e ${setup_file} ]]; then
#             $(command -v tmux) new-session "tmux $2 source-file $setup_file"
#         else
#             printf "\nNo such file \"$setup_file\".\nListing existing files:\n\n"
#             ls -1 ~/.tmux/*.proj
#             return 1
#         fi
#     else
#         echo "Usage: tmux-restore my-js-setup <optional command>"
#         return 1
#     fi
# }

# https://twitter.com/climagic/status/551435572490010624
# same can be done using VLC => vlc v4l2:///dev/video0
# Use your webcam and mplayer as a mirror with this function.
# function mirror() { mplayer -vf mirror -v tv:// -tv device=/dev/video0:driver=v4l2; }

#make a directory and go on it
function mkcd() { mkdir -p "$@" && eval cd "\"\$$#\""; }

# Creates an archive from given directory
function mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
function mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
function mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# In some cases some zip files are "corrupted"
# https://huit.re/MMnBu4uG
function recover_archive () { jar xvf "$1"; }

# Parse markdown file and print it man page like
function mdless() { pandoc -s -f markdown -t man "$1" | groff -T utf8 -man | less; }

# Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh;
    else
        local arg=-sh;
    fi

    if [[ -n "$*" ]]; then
        du ${arg} -- "$@";
    else
        du ${arg} .[^.]* *;
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

# Lazy Load Implmentation
# Usage: lazy_load(load_cmd, activator, activators... __EOA__ args_activator
# Runs the lazy load command, dealiases all activators and executes the
# activator with the given command line arguments
lazy_load()
{
    load_cmd="$1";shift
    activator="$2";shift

    # Unalias activator aliases since the lazy is about to be run
    local PARSED_ACTIVATORS=false # Whether activators have been parsed
    local ACTIVATOR_ARGS=""
    for arg in $*
    do
        if [[ ${arg} = "__EOA__" ]]
        then
            local PARSED_ACTIVATORS=true
        else
            if ${PARSED_ACTIVATORS}
            then
                # Collect command line arguments for activator command
                ACTIVATOR_ARGS="$ACTIVATOR_ARGS $arg"
            else
                # Remove activator aliases since load command has already run
                unalias "$arg"
            fi
        fi
    done

    # Run Lazy load command
    eval " ${load_cmd}"

    # Run activator with collected command line args
    eval " ${activator} ${ACTIVATOR_ARGS}"
}

# Usage: lazy(load_cmd, activators...)
# Mitigates the unnecessary overhead of the the 'load_cmd' on startup, only
# runs the load command if the user touches any of the 'activators' aliases,
# then which the lazy loader actually loads the load command.
# activators is a space seperated string of activation alias that will cause
# the load command to run, thereafter activator command will run.
#
lazy()
{
    load_cmd="$1"
    shift
    for activator in $*
    do
        # printf required because load command can contain spaces
        # __EOA__ is used to enote end of activators and start of command line arguments for the activators
        load_alias="`printf 'lazy_load "%s" %s %s "__EOA__" \n' "$load_cmd" "$activator" "$*"`"
        alias "$activator"="$load_alias"
    done
}
# Examples:
# lazy load conda
# lazy "source $HOME/.conda/etc/profile.d/conda.sh" conda
# lazy load kubectl completion
# lazy "source <(kubectl completion zsh)" kubectl
# lazy "source <(microk8s.kubectl completion zsh)" microk8s.kubectl

# Heh.
function _lolvim() {
    _msg="THIS AIN'T VIM, BUDDY"
    cowsay $_msg 2>/dev/null || echo $_msg
}
function :wq() { _lolvim }
function :qa() { _lolvim }

# Nice util for listing all declared functions. You use `type` to print them
alias list-functions='declare | egrep '\''^[[:alpha:]][[:alnum:]_]* ()'\''; echo -e "\nTo print a function definition, issue \`type function-name\` "'
alias vim='nvim'

t_debug "global aliases and functions finished"
