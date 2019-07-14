#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# ============================
# Zsh setup
# ============================
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

rm ~/.zshrc
ln -sf "$SCRIPT_DIR"/common_config/.zshrc "$DEST"/.zshrc
chsh -s $(which zsh)
exec zsh -l