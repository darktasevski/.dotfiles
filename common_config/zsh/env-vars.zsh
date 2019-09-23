
if [[ $(uname) == 'Linux' ]]; then
	# Start X at login for Arch boxes
	if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]] ; then
		if hash startx 2>& /dev/null; then
			startx && logout
		fi
	fi
fi

if [[ $(uname) == 'Linux' ]]; then
	# Start X at login for Arch boxes
	if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]] ; then
		if hash startx 2>& /dev/null; then
			startx && logout
		fi
	fi
elif [[ $(uname) == 'Darwin' ]]; then
    if [ -x "$(command -v go)" ]; then
	    # Golang
        export GOPATH="${HOME}/.go"
        export GOROOT="$(brew --prefix golang)/libexec"
        export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
        test -d "${GOPATH}" || mkdir "${GOPATH}"
        test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"
        export PATH=$PATH:$GOPATH/bin
    fi
fi

export VISUAL='vim'
export EDITOR='vim'
export TERM="xterm-256color"

export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Point to Yarn global installs
export PATH="$PATH:$(yarn global bin)"

#https://github.com/keybase/keybase-issues/issues/2798
export GPG_TTY=$(tty)

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# no lag on normal / insert mode switch   # see http://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1
export GREP_COLOR='00;1;31'

# Removed export GREP_OPTIONS="--color=auto" (which is deprecated) and switched to aliases
# Always enable colored `grep` output`
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts "reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Tizen env vars
export PATH=/Users/banshee/tizen-studio/tools/ide/bin:$PATH
export PATH=/Users/banshee/tizen-studio/tools:$PATH
export PATH=/Users/banshee/tizen-studio/tools/emulator/bin:$PATH

export ANDROID_HOME=~/Library/Android/sdk
export ANDROID_NDK_HOME=~/Library/Android/sdk/ndk-bundle
export PATH=$PATH:$ANDROID_HOME:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_NDK_HOME

# LG webOS ares-cli - (it needs to be installed first)
export PATH=$PATH:/opt/webOS_TV_SDK/CLI/bin
