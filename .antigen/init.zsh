#-- START ZCACHE GENERATED FILE
#-- GENERATED: Tue Aug 22 19:39:09 CEST 2017
#-- ANTIGEN v2.0.2
_antigen () {
	local -a _1st_arguments
	_1st_arguments=('apply:Load all bundle completions' 'bundle:Install and load the given plugin' 'bundles:Bulk define bundles' 'cleanup:Clean up the clones of repos which are not used by any bundles currently loaded' 'cache-gen:Generate cache' 'init:Load Antigen configuration from file' 'list:List out the currently loaded bundles' 'purge:Remove a cloned bundle from filesystem' 'reset:Clears cache' 'restore:Restore the bundles state as specified in the snapshot' 'revert:Revert the state of all bundles to how they were before the last antigen update' 'selfupdate:Update antigen itself' 'snapshot:Create a snapshot of all the active clones' 'theme:Switch the prompt theme' 'update:Update all bundles' 'use:Load any (supported) zsh pre-packaged framework') 
	_1st_arguments+=('help:Show this message' 'version:Display Antigen version') 
	__bundle () {
		_arguments '--loc[Path to the location <path-to/location>]' '--url[Path to the repository <github-account/repository>]' '--branch[Git branch name]' '--no-local-clone[Do not create a clone]'
	}
	__list () {
		_arguments '--simple[Show only bundle name]' '--short[Show only bundle name and branch]' '--long[Show bundle records]'
	}
	__cleanup () {
		_arguments '--force[Do not ask for confirmation]'
	}
	_arguments '*:: :->command'
	if (( CURRENT == 1 ))
	then
		_describe -t commands "antigen command" _1st_arguments
		return
	fi
	local -a _command_args
	case "$words[1]" in
		(bundle) __bundle ;;
		(use) compadd "$@" "oh-my-zsh" "prezto" ;;
		(cleanup) __cleanup ;;
		(update|purge) compadd $(type -f \-antigen-get-bundles &> /dev/null || antigen &> /dev/null; -antigen-get-bundles --simple 2> /dev/null) ;;
		(theme) compadd $(type -f \-antigen-get-themes &> /dev/null || antigen &> /dev/null; -antigen-get-themes 2> /dev/null) ;;
		(list) __list ;;
	esac
}
antigen () {
  [[ "$ZSH_EVAL_CONTEXT" =~ "toplevel:*" || "$ZSH_EVAL_CONTEXT" =~ "cmdarg:*" ]] && source "/home/puritanic/Dotfiles/antigen.zsh" && eval antigen $@;
  return 0;
}
fpath+=(/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib /home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/common-aliases /home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/archlinux /home/puritanic/.antigen/bundles/qianxinfeng/vscode /home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/git /home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found /home/puritanic/.antigen/bundles/djui/alias-tips /home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/heroku /home/puritanic/.antigen/bundles/zsh-users/zsh-syntax-highlighting /home/puritanic/.antigen/bundles/zsh-users/zsh-history-substring-search /home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/dotenv /home/puritanic/.antigen/bundles/unixorn/autoupdate-antigen.zshplugin /home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract /home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/npm /home/puritanic/.antigen/bundles/zlsun/solarized-man); PATH="$PATH:/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/heroku"
_antigen_compinit () {
  autoload -Uz compinit; compinit -C -d "/home/puritanic/.antigen/.zcompdump"; compdef _antigen antigen
  add-zsh-hook -D precmd _antigen_compinit
}
autoload -Uz add-zsh-hook; add-zsh-hook precmd _antigen_compinit
compdef () {}
ZSH="/home/puritanic/.oh-my-zsh" ZSH_CACHE_DIR="/home/puritanic/.oh-my-zsh/cache"
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/bzr.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/clipboard.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/compfix.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/completion.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/correction.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/diagnostics.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/directories.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/functions.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/git.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/grep.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/history.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/key-bindings.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/misc.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/nvm.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/prompt_info_functions.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/spectrum.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/termsupport.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/lib/theme-and-appearance.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/common-aliases/common-aliases.plugin.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/archlinux/archlinux.plugin.zsh";
source "/home/puritanic/.antigen/bundles/qianxinfeng/vscode/vscode.plugin.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/git/git.plugin.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh";
source "/home/puritanic/.antigen/bundles/djui/alias-tips/alias-tips.plugin.zsh";
source "/home/puritanic/.antigen/bundles/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh";
source "/home/puritanic/.antigen/bundles/zsh-users/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/dotenv/dotenv.plugin.zsh";
source "/home/puritanic/.antigen/bundles/unixorn/autoupdate-antigen.zshplugin/autoupdate-antigen.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract/extract.plugin.zsh";
source "/home/puritanic/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/npm/npm.plugin.zsh";
#-- SOURCE: /home/puritanic/.antigen/bundles/NelsonBrandao/absolute/absolute.zsh-theme
# The prompt
PROMPT=' $(_user_host)$(_current_path)$(git_prompt_info) $(_arrow) '

# The right-hand prompt
RPROMPT='$(_prompt_nvm)$(git_prompt_status) $(_battery_power)$(_return_status)'

function _current_path() {
    echo "%{$fg_bold[green]%}%c%{$reset_color%}"
}

function _arrow() {
    echo "%{$fg_bold[blue]%}→%{$reset_color%}"
}

function _return_status() {
    echo " %{$fg_bold[red]%}%(?..↵)%{$reset_color%}"
}

function _prompt_nvm() {
  local node_version=$(nvm current)
  [[ -z "${node_version}" ]] || [[ ${node_version} = "none" ]] || [[ ${node_version} = "system" ]] && return

  echo "%{$fg_bold[green]%}‹\U2B22 ${node_version:1}›%{$reset_color%}"
}

function _battery_power() {
    local acpi=$(acpi)

    local state=`echo -n $acpi | awk '{print substr($3,0,length($3)-1)}'`
    [[ ! $state == "Discharging" ]] && return

    local bat_percent=`echo -n $acpi | awk '{print substr($4,0,length($4)-2)}'`
    [[ bat_percent -gt 0 ]] && local color=red
    [[ bat_percent -gt 10 ]] && local color=yellow
    [[ bat_percent -gt 30 ]] && local color=green
    echo " %{$fg_bold[$color]%}‹⚡$bat_percent%%›%{$reset_color%}"
}

function _user_host() {
  if [[ -n $SSH_CONNECTION ]]; then
    me="%n@%m"
  elif [[ $LOGNAME != $USER ]]; then
    me="%n"
  fi
  if [[ -n $me ]]; then
    echo "%{$fg[blue]%}$me%{$reset_color%}:"
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%}:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_RENAMED=""

ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[yellow]%} ◒"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%} ✖"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[blue]%} §"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[cyan]%}⇡ "
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[cyan]%}⇣ "
;#-- END SOURCE
source "/home/puritanic/.antigen/bundles/zlsun/solarized-man/solarized-man.plugin.zsh";
typeset -aU _ANTIGEN_BUNDLE_RECORD;      _ANTIGEN_BUNDLE_RECORD=('https://github.com/robbyrussell/oh-my-zsh.git lib plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/common-aliases plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/archlinux plugin true' 'https://github.com/qianxinfeng/vscode / plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/git plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/command-not-found plugin true' 'https://github.com/djui/alias-tips.git / plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/heroku plugin true' 'https://github.com/zsh-users/zsh-syntax-highlighting.git / plugin true' 'https://github.com/zsh-users/zsh-history-substring-search.git / plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/dotenv plugin true' 'https://github.com/unixorn/autoupdate-antigen.zshplugin.git / plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/extract plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/npm plugin true' 'https://github.com/NelsonBrandao/absolute.git absolute.zsh-theme theme true' 'https://github.com/zlsun/solarized-man.git / plugin true')
_ANTIGEN_CACHE_LOADED=true ANTIGEN_CACHE_VERSION='v2.0.2'
#-- END ZCACHE GENERATED FILE

