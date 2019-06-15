#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd "$SCRIPT_DIR" > /dev/null

# Get some color codes for printing
source ../common_config/bash.d/colors.sh

if [[ ! -e ~/bin ]]; then
    mkdir ~/bin
fi

# millis
make install

# scripts
ln -sf scripts/* $HOME/bin/

# Dependencies for scripts
pip3 install smsutil
pip3 install requests

# Restore current directory of user
popd > /dev/null
