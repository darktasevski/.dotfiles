
# To enable debug printing, just set the DEBUG environment variable
# You can then use `debug` or `t_debug` statements to echo debug info

# short circuit the sourcing for non-interactive shells
# http://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile
[[ $- != *i* ]] && return

################################################################################
# Prolog start
#
# These timer_* functions rely on a utility called `millis`
# @see https://gist.github.com/fatso83/86e94e91926d1311f3fa
################################################################################

# @see http://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
source "$HOME/.bash.d/core_utils.sh"

# include selfmade binaries and bin
# Needed for some of the utility functions in this rc file, therefore 
# cannot be in the profile file, which is read later on
# Otherwise, we will for instance get "millis: command not found" on
# every new terminal, even though it is found on the CLI when testing
if [[ -d ~/.bin ]] ; then
    PATH=~/.bin:"${PATH}"
fi


# For debugging info on timing
#timer_start_if_unset
timer_start
# To debug how long init takes, run "DEBUG=1 source-rc"

t_debug Executing "$HOME"/.bashrc

################################################################################
# Prolog finished
################################################################################

# create a constant variable
declare -x CLICOLOR
# User limits - limit the use of system-wide resources.
# -c stands for The maximum size of core files created.
ulimit -c unlimited
# @see https://ss64.com/bash/umask.html
umask 022

function read_config {
  if [[ -e "$1" ]]; then
      . "$1"
  else echo Missing "$1"
  fi
}

function read_config_if_exists {
  [[ -e "$1" ]] && . "$1" && t_debug Read "$1"
}

# Needed for the utility function "restore_path"
if [[ -z "${ORIGINAL_PATH}" ]]; then
        ORIGINAL_PATH="${PATH}"
fi

t_debug "Reading utility functions and aliases"
read_config "$HOME/.bash.d/aliases_and_functions.sh"

t_debug "Reading utils for git prompt"
read_config "$HOME/.bash.d/git-prompt.sh"

t_debug "Reading bash completion files"
for f in "${HOME}"/.bash_completion.d/*; do
    t_debug "$f"
    read_config "$f"
done

t_debug Reading color codes
read_config_if_exists "$HOME/.bash.d/colors.sh"

function set_prompt(){
    local user=$(green "\u")
    local host=$(dark_yellow "\h")
    local workdir=$(pink "\w")
    local gitbranch=$(dark_red \$\(__git_ps1  "\(%s\)" \))
    local at=$(dark_grey at)
    local in=$(dark_grey in)
    export PS1="\n${user} ${at} ${host} ${in} ${workdir} ${gitbranch}"$'\n\$ '
}

# Now set it. If any of these colors are later overridden, then just rerun `set_prompt`
# set_prompt

# Start ssh-agent
# This somehow started failing on OS X at some time, as `ssh-add -l`
# never exits with status 2, always 1
# The fix on OS X is simply to add the keys using the keychain like this: `ssh-add -K`
# Unsafe on shared machines: http://rabexc.org/posts/pitfalls-of-ssh-agents
ssh-add -l &>/dev/null
if [[ "$?" == 2 ]]; then
  test -r ~/.ssh-agent && \
    eval "$(<~/.ssh-agent)" >/dev/null

  ssh-add -l &>/dev/null
  if [[ "$?" == 2 ]]; then
    (umask 066; ssh-agent > ~/.ssh-agent)
    eval "$(<~/.ssh-agent)" >/dev/null
    ssh-add
  fi
fi


# From http://stackoverflow.com/questions/9457233/unlimited-bash-history
# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export PATH="/usr/local/bin:$PATH"
export PYTHONSTARTUP="$HOME/.pystartup"
export HISTCONTROL=ignoredups

export VISUAL='vim'
export EDITOR='vim'

if [[ -d ~/scripts ]] ; then
  echo "dark_yellow "Deprecated! Try to avoid ~/scripts in favor of ~/bin""
	PATH=~/scripts:"$PATH"
fi

# Z utility :-)
#read_config_if_exists "$HOME/.zplug/repos/rupa/z/z.sh"

t_debug "Reading local settings for this machine"
# This needs to be at the bottom to be able to override earlier settings/variables/functions
read_config_if_exists "$HOME/.bashrc.local"

if [[ -e "$HOME/.bulksms.auth" ]]; then
    . "$HOME/.bulksms.auth"
    export BULKSMS_ID 
    export BULKSMS_SECRET
fi

t_debug Finished bash setup

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
