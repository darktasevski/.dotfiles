# Load configurations
if [ -d ~/.dotfiles/zsh ]; then
    source ~/.dotfiles/zsh/detect-os.zsh
    source ~/.dotfiles/zsh/env-vars.zsh
    source ~/.dotfiles/zsh/zsh-conf.zsh
    source ~/.dotfiles/zsh/colors.zsh
    source ~/.dotfiles/zsh/antigen-conf.zsh
    source ~/.dotfiles/zsh/aliases.zsh
    # source ~/.dotfiles/zsh/functions.zsh
    source ~/.dotfiles/zsh/git.zsh
else
    print "404: ZSH config directory not found"
fi