#!/usr/bin/env bash

if [[ -n "$BASH_VERSION" ]]; then
    # include .bashrc if it exists
    if [[ -f "$HOME/.bashrc" ]]; then
         # shellcheck disable=SC1090
		 echo "BASH dir included"
        . "$HOME/.bashrc"
    fi
fi

# Add the directory of Tizen .NET Command Line Tools to user path.
export PATH=/Users/banshee/Tizen/SDK/tools/ide/bin:$PATH
