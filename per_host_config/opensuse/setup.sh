#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd "$SCRIPT_DIR" > /dev/null

# Get some color codes
source ../../common_config/bash.d/colors.sh

# make /usr/local owned by me
sudo chown -R "$(whoami)" /usr/local

echo -e "$(blue Installing local apps ...)"

rbenv_build_prerequisites="libyaml-devel ncurses-devel readline-devel zlib-devel"
suse_packages="go go-doc docker transmission wireshark redshift htop tmux rxvt-unicode urxvt-font-size xclip ShellCheck openssh nethogs fakeroot fasd fortune cowsay"
media_and_codecs="libxine2-codecs ffmpeg-3 gstreamer-plugins-bad gstreamer-plugins-bad-orig-addon gstreamer-plugins-base gstreamer-plugins-good gstreamer-plugins-good-extra gstreamer-plugins-libav gstreamer-plugins-qt5 gstreamer-plugins-ugly gstreamer-plugins-ugly-orig-addon vlc smplayer x264 x265 vlc-codecs vlc-codec-gstreamer ogmtools libavcodec58"
#chrome_package="https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"
# run an update
sudo zypper refresh && sudo zypper dup
sudo zypper install -yt pattern devel_basis devel_web devel_python3 devel_ruby # install the development tools bundles
sudo zypper install -y $suse_packages
sudo zypper install -y $rbenv_build_prerequisites
#sudo zypper install -y $chrome_package

sudo zypper ar -f  http://download.opensuse.org/repositories/M17N:/fonts/openSUSE_Tumbleweed fonts
sudo zypper ar -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/Essentials packman-essentials
sudo zypper ar -f http://opensuse-guide.org/repo/openSUSE_Tumbleweed/ libdvdcss # media codecs and stuff
sudo zypper dup --from packman-essentials --allow-vendor-change
sudo zypper dup --from libdvdcss --allow-vendor-change
sudo zypper ref # accept always and trust the signing key

sudo zypper install -y -from libdvdcss $media_and_codecs

# [TODO] Golang dependencies - need to add GO to path before I install these
#go get -u github.com/constabulary/gb/...
#go get -u github.com/nsf/gocode
##go get -u github.com/libgit2/git2go
#go get -u github.com/zenazn/goji
#go get -u github.com/davecgh/go-spew/spew
#go get -u github.com/spf13/viper
#go get -u github.com/google/go-github/github
#go get -u github.com/garyburd/redigo/redis
#go get -u github.com/Rafflecopter/golang-relyq/relyq
#go get -u github.com/Rafflecopter/golang-relyq/storage/redis
#go get -u github.com/bradfitz/gomemcache/memcache
#curl https://glide.sh/get | sh

if ! command -v pip3 >> /dev/null; then
    echo -e "$(blue "Installing Pip3..")"
    curl https://bootstrap.pypa.io/get-pip.py | python3
fi

# if there are problems with pip, run curl https://bootstrap.pypa.io/get-pip.py | python3
pip3 install --upgrade pip

echo -e "$(blue Installing python packages ...)"
sudo pip3 install -r python.local

#Install rbenv
if ! command -v rbenv >> /dev/null; then
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    (cd ~/.rbenv && src/configure && make -C src) # @see https://stackoverflow.com/a/10382170/7453363
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> "$HOME"/.zsh/zshenv.sh
    echo 'eval "$(rbenv init -)"' >> "$HOME"/.zshrc
    ~/.rbenv/bin/rbenv init
    export PATH="$HOME/.rbenv/bin:$PATH"
fi

echo -e "$(blue Installing ruby packages ...)"
if command -v gem >> /dev/null; then
    echo -e "$(blue Installing ruby gems ...)"
    sudo gem install bundler
    rbenv rehash
#   bundle install
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
    rm -rf "${BASENAME}"*
fi

# VsCodium install
rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
sudo tee -a /etc/zypp/repos.d/vscodium.repo << 'EOF'
    [gitlab.com_paulcarroty_vscodium_repo]
    name=gitlab.com_paulcarroty_vscodium_repo
    baseurl=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/rpms/
    enabled=1
    gpgcheck=1
    repo_gpgcheck=1
    gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
EOF

sudo zypper in codium

# restore current directory
popd > /dev/null
