#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

# Just delegate down
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # BASH_SOURCE is the executed script path
pushd "$SCRIPT_DIR" >/dev/null

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

# Restore current directory of user
popd >/dev/null

# Re-read BASH settings
green "\n\n Remember to 'source ~/.zshrc and reboot the system'! \n\n"
