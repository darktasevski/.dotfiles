# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Point to Yarn global installs, enable if there are problems
# export PATH="$PATH:$(yarn global bin)"

# Path to your oh-my-zsh installation.
export ZSH=/home/puritanic/.oh-my-zsh

export BROWSER=/usr/bin/chromium
export EDITOR='vim'

export GPG_TTY=$(tty)

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Always enable colored `grep` output.
export GREP_OPTIONS='--color=auto';

# no lag on normal / insert mode switch   # see http://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1

# Start X at login for Arch boxes
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]] ; then
    if hash startx 2>& /dev/null; then
        startx && logout
    fi
fi

# enable color support of ls and file types
if [ "$TERM" != "dumb" ]; then
        eval "`dircolors -b ~/.config/dircolors/dircolorsrc_srs`"
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
fi

# Set Zsh options
setopt AUTO_CD
setopt correct
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh_history
#man pages
# example: run-help crypt shows crypt man pages
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Use zsh-completions if it exists
if [[ -d "/usr/local/share/zsh-completions" ]]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# make tab complete work  - https://github.com/robbyrussell/oh-my-zsh/issues/943
# This will make it not show a list for single options
zstyle '*' single-ignored complete

 # OH-MY-ZSH SETTINGS (Define these before loading oh-my-zsh or it won't work)
COMPLETION_WAITING_DOTS="true"

# Load Antigen

## Check if Antigen is installed
if [[ ! -d ~/.antigen ]]; then
  mkdir ~/.antigen
  curl -L git.io/antigen > ~/.antigen/antigen.zsh
fi

source /home/puritanic/.antigen/antigen.zsh

### Antigen Bundles
antigen bundle lukechilds/zsh-better-npm-completion
antigen bundle chrissicool/zsh-256color
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle zsh-users/zsh-completions
antigen bundle command-not-found # Guess what to install when running an unknown command
antigen bundle common-aliases  # a starting point for aliases. Know what these are then override as necessary.
antigen bundle djui/alias-tips
antigen bundle git
antigen bundle heroku
antigen bundle extract # Helper for extracting different types of archives
antigen bundle zlsun/solarized-man

# those should be last ones
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
# antigen bundle zsh-users/zsh-autosuggestions # slows down terminal it seems

### Antigen Themes
# antigen bundle mafredri/zsh-async
# antigen bundle marszall87/lambda-pure
# antigen bundle sindresorhus/pure
# antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship
antigen theme NelsonBrandao/absolute absolute

## let antigen know we re finished
antigen apply

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  archlinux # https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/archlinux
)

source $ZSH/oh-my-zsh.sh

# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/work/Programming"
alias h="history"
alias work='cd /work/'
alias keybhr='setxkbmap hr'
alias keybus='setxkbmap us'
alias rem-orphans=' pacman -Rs $(pacman -Qqdt)'
# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# Set custom aliases
alias c="clear"
alias ping=" ping -c 5"
alias view="viewnior"
alias mkdir="mkdir -p"
alias sudo="sudo " #makes sudo recognize aliases.
alias nxt="playerctl -p spotify next"
alias prv="playerctl -p spotify previous"
alias pp="playerctl -p spotify play-pause"

# Git aliases
alias gst='git status --short --branch'
alias gpoh='git push origin HEAD'
alias gits='git status -uno'
# View abbreviated SHA, description, history graph, time and author
alias glog='git log --color --graph --date=iso --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci) %C(bold blue)<%an>%Creset" --abbrev-commit --'

# Editors
alias sudoCode='sudo code --user-data-dir=~/.config/Code/'
alias bootservices="systemctl list-unit-files | grep enabled"

alias la=" ls --almost-all"
alias l='ls -l --group-directories-first --color=auto -F'
alias ll='ls -lha --group-directories-first --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'
alias fixit='sudo rm -f /var/lib/pacman/db.lck && sudo pacman-mirrors -g && sudo pacman -Syyuu  && sudo pacman -Suu'

#SYSTEM RELATED ALIASES :
alias start="sudo systemctl start"
alias restart="sudo systemctl restart"
alias status="sudo systemctl status"
alias stop="sudo systemctl stop"
alias view_recent_alerts='sudo journalctl -p err..alert -b'
alias sys-info='inxi -Fxz'
# happens so often that it requires alias on its own...
alias dock-restart='pkill dde-dock & dde-dock'


# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Yarn aliases
alias ya="yarn add"
alias yrm="yarn remove"
alias yanl="yarn add --no-lockfile"
alias yrn="yarn run"
alias ycc="yarn cache clean"
alias yh="yarn help"
alias yo="yarn outdated"
alias yui="yarn upgrade-interactive"

# Docker
alias dockerps='docker ps --format=$FORMAT'
alias dockerconc='docker ps -aq --no-trunc | xargs docker rm'
alias dockerLamp='docker run -v /work/Docker:/var/www/example.com/public_html -p 80:80 -t -i linode/lamp /bin/bash'
alias dklc='docker ps -l'  # List last Docker container
alias dklcid='docker ps -l -q'  # List last Docker container ID
alias dklcip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)'  # Get IP of last Docker container
alias dkps='docker ps'  # List running Docker containers
alias dkpsa='docker ps -a'  # List all Docker containers
alias dki='docker images'  # List Docker images
alias dkrmac='docker rm $(docker ps -a -q)'  # Delete all Docker containers
alias dkrmlc='docker-remove-most-recent-container'  # Delete most recent (i.e., last) Docker container
alias dkrmui='docker images -q -f dangling=true |xargs -r docker rmi'  # Delete all untagged Docker images
alias dkrmall='docker-remove-stale-assets'  # Delete all untagged images and exited containers
alias dkrmli='docker-remove-most-recent-image'  # Delete most recent (i.e., last) Docker image
alias dkrmi='docker-remove-images'  # Delete images for supplied IDs or all if no IDs are passed as arguments
alias dkideps='docker-image-dependencies'  # Output a graph of image dependencies using Graphiz
alias dkre='docker-runtime-environment'  # List environmental variables of the supplied image ID
alias dkelc='docker exec -it `dklcid` bash' # Enter last container (works with Docker 1.3 and above)

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

srcr() {
	local cache="$ZSH_CACHE_DIR"
	autoload -U compinit zrecompile
	compinit -i -d "$cache/zcomp-$HOST"

	for f in ~/.zshrc "$cache/zcomp-$HOST"; do
		zrecompile -p $f && command rm -f $f.zwc.old
	done

	# Use $SHELL if available; remove leading dash if login shell
	[[ -n "$SHELL" ]] && exec ${SHELL#-} || exec zsh
}

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder



# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
