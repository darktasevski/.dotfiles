#!/usr/bin/env bash

MAIN_DIR="$HOME"
DEST="${MAIN_DIR}"
BASH_DIR="${MAIN_DIR}/.bash.d"
ZSH_DIR="${MAIN_DIR}/.zsh"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd "$SCRIPT_DIR" > /dev/null

source "$SCRIPT_DIR/bash.d/colors.sh"

if [[ ! -e "$MAIN_DIR" ]]; then
  echo Destination "${MAIN_DIR}" does not exist
  exit 1
fi

# ============================
# Create files and dirs
# ============================
if [[ ! -e "$BASH_DIR" ]]; then
  mkdir "${BASH_DIR}"
fi

if [[ ! -e "$ZSH_DIR" ]]; then
  mkdir "${ZSH_DIR}"
fi

if [[ -d "$DEST"/.bash_completion.d ]]; then
  rm -r "$DEST"/.bash_completion.d
fi

[[ ! -e "$DEST/.tmux" ]] && git clone https://github.com/gpakosz/.tmux.git "$DEST/.tmux";

# ============================
# Create symlinks
# ============================
for file in "$SCRIPT_DIR"/bash.d/*; do
  ln -sfv "$file" "${BASH_DIR}"/
done

for file in "$SCRIPT_DIR"/zsh/*; do
  ln -sfv "$file" "${ZSH_DIR}"/
done

for file in "$SCRIPT_DIR"/tmux/*.conf "$SCRIPT_DIR"/tmux/*.proj; do
  ln -sfv "$file" "${DEST}/.tmux/"
done

ln -sv "$SCRIPT_DIR"/bash_completion.d "$DEST"/.bash_completion.d
ln -sfv "$SCRIPT_DIR"/.profile "$DEST"/.profile
ln -sfv "$SCRIPT_DIR"/.bashrc "$DEST"/.bashrc
ln -sfv "$SCRIPT_DIR"/.gitconfig "$DEST"/.gitconfig
ln -sfv "$SCRIPT_DIR"/.gitignore_global "$DEST"/.gitignore_global
ln -sfv "$SCRIPT_DIR"/.gitattributes_global "$DEST"/.gitattributes_global
ln -sfv "$SCRIPT_DIR"/pystartup "$DEST"/.pystartup
ln -sfv "$DEST"/.tmux/.tmux.conf "$DEST"/.tmux.conf
ln -sfv "$DEST"/.tmux/.tmux.conf.local "$DEST"/.tmux.conf.local
ln -sfv "$SCRIPT_DIR"/.npmrc "$DEST"/.npmrc

# @see https://stackoverflow.com/a/17072017/7453363 for more OSs
if [[ "$(uname)" == "Darwin" ]]; then                        # Do something under Mac OS X platform
    echo  -n -e "$(blue "Installing OSX needful\n")"

    # Make sure everything under /usr/local belongs to the group admin; and
    # Make sure anyone from the group admin can write to anything under /usr/local.
    # This is not the greatest solution tho
#    chgrp -R admin /usr/local
#    chmod -R g+w /usr/local
#    chgrp -R admin /Library/Caches/Homebrew
#    chmod -R g+w /Library/Caches/Homebrew

    # This is a bit better one @see https://gist.github.com/irazasyed/7732946
    sudo chown -R $(whoami) $(brew --prefix)/*
    sudo mkdir -p /usr/local/sbin /usr/local/Frameworks
    sudo chown -R $(whoami) /usr/local/sbin /usr/local/Frameworks
    sudo install -d -o $(whoami) -g admin /usr/local/Frameworks

    if ! command -v zsh > /dev/null; then
        brew install zsh
    fi

    if ! command -v neovim > /dev/null; then
        brew install neovim
    fi
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then # Do something under GNU/Linux platform
    echo  -n -e "$(blue "Installing Linux needful\n")"
#    sudo pacman -Sy --noconfirm curl vim vim-runtime        # Manjaro
    sudo zypper install -y zsh vim neovim make               # openSUSE

    # ============================
    # Node.js, npm & yarn setup, only for linuxes, we're going to install those later via brew for osx
    # ============================

    # Install n - Node version manager
    if ! command -v n >> /dev/null; then
        curl -L https://git.io/n-install | N_PREFIX=~/.n bash
        # Export N_PREFIX here to make node/npm available to the rest of the script
        export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
    fi

    # Install yarn
    if ! command -v yarn >> /dev/null; then
        curl -o- -L https://yarnpkg.com/install.sh | bash
        export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
    fi
fi

# ============================
# Vim setup
# ============================

# Remove any existing symlink (or dir on mingw) - will fail if it is a dir
rm -rf "$DEST"/.vim 2>/dev/null

if [[ ! -e "$DEST"/.vim ]]; then
    ln -sf "$SCRIPT_DIR"/vim/dotvim "$DEST"/.vim
fi

ln -sf "$SCRIPT_DIR"/vim/vimrc "$DEST"/.vimrc

# Checks out the Vundle submodule
# git submodule update --init --recursive

echo  -n -e "$(blue "Installing all VIM plugins")"
echo -e "$(dark_grey "(might take some time the first time ... )")"
vim +PlugInstall +qall

# Vim Fugitive setup
vim -u NONE -c "helptags vim-fugitive/doc" -c q

# Install NeoVim config (we don't have to worry about XDG_CONFIG_HOME stuff
[[ ! -e "$DEST"/.config ]] && mkdir "$DEST/.config"
rm -rf ~/.config/nvim
ln -sf ~/.vim ~/.config/nvim
ln -sf ~/.vimrc ~/.config/nvim/init.vim

# ============================
# Zsh setup
# ============================
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
sudo bash -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

[[ ! -e "$DEST"/.zshrc ]] && rm "$DEST"/.zshrc
ln -sfv "$SCRIPT_DIR"/zshrc "$DEST"/.zshrc

# ============================
# ngrok config
# ============================
[[ ! -e "$DEST"/.ngrok2 ]] && mkdir "$DEST/.ngrok2"
ln -vsiF "${SCRIPT_DIR}"/ngrok.yml "${DEST}"/.ngrok2/ngrok.yml

popd > /dev/null
