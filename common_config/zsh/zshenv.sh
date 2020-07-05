#!/usr/bin/env bash

if [[ $(uname) == 'Linux' ]]; then
	# Start X at login for Arch boxes
	if [[ -z "${DISPLAY}" ]] && [[ $(tty) = /dev/tty1 ]] ; then
		if hash startx 2>& /dev/null; then
			startx && logout
		fi
	fi
fi

# include self-made binaries and bin
# Needed for some of the utility functions in this rc file, therefore
# cannot be in the profile file, which is read later on
# Otherwise, we will for instance get "millis: command not found" on
# every new terminal, even though it is found on the CLI when testing
if [[ -d ~/.bin ]] ; then
    PATH=~/.bin:"${PATH}"
fi


export VISUAL='vim'
export EDITOR='vim'
export TERM="xterm-256color"
#https://github.com/keybase/keybase-issues/issues/2798
GPG_TTY=$(tty)
export GPG_TTY
# Prefer US English and use UTF-8.
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X'
# no lag on normal / insert mode switch   # see http://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1
export GREP_COLOR='00;1;31'
# Removed export GREP_OPTIONS="--color=auto" (which is deprecated) and switched to aliases
# Always enable colored `grep` output`
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias history="history -E "

export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

export ANDROID_HOME=~/Library/Android/sdk
export ANDROID_NDK_HOME=~/Library/Android/sdk/ndk-bundle
export DEVELOPMENT_TEAM_ID=PTN2UCVG43
# export FZF_DEFAULT_COMMAND='fd --type f'
# export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude ".git" .'
# export FZF_DEFAULT_COMMAND="$FZF_DEFAULT_COMMAND --color=always"
export FZF_DEFAULT_COMMAND='fd -t file -LH -E .git'
# fd --type file --follow --hidden --exclude .git --color=always

# https://myshittycode.com/2014/03/17/mac-os-x-setting-default-java-version/
# export JAVA_HOME="`/usr/libexec/java_home -v '1.8.0_221'`"

LOCAL_SBIN_PATH="/usr/local/sbin:$PATH"
PY_3_PATH="$HOME/Library/Python/3.7/bin:$PATH"
ANDROID_STUFF_PATH=${ANDROID_HOME}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_NDK_HOME}
YARN_PATH="$PATH:$(yarn global bin)" # Point to Yarn global installs
JENV_PATH="$HOME/.jenv/bin:$PATH"
RBENV_PATH=$HOME/.rbenv/bin
ARES_BIN_PATH=$PATH:/opt/webOS_TV_SDK/CLI/bin # LG webOS ares-cli - (it needs to be installed first)
TIZEN_STUFF_PATH=${HOME}/Tizen/SDK/tools/ide/bin:${HOME}/Tizen/SDK/tools:${HOME}/Tizen/SDK/tools/emulator/bin
RUBY_GEMS=/usr/local/lib/ruby/gems/2.7.0/bin

export LG_WEBOS_TV_SDK_HOME="/opt/webOS_TV_SDK"

export JENV_ROOT=/usr/local/opt/jenv

export PATH=$PATH:${YARN_PATH}:${ANDROID_STUFF_PATH}:${LOCAL_SBIN_PATH}:${PY_3_PATH}:${ARES_BIN_PATH}:${RUBY_GEMS}:$PATH

# Lazy load env variables, as those were adding 2 seconds to the shell startup time...
# @see https://frederic-hemberger.de/articles/speed-up-initial-zsh-startup-with-lazy-loading/
function tizen() {
    # Execute only once
    unfunction "$0"
    if ! command -v tizen > /dev/null; then
        export PATH=$PATH:${TIZEN_STUFF_PATH}
    fi

    # Else execute command with provided args
    $0 "$@"

    echo "tizen fn called"

    return 0;
}

function sdb() {
    unfunction "$0"
    if ! command -v sdb > /dev/null; then
        export PATH=$PATH:${TIZEN_STUFF_PATH}
    fi

    $0 "$@"

    return 0;
}

# check if I need to lazy load ruby also
function rbenv() {
    unfunction "$0"
    if ! command -v rbenv > /dev/null; then
        export PATH=$PATH:${RBENV_PATH}
    fi

    $0 "$@"

    return 0;
}

function jenv() {
    unfunction "$0"
    if ! command -v jenv > /dev/null; then
        export PATH=$PATH:${JENV_PATH}
    fi

    $0 "$@"

    return 0;
}

function go() {
    unfunction "$0"
    if [[ -x "$(command -v go)" ]]; then
        GO_WHICH=$(brew --prefix golang)

        export GOPATH="${HOME}/.go"
        export GOROOT="${GO_WHICH}/libexec"
        export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
    fi

    $0 "$@"

    return 0;
}

