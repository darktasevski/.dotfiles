# Load configurations
if [ -f ./zsh ]; then
    source ./zsh/detect-os.zsh
    source ./zsh/env-vars.zsh
    source ./zsh/zsh-conf.zsh
    source ./zsh/colors.zsh
    source ./zsh/antigen-conf.zsh
    source ./zsh/aliases.zsh
    source ./zsh/functions.zsh
    source ./zsh/git.zsh
else
    print "404: ZSH config directory not found"
fi


