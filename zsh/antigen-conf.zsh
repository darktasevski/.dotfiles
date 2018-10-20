
## Check if Antigen is installed
if [[ ! -d ~/.antigen ]]; then
  mkdir ~/.antigen
  curl -L git.io/antigen > ~/.antigen/antigen.zsh
fi

if [[ `uname` == 'Linux' ]]; then
	source /home/puritanic/.antigen/antigen.zsh
elif [[ `uname` == 'Darwin' ]]; then
	source /Users/puritanic/antigen.zsh
fi

GEOMETRY_SYMBOL_PROMPT="λ"        # default prompt symbol
GEOMETRY_SYMBOL_RPROMPT="⋙"                 # multiline prompts
GEOMETRY_SYMBOL_EXIT_VALUE="ϟ"              # displayed when exit value is != 0
GEOMETRY_SYMBOL_ROOT="Ω"                    # when logged in user is root

GEOMETRY_COLOR_EXIT_VALUE="magenta"         # prompt symbol color when exit value is != 0
GEOMETRY_COLOR_PROMPT="green"               # prompt symbol color
GEOMETRY_COLOR_ROOT="red"                   # root prompt symbol color
GEOMETRY_COLOR_DIR="blue"                   # current directory color

antigen use oh-my-zsh

### Antigen Bundles
# antigen bundle lukechilds/zsh-better-npm-completion
antigen bundle chrissicool/zsh-256color
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle zsh-users/zsh-completions
# antigen bundle command-not-found # Guess what to install when running an unknown command
antigen bundle common-aliases  # a starting point for aliases. Know what these are then override as necessary.
antigen bundle djui/alias-tips
antigen bundle git
antigen bundle heroku
# antigen bundle extract # Helper for extracting different types of archives
antigen bundle zlsun/solarized-man

# those should be last ones
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
# antigen bundle zsh-users/zsh-autosuggestions # slows down terminal it seems

### Antigen Themes
antigen theme geometry-zsh/geometry

## let antigen know we re finished
antigen apply