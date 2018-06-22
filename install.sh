#!/bin/bash

# Directories
mkdir -p ~/.config/fish
mkdir -p ~/.config/terminator

# VIM
ln -fs $PWD/vim/.vimrc ~/.vimrc

# Fish
ln -nfs $PWD/fish/functions ~/.config/fish/functions
ln -fs $PWD/fish/config.fish ~/.config/fish/config.fish

# Terminator
ln -fs $PWD/terminator/config ~/.config/terminator/config

# Midnight Commander
ln -nfs $PWD/mc ~/.config/mc

