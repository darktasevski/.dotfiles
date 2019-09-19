
if [[ -n "$BASH_VERSION" ]]; then
    # include .bashrc if it exists
    if [[ -f "$HOME/.bashrc" ]]; then
        . "$HOME/.bashrc"
    fi
fi

# Add the directory of Tizen .NET Command Line Tools to user path.
export PATH=/Users/banshee/tizen-studio/tools/ide/bin:$PATH
