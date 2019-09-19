#!/bin/zsh
autoload -U promptinit; promptinit

export HISTFILE=~/.zsh_history
export HISTSIZE=100000 # The number of commands to save. C  an't be unset, like in bash
export SAVEHIST=100000 # needed in order to save it somewhere
export HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history.

setopt AUTO_CD
setopt correct
# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history
# Trim duplicated commands from the history before trimming unique commands.
setopt hist_expire_dups_first
# If you run the same command multiple times in a row, only add it to the history once.
setopt hist_ignore_dups

# Completion
setopt auto_menu
setopt always_to_end

# make tab complete work  - https://github.com/robbyrussell/oh-my-zsh/issues/943
# This will make it not show a list for single options
zstyle '*' single-ignored complete

 # OH-MY-ZSH SETTINGS (Define these before loading oh-my-zsh or it won't work)
export COMPLETION_WAITING_DOTS="true"

# Load Nerd Fonts
POWERLEVEL9K_MODE='nerdfont-complete'
# Customise the Powerlevel9k prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  dir # current working directory
#   custom_javascript # custom section
  vcs # version control system, such as git
  newline # starts a new line in your terminal
  status # shows a tick if the last command was successful or the return code if there was an error.
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# @see https://superuser.com/questions/417627/oh-my-zsh-history-completion
# bindkey '\e[A' history-beginning-search-backward
# bindkey '\e[B' history-beginning-search-forward

# To be used with "zsh-users/zsh-history-substring-search"
if zplug check zsh-users/zsh-history-substring-search; then
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi
