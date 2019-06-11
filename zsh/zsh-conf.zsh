autoload -U promptinit; promptinit

# optionally define some options
# PURE_CMD_MAX_EXEC_TIME=10
# prompt pure

# Set Spaceship ZSH as a prompt
# autoload -U promptinit; promptinit
# prompt spaceship

setopt AUTO_CD
setopt correct

HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history.
HISTSIZE=1000 # Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
SAVEHIST=1000
HISTFILE=~/.zsh_history

#man pages
# example: run-help crypt shows crypt man pages
autoload -U run-help
autoload run-help-git


# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Use zsh-completions if it exists
if [[ -d "/usr/local/share/zsh-completions" ]]; then
    fpath=(/usr/local/share/zsh-completions ${fpath})
fi

# make tab complete work  - https://github.com/robbyrussell/oh-my-zsh/issues/943
# This will make it not show a list for single options
zstyle '*' single-ignored complete

 # OH-MY-ZSH SETTINGS (Define these before loading oh-my-zsh or it won't work)
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
if [[ `uname` == 'Linux' ]]; then
  	plugins=(
		archlinux, # https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/archlinux
		colorize
	)
elif [[ `uname` == 'Darwin' ]]; then
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

# echo -n prints the line without starting a newline at the end of it
# ‘\ue781’ is the icon you want to display — it needs to be in quotes and start with \u to tell the shell to interpret it as a unicode escape sequence to print the icon rather than the four character code
# JavaScript is the text you want to be shown following the icon
# POWERLEVEL9K_CUSTOM_JAVASCRIPT="echo -n '\ue781' JavaScript"
# # background and foreground colors for custom prompt section
# # The values of the color names can be changed in iTerm2’s Preferences.
# POWERLEVEL9K_CUSTOM_JAVASCRIPT_FOREGROUND="black"
# POWERLEVEL9K_CUSTOM_JAVASCRIPT_BACKGROUND="yellow"

# POWERLEVEL9K_CUSTOM_PYTHON="echo -n '\uf81f' Python"
# POWERLEVEL9K_CUSTOM_PYTHON_FOREGROUND="black"
# POWERLEVEL9K_CUSTOM_PYTHON_BACKGROUND="blue"

# POWERLEVEL9K_CUSTOM_RUBY="echo -n '\ue21e' Ruby"
# POWERLEVEL9K_CUSTOM_RUBY_FOREGROUND="black"
# POWERLEVEL9K_CUSTOM_RUBY_BACKGROUND="red"

# Load Powerlevel9k theme for Zsh
source ~/.dotfiles/zsh/powerlevel9k/powerlevel9k.zsh-theme

