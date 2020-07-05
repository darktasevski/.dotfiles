#!/bin/zsh
autoload -U promptinit; promptinit

export HISTFILE=~/.zsh_history
export HISTSIZE=10000 # The number of commands to save. C  an't be unset, like in bash
export SAVEHIST=10000 # needed in order to save it somewhere

setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.

# Include dotfiles in globbing
# https://coderwall.com/p/rfwjlq
setopt globdots

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
# don't push multiple copies of the same directory onto the directory stack
setopt pushd_ignore_dups


# Completion
setopt auto_menu
setopt always_to_end

# make tab complete work  - https://github.com/robbyrussell/oh-my-zsh/issues/943
# This will make it not show a list for single options
zstyle '*' single-ignored complete

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
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
