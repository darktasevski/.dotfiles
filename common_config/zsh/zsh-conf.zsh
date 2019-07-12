#!/bin/zsh
autoload -U promptinit; promptinit

setopt AUTO_CD
setopt correct

export HISTFILE=~/.zsh_history
export HISTSIZE=100000 # can't be unset, like in bash
export SAVEHIST=100000 # needed in order to save it somewhere
export HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history.

# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

# Use zsh-completions if it exists
if [[ -d "/usr/local/share/zsh-completions" ]]; then
    fpath=(/usr/local/share/zsh-completions "${fpath}")
fi

# make tab complete work  - https://github.com/robbyrussell/oh-my-zsh/issues/943
# This will make it not show a list for single options
zstyle '*' single-ignored complete

 # OH-MY-ZSH SETTINGS (Define these before loading oh-my-zsh or it won't work)
export COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
if [[ $(uname) == 'Linux' ]]; then
  	plugins=(
		archlinux, # https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/archlinux
		colorize
	)
elif [[ $(uname) == 'Darwin' ]]; then
 	plugins=(
		#osx # https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/osx
		colorize
	)
fi

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

