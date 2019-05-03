# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/work/Programming"
alias -- -="cd -" #
alias roj="cd ~/Projects"

alias ls='ls -G'

alias tree='tree -C -I $(git check-ignore * 2>/dev/null | tr "\n" "|").git'
alias brewup='brew update && brew upgrade'
alias fact="elinks -dump randomfunfacts.com | sed -n '/^| /p' | tr -d \|"

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'
# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# those are for linux
alias h="history"
alias work='cd /work/'
alias keybhr='setxkbmap hr'
alias keybus='setxkbmap us'
alias rem-orphans=' pacman -Rs $(pacman -Qqdt)'
alias nxt="playerctl -p spotify next"
alias prv="playerctl -p spotify previous"
alias pp="playerctl -p spotify play-pause"
alias bootservices="systemctl list-unit-files | grep enabled"
alias fixit='sudo rm -f /var/lib/pacman/db.lck && sudo pacman-mirrors -g && sudo pacman -Syyuu  && sudo pacman -Suu'

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# Set custom aliases
alias c="clear"
alias ping=" ping -c 5"
alias mkdir="mkdir -p"
alias sudo="sudo " #makes sudo recognize aliases.
alias help='tldr'
alias rmf='rm -rf'

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Git aliases
alias gst='git status --short --branch'
alias gpoh='git push origin HEAD'
alias gits='git status -uno'
alias gdi='git diff --ignore-all-space'
alias gdw='git diff --color-words'
alias gcu='git gc --aggressive' # Cleanup unnecessary files and optimize the local repository
alias glr='git rev-list --left-right --count master...' # Lists commit objects in reverse chronological order
alias gmb='git merge-base $(current_branch) master'  # Find as good common ancestors as possible for a merge
alias upfork='git fetch upstream; git checkout master; git merge upstream/master'
# View abbreviated SHA, description, history graph, time and author
alias glog='git log --color --graph --date=iso --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci) %C(bold blue)<%an>%Creset" --abbrev-commit --'
# Show a formatted commit tree
alias gtree="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias since='git log --oneline --decorate $(git merge-base --fork-point master)..HEAD'
# Show unmodified tracked files
alias gunm='echo -e "$(git ls-files --modified)\n$(git ls-files)" | sort | uniq -u'
# Nuke files from repo history
alias gnuke='sh ~/.dotfiles/scripts/git-nuke.sh'

alias nvp='npm version patch'

# Editors
alias sudoCode='sudo code --user-data-dir=~/.config/Code/'

alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

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
alias myip='ipconfig getifaddr en1 || ipconfig getifaddr en0'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Yarn aliases
alias ya="yarn add"
alias yrm="yarn remove"
alias yanl="yarn add --no-lockfile"
alias yrn="yarn run"
alias ycc="yarn cache clean"
alias yh="yarn help"
alias yo="yarn outdated"
alias yui="yarn upgrade-interactive"

# colored man
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        PAGER="${commands[less]:-$PAGER}" \
        _NROFF_U=1 \
        PATH="$HOME/bin:$PATH" \
            man "$@"
}

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
