if [[ -n "$BASH_VERSION" ]]; then
    # include .bashrc if it exists
    if [[ -f "$HOME/.bashrc" ]]; then
        . "$HOME/.bashrc"
    fi
fi

# Ruby/RVM stuff
#export PATH="$PATH:$HOME/.rvm/bin" 
#[[ -s "$HOME/.rvm/bin/rvm" ]] && source "$HOME/.rvm/bin/rvm" # Load RVM into a shell session *as a function*

if [[ "$0" = "/usr/sbin/lightdm-session" && "$DESKTOP_SESSION" = "i3" ]]; then
    export $(gnome-keyring-daemon --start --components=ssh)
fi

# Add Rust stuff
export PATH="$HOME/.cargo/bin:$PATH"
