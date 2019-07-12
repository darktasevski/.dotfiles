

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd "$SCRIPT_DIR" > /dev/null

# Get some color codes
source ../../common_config/bash.d/colors.sh

# make /usr/local owned by me
sudo chown -R "$(whoami)" /usr/local

echo -e "$(blue Installing local apps ...)"

suse_packages="git vim gcc-c++ zsh git-gui docker wireshark htop cmake stow make go go-doc libgit2-devel automake tmux rxvt-unicode urxvt-font-size libtool xclip"
#chrome_package="https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"

sudo zypper install -y $suse_packages
#sudo zypper install -y $chrome_package

# Install codecs
sudo zypper addrepo -f http://packman.inode.at/suse/openSUSE_Tumbleweed/ packman
sudo zypper addrepo -f http://packman.inode.at/suse/openSUSE_Tumbleweed/ packman
sudo zypper install -y ffmpeg lame gstreamer-plugins-bad gstreamer-plugins-ugly gstreamer-plugins-ugly-orig-addon gstreamer-plugins-libav libdvdcss2
sudo zypper dup --from http://packman.inode.at/suse/openSUSE_Tumbleweed/

# Golang dependencies
go get -u github.com/constabulary/gb/...
go get -u github.com/nsf/gocode
go get -u github.com/libgit2/git2go
go get -u github.com/zenazn/goji
go get -u github.com/davecgh/go-spew/spew
go get -u github.com/spf13/viper
go get -u github.com/google/go-github/github
go get -u github.com/garyburd/redigo/redis
go get -u github.com/Rafflecopter/golang-relyq/relyq
go get -u github.com/Rafflecopter/golang-relyq/storage/redis
go get -u github.com/bradfitz/gomemcache/memcache
curl https://glide.sh/get | sh

if ! command -v pip3 >> /dev/null; then
    echo -e "$(blue "Installing Pip3..")"
    curl https://bootstrap.pypa.io/get-pip.py | python3
fi

# if there are problems with pip, run curl https://bootstrap.pypa.io/get-pip.py | python3
pip3 install --upgrade pip

echo -e "$(blue Installing python packages ...)"
pip3 install -r python.local

echo -e "$(blue Installing ruby packages ...)"
while read -r line; do 
    if gem list -i "$line" > /dev/null; then
        continue
    fi
    sudo gem install "$line"; 
done < ruby.local 

# Install Yarn - used for instance by coc.vim
if ! command -v yarn >> /dev/null; then
    curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
fi

# install Github 'hub'
if ! command -v hub >> /dev/null; then
    echo -e "$(blue "Installing Github's Hub...")"
    VERSION="2.3.0-pre10"
    BASENAME="hub-linux-amd64-$VERSION"
    wget "https://github.com/github/hub/releases/download/v${VERSION}/${BASENAME}.tgz"
    tar xvzf "$BASENAME.tgz"
    cd "$BASENAME" || exit
    sudo ./install
    cd ..
    if ! command -v rimraf >> /dev/null; then
        rimraf "${BASENAME}"*
    else
        rm -rf "${BASENAME}"*
    fi
fi

# restore current directory
popd > /dev/null
