#!/bin/bash

# exit on errors
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd "$SCRIPT_DIR" > /dev/null

# Get some color codes
source ../../common_config/bash.d/colors.sh

# Homebrew
if ! command -v brew > /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    brew update
fi

# CMake
#if ! which cmake > /dev/null; then
#    brew install cmake
#    echo "CMake was not installed earlier. Try rerunning the main setup to make sure everything is working"
#fi

blue "Installing local apps using Homebrew"

brew bundle

# Node Version Manager
if ! command -v n > /dev/null; then
    brew install n
    n latest
fi
