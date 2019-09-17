#!/usr/bin/env bash
# Your machine name (hostname) will be in this file.
# The name must match one of the subdirectories in this dir
MACHINE_NAME_FILE="$HOME/.machine"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ ! -e ${MACHINE_NAME_FILE} ]]; then
   echo "No .machine file detected! I'll try to create one with hostname as machine name"
   touch  ~/.machine && echo "$(hostname)" > ~/.machine
fi

pushd "$SCRIPT_DIR" > /dev/null

if [[ ! -e ${MACHINE_NAME_FILE} ]]; then
    echo "Missing name of this machine in $MACHINE_NAME_FILE" >> /dev/stderr
    echo "Create it like this:" "echo my-computer-name > $MACHINE_NAME_FILE"
    exit 1
fi

MACHINE=$(cat "$MACHINE_NAME_FILE")

if [[ -e "$MACHINE" ]]; then
    echo "Setting up local settings for this machine"
    cd ${MACHINE}
    ln -sf `pwd`/bashrc.local "$HOME/.bashrc.local"
    ln -sf `pwd`/gitlocal "$HOME/.gitlocal"
    ln -sf `pwd`/vimrc.local "$HOME/.vimrc.local"
    [[ -e ./setup.sh ]] && chmod +x ./setup.sh && ./setup.sh

    echo "You might need to re-run the global setup as build tools might not have been available"
else
    echo "Missing local settings directory: $SCRIPT_DIR/$MACHINE" >> /dev/stderr
    exit 1
fi

rm ~/.machine

popd >> /dev/null
