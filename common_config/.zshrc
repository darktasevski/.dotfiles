#!/bin/zsh
fortune | cowsay -f vader

# Re-use BASH aliases nad exports
source ~/.profile
source ~/.bash.d/aliases_and_functions.sh

source ~/.zsh/env-vars.zsh
source ~/.zsh/zsh-conf.zsh
source ~/.zsh/colors.zsh

# Zsh plugin manager (handles oh-my-zsh, etc)
# https://github.com/zplug/zplug
if [[ -e ~/.zplug/init.zsh ]]; then
    # Check if zplug is installed
    if [[ ! -d ~/.zplug ]]; then
        git clone https://github.com/zplug/zplug ~/.zplug
        source ~/.zplug/init.zsh && zplug update --self
    else
        source ~/.zplug/init.zsh
    fi
fi

##################################################
## Based on zplug Example section
## https://github.com/zplug/zplug#example
##################################################

# Load completion library for those sweet [tab] squares
zplug "lib/completion", from:oh-my-zsh

# Never got the oh-my-zsh version to work without manual configuration,
# zplug "rupa/z", use:z.sh

# Syntax highlighting for commands, load last
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3

zplug "chrissicool/zsh-256color", from:github

zplug "djui/alias-tips", from:github

zplug "zlsun/solarized-man", from:github

#zplug "plugins/git",   from:oh-my-zsh # Not sure if I need these

# Async for zsh, used by pure
#zplug "mafredri/zsh-async", from:github, defer:0
# Theme!
#zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -r -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load 

export PATH="/usr/local/sbin:$PATH"
