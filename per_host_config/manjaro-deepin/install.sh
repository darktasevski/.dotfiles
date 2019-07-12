# Get some color codes
source ../../common_config/bash.d/colors.sh

# Prepare pacman
sudo mkdir -p /root/.gnupg
sudo pacman-key --init && sudo pacman-key --populate archlinux manjaro && sudo pacman-key --refresh-keys
sudo pacman-db-upgrade && sync

# Remove packages
sudo pacman -R brasero 

# Configure Pacman mirrors to use local mirrors - then run a full system upgrade/update
# NOTE: edit country list as needed
sudo pacman-mirrors --country Germany,France,Austria && sudo pacman -Syyu

# Install YaY
sudo pacman -S git
git clone https://aur.archlinux.org/yay.git ~/.yay && cd ~/.yay && makepkg -si && cd - || exit

# Install zsh & oh-my-zsh
sudo pacman -S --noconfirm git zsh wget
# wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | bash
chsh -s "$(which zsh)"
# Do logout & login  

# Install official packages and dev tools
echo -e "$(blue Installing official packages and dev tools...)"
sudo pacman -S --noconfirm go ruby-irb plank shellcheck tmux openssh nethogs docker synapse vlc git zsh ttf-hack vim vim-runtime binutils make curl gcc fakeroot

echo -e "$(blue Installing python deps...)"
sudo pacman -S --noconfirm python2 python2-pip python-pip

# Install community packages
echo -e "$(blue Installing community packages...)"
yay -S --noconfirm ngrok elementary-icon-theme fasd firefox-developer-edition vscodium-bin dropbox postman-bin spotify

echo -e "$(blue Installing Codecs and multimedia plugins...)"
sudo pacman -S --noconfirm exfat-utils fuse-exfat a52dec faac faad2 flac jasper lame libdca libdv gst-libav libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore flashplugin libdvdcss libdvdread libdvdnav dvgrab

# Needed for Typescript support in CoC and YCM using tsserver
ts_cmd='npm install -g typescript'
if command -v npm > /dev/null 2>&1 ; then
    command -v tsc > /dev/null 2>&1 || bash -c "$ts_cmd"
else
    echo "Install NodeJS and run '$ts_cmd' to get TypeScript support in Vim"
fi

if command -v gem >> dev/null; then
    echo -e "$(blue Installing ruby gems ...)"
    sudo gem install bundler
    rbenv rehash
    bundle install
fi

if command -v yarn >> dev/null; then
    echo -e "$(blue Installing Node packages ...)"
    yarn global add gifify nodemon rimraf
fi

# Enable docker without sudo (don't need this right now)
# sudo groupadd docker
# sudo gpasswd -a "${USER}" docker
# sudo systemctl enable docker
# sudo systemctl start docker
# newgrp docker

# Install virtualbox
# sudo pacman -S linux316-headers
# sudo pacman -S virtualbox
