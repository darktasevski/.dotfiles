autoload -U promptinit; promptinit

# optionally define some options
# PURE_CMD_MAX_EXEC_TIME=10
# prompt pure

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

setopt AUTO_CD
setopt correct

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

#man pages
# example: run-help crypt shows crypt man pages
autoload -U run-help
autoload run-help-git
# autoload run-help-svn
# autoload run-help-svk

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Use zsh-completions if it exists
if [[ -d "/usr/local/share/zsh-completions" ]]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
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

# source $ZSH/oh-my-zsh.sh/