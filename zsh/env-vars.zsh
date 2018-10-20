# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

if [[ `uname` == 'Linux' ]]; then
	# Start X at login for Arch boxes
	if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]] ; then
		if hash startx 2>& /dev/null; then
			startx && logout
		fi
	fi

	# enable color support of ls and file types
	if [ "$TERM" != "dumb" ]; then
			eval "`dircolors -b ~/.config/dircolors/dircolorsrc_srs`"
			alias ls='ls --color=auto'
			alias grep='grep --color=auto'
	fi

	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
elif [[ `uname` == 'Darwin' ]]; then
	export NVM_DIR="$HOME/.nvm"
	. "/usr/local/opt/nvm/nvm.sh"
fi

# Point to Yarn global installs, enable if there are problems
export PATH="$PATH:$(yarn global bin)"

# Golang
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

export BROWSER=/usr/bin/chromium
export EDITOR='vim'
export GPG_TTY=$(tty)

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# no lag on normal / insert mode switch   # see http://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1

# color codes from http://www.termsys.demon.co.uk/vtansi.htm#colors
# 0 Reset all attributes
# 1 Bright
# 2 Dim
# 4 Underscore  
# 5 Blink
# 7 Reverse
# 8 Hidden
#
# Foreground Colours
# 30  Black
# 31  Red
# 32  Green
# 33  Yellow
# 34  Blue
# 35  Magenta
# 36  Cyan
# 37  White
#
# Background Colours
# 40  Black
# 41  Red
# 42  Green
# 43  Yellow
# 44  Blue
# 45  Magenta
# 46  Cyan
# 47  White
export GREP_COLOR='00;1;31'

# Always enable colored `grep` output.
export GREP_OPTIONS='--color=auto';