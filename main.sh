#!/usr/bin/env bash

# Just delegate down
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # BASH_SOURCE is the executed script path
pushd "$SCRIPT_DIR" > /dev/null

# Init submodules
#git submodule init
#git submodule update

# Get some color codes for printing
source common_config/bash.d/colors.sh

echo -e "$(blue "Installing common_config setup")"
common_config/setup.sh

echo "Install config specific to this machine"
per_host_config/setup.sh

# Add the little `millis` util for cross-platform millisecond support
echo -e "$(blue "Adding bin and binary utilities")"
utils/setup.sh

# ============================
# Zsh setup
# ============================
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

rm ~/.zshrc
ln -sf "$SCRIPT_DIR"/common_config/.zshrc "$DEST"/.zshrc
chsh -s $(which zsh)
exec zsh

# Restore current directory of user
popd > /dev/null

# Re-read BASH settings
green "\n\n Remember to 'source ~/.zshrc'! \n\n"
