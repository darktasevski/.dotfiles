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
git clone https://aur.archlinux.org/yay.git ~/.yay && cd ~/.yay && makepkg -si && cd -

# Install zsh & oh-my-zsh
sudo pacman -S --noconfirm git zsh wget
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
# chsh -s $(which zsh)
# Do logout & login  

# Install official packages and dev tools
sudo pacman -S --noconfirm plank openssh nethogs python2 python2-pip python-pip ruby docker synapse vlc git zsh ttf-hack vim vim-runtime binutils make curl gcc fakeroot

# Install community packages
yay -S --noconfirm ngrok elementary-icon-theme fasd firefox-developer-edition vscodium-bin dropbox postman-bin spotify

# Install Codecs and multimedia plugins
sudo pacman -S exfat-utils fuse-exfat a52dec faac faad2 flac jasper lame libdca libdv gst-libav libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore flashplugin libdvdcss libdvdread libdvdnav dvgrab

# Enable docker without sudo
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo systemctl enable docker
sudo systemctl start docker
newgrp docker

# Install virtualbox
# sudo pacman -S linux316-headers
# sudo pacman -S virtualbox
