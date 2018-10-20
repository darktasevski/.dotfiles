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

alias nvp='npm version patch'

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
